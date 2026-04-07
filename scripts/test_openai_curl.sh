#!/usr/bin/env bash
# Smoke-test OpenAI Chat Completions with curl. Requires OPENAI_API_KEY in the environment.
set -euo pipefail

if [[ -z "${OPENAI_API_KEY:-}" ]]; then
  echo "ERROR: OPENAI_API_KEY is not set. Export it or load it from your .env." >&2
  exit 1
fi

MODEL="${OPENAI_TEST_MODEL:-gpt-4o-mini}"

# -sS: silent but show errors; do not use -f so error JSON bodies (4xx) are still printed
curl -sS "https://api.openai.com/v1/chat/completions" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${OPENAI_API_KEY}" \
  -d "{\"model\": \"${MODEL}\", \"messages\": [{\"role\": \"user\", \"content\": \"Reply with exactly: ok\"}], \"max_tokens\": 16}"
echo
