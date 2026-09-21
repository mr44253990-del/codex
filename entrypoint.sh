#!/bin/sh
set -e

# Render থেকে আসা PORT এনভায়রনমেন্ট ভেরিয়েবল ব্যবহার
# (ডিফল্ট 8214, তবে Render সাধারণত 10000 দেয়)
export CODEX_WEB_HOST="${CODEX_WEB_HOST:-0.0.0.0}"
export CODEX_WEB_PORT="${PORT:-${CODEX_WEB_PORT:-8214}}"

echo "Starting Codex Web on ${CODEX_WEB_HOST}:${CODEX_WEB_PORT}"

# Codex Web চালু
exec codex-web
