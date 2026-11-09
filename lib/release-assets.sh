# shellcheck shell=bash
# The release assets: what GitHub holds and serves, and the upload. Sourced by
# update-formula.sh, and by test/release-assets.test.sh with gh and curl stubbed
# - so it defines functions only and publishes nothing when sourced.
# Needs TAG, TAP_REPO, TAP_PRIVATE, STAGING and BASE_URL set by the caller.

# The asset as GitHub serves it: to anyone (curl, as `brew install` fetches
# it) while the tap is public; while it is private (2026-10-19), to the
# owner's own gh login - nobody else can read it, and a plain download answers
# 404, whose sha256 is the empty string's.
served_sha() {
  local f="$1"
  if [ "$TAP_PRIVATE" = 1 ]; then
    local d
    d=$(mktemp -d)
    gh release download "$TAG" --repo "$TAP_REPO" --pattern "$f" --dir "$d" --clobber >/dev/null 2>&1 || true
    [ -f "$d/$f" ] && shasum -a 256 "$d/$f" | cut -d' ' -f1
    rm -rf "$d"
  else
    curl -fsSL "$BASE_URL/$f" 2>/dev/null | shasum -a 256 | cut -d' ' -f1 || true
  fi
}

# The asset's sha256 as GitHub RECORDS it (the release's own digest), or
# nothing when the release has no such asset. Read from the API, not
# downloaded: on 2026-11-09 GitHub held 1.43.0's bytes while its downloads came
# back empty for minutes, and a check that downloaded first read that as "not
# published" and uploaded the same 79 MB again.
recorded_sha() {
  local f="$1" digest
  digest=$(gh release view "$TAG" --repo "$TAP_REPO" --json assets \
    -q ".assets[] | select(.name == \"$f\") | .digest" 2>/dev/null || true)
  printf '%s' "${digest#sha256:}"
}

# Upload an asset unless GitHub already records the same bytes, then wait
# for it to be served as brew fetches it. Prints the local sha256.
sync_asset() {
  local f="$1"
  local local_sha recorded served attempt
  local_sha=$(shasum -a 256 "$STAGING/$f" | cut -d' ' -f1)

  if [ "$(recorded_sha "$f")" = "$local_sha" ]; then
    # GitHub's digest is of the bytes it stores, so it catches a truncated
    # upload as the download did - without depending on the download.
    echo "   = $f  already published, unchanged (GitHub's digest matches)" >&2
    printf '%s' "$local_sha"
    return 0
  fi

  echo "   ↑ $f  uploading…" >&2
  gh release upload "$TAG" "$STAGING/$f" --repo "$TAP_REPO" --clobber >/dev/null

  # GitHub reports state=uploaded before the download URL actually serves the
  # asset - verifying immediately gets a 404, whose sha256 is the hash of an
  # empty string (e3b0c442…). Retry with backoff rather than failing a release
  # over propagation lag.
  served=""
  for attempt in 1 2 3 4 5 6; do
    served=$(served_sha "$f")
    [ "$served" = "$local_sha" ] && break
    echo "   … $f  not served yet (attempt $attempt), waiting" >&2
    sleep $((attempt * ${ASSET_WAIT_SECONDS:-10}))
  done

  if [ "$served" != "$local_sha" ]; then
    recorded=$(recorded_sha "$f")
    if [ "$recorded" = "$local_sha" ] && { [ -z "$served" ] || [ "$served" = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" ]; }; then
      echo "❌ $f: GitHub holds the right bytes (its digest matches) but does not serve them yet." >&2
      echo "     Run this again in a few minutes: it will not upload $f again." >&2
    else
      echo "❌ $f: published asset does not match the local file after upload" >&2
      echo "     local     $local_sha" >&2
      echo "     recorded  ${recorded:-<none>}" >&2
      echo "     served    ${served:-<download failed>}" >&2
    fi
    exit 1
  fi
  echo "   ✓ $f  uploaded and verified" >&2
  printf '%s' "$local_sha"
}
