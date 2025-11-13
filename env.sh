# usage: source env.sh
# 이 환경변수를 활성화하여 gemini-cli에 litellm proxy를 활성화하는 것이 목적.

export GOOGLE_GEMINI_BASE_URL="http://localhost:4000"
export GEMINI_API_KEY=sk-1234567890

echo GOOGLE_GEMINI_BASE_URL=$GOOGLE_GEMINI_BASE_URL
echo GEMINI_API_KEY=$GEMINI_API_KEY

# gemini 들어간 뒤 /auth -> sk-1234567890 입력
# gemini --model="gemini-2.5-flash-lite" -p "how are you?"
