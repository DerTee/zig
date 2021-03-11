#!/usr/bin/env bash
set -eo pipefail

repo=$(cd "$(dirname "$0")/.." && pwd)

bad_uuid=$(jq --raw-output '.exercises | .concept[], .practice[] | .uuid' \
    "$repo"/config.json | grep -vE \
    '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' || test 1)
if [ -n "$bad_uuid" ]; then
    echo "invalid UUIDs found! please correct these to be valid UUIDs:"
    echo "$bad_uuid"
    exit 1
fi
