# NimmerJp

`Basolato + Nim + TailwindCSS` で作成した、Nim言語の日本コミュニティ向けホームページです。  
Cloud Run へデプロイできる構成を含みます。

## 必要環境

- Nim 2.x
- curl (Tailwind standalone CLI取得用)
- Docker (Cloud Run用コンテナビルド時)

## ローカル開発

```bash
cp .env.example .env
./scripts/setup.sh
nim c -r main.nim
```

初回だけ `./scripts/setup.sh` を実行してください。以降は `nim c -r main.nim` だけで起動できます。
（`nimble install` 単体は、未コミットのローカルプロジェクトで Nimble が VCS revision を解決できず失敗する場合があります）

起動後: `http://localhost:8080`

`PORT` は `config.nims` で `8080` 固定にしています（Cloud Run想定）。

## Tailwind CSS

```bash
./scripts/tailwind.sh watch
```

- 入力: `src/styles/tailwind.css`
- 出力: `public/css/tailwind.css`
- 初回実行時のみ `tools/bin/tailwindcss` に standalone バイナリを自動ダウンロード

## Cloud Run デプロイ

1. GCP プロジェクトを設定

```bash
gcloud config set project YOUR_PROJECT_ID
```

2. コンテナイメージをビルドして Artifact Registry へ push

```bash
gcloud builds submit --tag asia-northeast1-docker.pkg.dev/YOUR_PROJECT_ID/nimmerjp/web:latest
```

3. Cloud Run へデプロイ

```bash
gcloud run deploy nimmerjp \
  --image asia-northeast1-docker.pkg.dev/YOUR_PROJECT_ID/nimmerjp/web:latest \
  --region asia-northeast1 \
  --platform managed \
  --allow-unauthenticated \
  --set-env-vars SECRET_KEY="$(openssl rand -hex 32)"
```

## ディレクトリ構成

```text
.
├── app/http/controllers/home_controller.nim
├── app/http/views/pages/home_page.nim
├── public/css/tailwind.css
├── scripts/setup.sh
├── scripts/tailwind.sh
├── src/styles/tailwind.css
├── main.nim
├── nimmerjp.nimble
├── tailwind.config.js
└── Dockerfile
```
