# Gemini CLI Observability Hands On

[한국어 README](README_ko.md)

A local development environment that sends Gemini CLI requests to a LiteLLM Proxy, which then forwards traffic to the Google Gemini API.
Request/response logs can be viewed in Phoenix.

## 🚀 Components

* **LiteLLM Proxy**: OpenAI-compatible proxy that routes requests to Google Gemini.
* **Phoenix**: LLM observability UI.
* **Postgres**: Stores proxy metadata.
* **gemini-cli**: CLI used by developers.

## 📁 Key Files

* `docker-compose.yml` – Runs Proxy / Phoenix / Postgres
* `litellm_config.yaml` – Defines model aliases and actual Gemini model IDs
* `.env` – Google API Key + Proxy Master Key
* `env.sh` – Environment variables for gemini-cli

## ▶️ How to Run

### 1) Generate an API Key from Google AI Studio

* Go to [https://aistudio.google.com/api-keys](https://aistudio.google.com/api-keys)
* Insert the key into `GEMINI_API_KEY` in `.env`

### 2) Start Containers

```bash
docker compose up -d
```

### 3) Apply gemini-cli Proxy Environment

```bash
source env.sh
```

### 4) Test

```bash
gemini
# Enter /auth, type sk-1234567890, then exit
gemini --model="gemini-2.5-flash-lite" -p "hello"
```

## 🔎 Observability

Phoenix UI:
👉 [http://localhost:6006](http://localhost:6006)

## 🧪 Test Calling the Proxy Directly

```bash
curl -X POST "http://localhost:4000/v1beta/models/gemini-2.5-flash-lite:generateContent" \
  -H "Authorization: Bearer sk-1234567890" \
  -H "Content-Type: application/json" \
  -d '{"contents":[{"parts":[{"text":"hi"}],"role":"user"}]}'
```

## ❗ Troubleshooting

* If the gemini-cli model name ≠ `model_name`, a 404/500 may occur.
* Ensure `GEMINI_API_KEY` in `.env` is a valid Google API key.
* Check LiteLLM logs:

  ```bash
  docker logs -f litellm
  ```
