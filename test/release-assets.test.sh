#!/bin/bash
# pass and fail only echo, so A && pass || fail is an if-then-else here;
# the grep below looks for the literal $SCRIPT_DIR.
# shellcheck disable=SC2015,SC2016
# lib/release-assets.sh against a stubbed GitHub: no network, nothing
# published. Run: bash test/release-assets.test.sh
#
# 2026-11-09, 1.43.0's publish: GitHub held the right bytes, but its
# downloads came back empty for a few minutes. The check BEFORE the upload
# read that as "not published" and uploaded the file again, and the check
# after it failed the run calling the asset a mismatch - twice.
set -uo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FAILS=0
pass() { echo "  ✓ $1"; }
fail() { echo "  ✗ $1"; FAILS=$((FAILS + 1)); }

# A stubbed gh and curl, driven by files in $STUB:
#   recorded  the digest GitHub reports for the asset ("" = no such asset)
#   served    present: a download returns the staged bytes (or served_bytes)
#   uploads   one line per `gh release upload`
setup() {
  STUB=$(mktemp -d); export STUB
  mkdir -p "$STUB/bin" "$STUB/staging"
  printf 'the binary' > "$STUB/staging/bin-a"
  : > "$STUB/uploads"
  cat > "$STUB/bin/gh" <<'GH'
#!/bin/bash
case "$*" in
  *"release view"*) [ -s "$STUB/recorded" ] && cat "$STUB/recorded"; exit 0 ;;
  *"release upload"*) echo "$*" >> "$STUB/uploads"; [ -f "$STUB/serve_after_upload" ] && touch "$STUB/served"; exit 0 ;;
  *"release download"*) exit 1 ;;
esac
exit 0
GH
  cat > "$STUB/bin/curl" <<'CURL'
#!/bin/bash
[ -f "$STUB/served" ] || exit 22
if [ -f "$STUB/served_bytes" ]; then cat "$STUB/served_bytes"; else cat "$STUB/staging/bin-a"; fi
CURL
  chmod +x "$STUB/bin/gh" "$STUB/bin/curl"
  export PATH="$STUB/bin:$PATH"
  export TAG=v9.9.9 TAP_REPO=owner/tap TAP_PRIVATE=0 STAGING="$STUB/staging" BASE_URL=https://example.invalid/download ASSET_WAIT_SECONDS=0
  # shellcheck source=lib/release-assets.sh
  source "$HERE/../lib/release-assets.sh"
  LOCAL=$(shasum -a 256 "$STUB/staging/bin-a" | cut -d' ' -f1)
}
uploads() { wc -l < "$STUB/uploads" | tr -d ' '; }

echo "release-assets"

setup  # GitHub holds the same bytes; its download comes back empty
printf 'sha256:%s' "$LOCAL" > "$STUB/recorded"
out=$( (sync_asset bin-a) 2>"$STUB/err"); code=$?
[ "$code" = 0 ] && [ "$(uploads)" = 0 ] && [ "$out" = "$LOCAL" ] && grep -q "already published" "$STUB/err" \
  && pass "an asset GitHub already holds is not uploaded again, though its download comes back empty" \
  || fail "an asset GitHub already holds is not uploaded again (exit $code, $(uploads) upload(s)): $(cat "$STUB/err")"

setup  # nothing on GitHub yet; served once uploaded
touch "$STUB/serve_after_upload"
out=$( (sync_asset bin-a) 2>"$STUB/err"); code=$?
[ "$code" = 0 ] && [ "$(uploads)" = 1 ] && [ "$out" = "$LOCAL" ] && grep -q "uploaded and verified" "$STUB/err" \
  && pass "a missing asset is uploaded once and verified as served" \
  || fail "a missing asset is uploaded once and verified (exit $code, $(uploads) upload(s)): $(cat "$STUB/err")"

setup  # GitHub holds OTHER bytes: uploaded
printf 'sha256:%s' "0000000000000000000000000000000000000000000000000000000000000000" > "$STUB/recorded"
touch "$STUB/serve_after_upload"
(sync_asset bin-a) >/dev/null 2>"$STUB/err"; code=$?
[ "$code" = 0 ] && [ "$(uploads)" = 1 ] \
  && pass "an asset GitHub holds with other bytes is replaced" \
  || fail "an asset with other bytes is replaced (exit $code, $(uploads) upload(s)): $(cat "$STUB/err")"

setup  # uploaded, recorded right, but never served: fails, says a rerun will skip it
printf 'sha256:%s' "$LOCAL" > "$STUB/recorded.after"
cat > "$STUB/bin/gh" <<'GH'
#!/bin/bash
case "$*" in
  *"release view"*) [ -s "$STUB/recorded" ] && cat "$STUB/recorded"; exit 0 ;;
  *"release upload"*) echo "$*" >> "$STUB/uploads"; cp "$STUB/recorded.after" "$STUB/recorded"; exit 0 ;;
esac
exit 0
GH
(sync_asset bin-a) >/dev/null 2>"$STUB/err"; code=$?
[ "$code" != 0 ] && grep -q "GitHub holds the right bytes" "$STUB/err" && ! grep -q "does not match" "$STUB/err" \
  && pass "an upload GitHub holds but does not yet serve fails, saying a rerun will skip it - not a mismatch" \
  || fail "an upload held but not served is told apart from a mismatch (exit $code): $(cat "$STUB/err")"

setup  # served bytes differ after the upload (truncated): a mismatch
touch "$STUB/serve_after_upload"; printf 'the bin' > "$STUB/served_bytes"
(sync_asset bin-a) >/dev/null 2>"$STUB/err"; code=$?
[ "$code" != 0 ] && grep -q "does not match" "$STUB/err" \
  && pass "served bytes that differ from the local file fail as a mismatch" \
  || fail "served bytes that differ fail as a mismatch (exit $code): $(cat "$STUB/err")"

# The publish script uses these functions, not a copy of its own.
grep -q 'source "$SCRIPT_DIR/lib/release-assets.sh"' "$HERE/../update-formula.sh" && ! grep -qE '^(sync_asset|served_sha)\(\)' "$HERE/../update-formula.sh" \
  && pass "update-formula.sh sources lib/release-assets.sh and defines no copy" \
  || fail "update-formula.sh must source lib/release-assets.sh and define no sync_asset or served_sha of its own"

[ "$FAILS" = 0 ] && echo "all passed" || { echo "$FAILS failed"; exit 1; }
