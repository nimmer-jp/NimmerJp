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
nimble build
./nimmerjp
```

初回だけ `./scripts/setup.sh` を実行してください。  
以降は `nimble build` で `Tailwind CSS` と `Nim` バイナリをまとめてビルドできます。
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

## ホットリロード開発

```bash
nimble dev
```

- `Tailwind watch` と `Basolato hot reloading (ducere serve)` を同時に起動します。

## Cloud Run デプロイ

`deploy.sh` で一括デプロイできます。

```bash
sh deploy.sh
```

前提:

- `.env` に `SECRET_KEY` を設定済み
- `gcloud auth login` 済み

手動実行したい場合は `deploy.sh` の各コマンドを順に実行してください。

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
