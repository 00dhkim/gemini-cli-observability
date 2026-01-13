# Gemini CLI Observability Hands On

Gemini CLI 요청을 LiteLLM Proxy로 보내고, Proxy가 Google Gemini API로 트래픽을 전달하는 로컬 개발 환경입니다.
요청/응답 로그는 Phoenix에서 확인할 수 있습니다.

## 🚀 구성요소

* **LiteLLM Proxy**: OpenAI 호환 프록시. Google Gemini로 라우팅.
* **Phoenix**: LLM Observability UI.
* **Postgres**: Proxy 메타데이터 저장.
* **gemini-cli**: 개발자가 사용하는 CLI.

## 📁 주요 파일

* `docker-compose.yml` – Proxy / Phoenix / Postgres 실행
* `litellm_config.yaml` – 모델 alias 및 실제 Gemini 모델 ID 설정
* `.env` – Google API Key + Proxy Master Key
* `env.sh` – gemini-cli 환경변수 세팅

## ▶️ 실행 방법

### 1) Google AI Studio에서 API Key 발급

- https://aistudio.google.com/api-keys 에서 발급받은 후.
- `.env` 의 `GEMINI_API_KEY`에 입력

### 2) 컨테이너 실행

```bash
docker compose up -d
```

### 3) gemini-cli 프록시 환경 적용

```bash
source env.sh
```

### 4) 테스트

```bash
gemini
# /auth 들어간 뒤, sk-1234567890 입력 후 종료
gemini --model="gemini-2.5-flash-lite" -p "hello"
```

## 🔎 Observability

Phoenix UI:
👉 [http://localhost:6006](http://localhost:6006)

## 🧪 Proxy 직접 호출 테스트

```bash
curl -X POST "http://localhost:4000/v1beta/models/gemini-2.5-flash-lite:generateContent" \
  -H "Authorization: Bearer sk-1234567890" \
  -H "Content-Type: application/json" \
  -d '{"contents":[{"parts":[{"text":"hi"}],"role":"user"}]}'
```

## ❗ 문제 발생 시

* gemini-cli 모델명 ≠ `model_name` 이면 404/500 발생
* `.env`의 GEMINI_API_KEY가 실제 Google 키인지 확인
* LiteLLM 로그 확인

  ```bash
  docker logs -f litellm
  ```
