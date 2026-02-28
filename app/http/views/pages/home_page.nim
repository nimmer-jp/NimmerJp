import basolato/view


proc homePage*():Component =
  tmpli"""
    <!DOCTYPE html>
    <html lang="ja">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nim Japan Community</title>
        <meta name="description" content="Nim言語の日本コミュニティ公式ホームページ。勉強会・資料・参加方法をまとめています。">
        <link rel="icon" href="/images/favicon.png" type="image/png">
        <meta property="og:title" content="Nim Japan Community">
        <meta property="og:description" content="Nim言語の日本コミュニティ公式ホームページ。勉強会・資料・参加方法をまとめています。">
        <meta property="og:type" content="website">
        <meta property="og:url" content="https://nimmer.jp/">
        <meta property="og:image" content="https://nimmer.jp/images/ogp.png">
        <meta name="twitter:card" content="summary_large_image">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;700;900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="/css/tailwind.css">
      </head>
      <body class="theme-grid min-h-screen bg-slate-950 text-slate-100">
        <header class="sticky top-0 z-20 border-b border-cyan-300/20 bg-slate-950/85 backdrop-blur">
          <div class="mx-auto flex w-full max-w-6xl items-center justify-between px-6 py-4">
            <a href="/" class="text-lg font-black tracking-wide text-cyan-300">Nim Japan Community</a>
            <nav class="hidden gap-6 text-sm font-medium text-slate-300 md:flex">
              <a href="#about" class="hover:text-cyan-300">Nimとは</a>
              <a href="#events" class="hover:text-cyan-300">イベント</a>
              <a href="#join" class="hover:text-cyan-300">参加方法</a>
            </nav>
          </div>
        </header>

        <main class="mx-auto w-full max-w-6xl px-6 pb-20 pt-10">
          <section class="relative overflow-hidden rounded-3xl border border-cyan-400/30 bg-slate-900/75 p-8 shadow-2xl shadow-cyan-950/40 md:p-12">
            <div class="pointer-events-none absolute -right-24 -top-24 h-64 w-64 rounded-full bg-cyan-400/25 blur-3xl"></div>
            <div class="pointer-events-none absolute -bottom-24 -left-24 h-72 w-72 rounded-full bg-emerald-400/20 blur-3xl"></div>
            
            <div class="relative z-10 flex flex-col-reverse items-center justify-between gap-10 md:flex-row md:gap-16">
              <div class="flex-1">
                <p class="inline-flex rounded-full border border-cyan-300/40 px-3 py-1 text-xs font-semibold tracking-widest text-cyan-200">
                  Nim in Japan
                </p>
                <h1 class="mt-4 max-w-3xl text-4xl font-black leading-tight text-white md:text-5xl">
                  <span class="text-cyan-300">Nim</span>
                  日本語コミュニティ
                </h1>
                <p class="mt-5 max-w-2xl text-base leading-relaxed text-slate-200 md:text-lg">
                  Nim日本コミュニティは、初心者から実務ユーザーまでがつながる学習・交流の場です。
                  オンライン勉強会、LT会、コード共有を通して、Nimの知見を日本語で蓄積しています。
                </p>
                <div class="mt-8 flex flex-col gap-3 sm:flex-row">
                  <a href="#join" class="inline-flex items-center justify-center rounded-xl bg-cyan-400 px-6 py-3 text-sm font-bold text-slate-950 shadow-[0_0_15px_rgba(34,211,238,0.4)] transition hover:bg-cyan-300 hover:shadow-[0_0_20px_rgba(34,211,238,0.6)]">
                    コミュニティに参加する
                  </a>
                  <a href="https://nim-lang.org/docs/tut1.html" class="inline-flex items-center justify-center rounded-xl border border-slate-600 px-6 py-3 text-sm font-semibold text-slate-100 transition hover:border-cyan-300 hover:text-cyan-200">
                    Nim公式チュートリアル
                  </a>
                </div>
              </div>
              <div class="w-48 shrink-0 md:w-64">
                <img src="/images/mascot.png" alt="Nim Japan Community Mascot - Shimaenaga" class="h-auto w-full transition-transform duration-500 hover:scale-105 drop-shadow-[0_0_25px_rgba(34,211,238,0.3)]">
              </div>
            </div>
          </section>

          <section id="about" class="mt-12 grid gap-5 md:grid-cols-3">
            <article class="card">
              <h2 class="card-title">読みやすい構文</h2>
              <p class="card-text">
                Pythonに近い読みやすさで、静的型付けと高い表現力を両立。
                学習コストを抑えつつ、規模の大きい開発にも対応できます。
              </p>
            </article>
            <article class="card">
              <h2 class="card-title">ネイティブ実行速度</h2>
              <p class="card-text">
                NimはC/C++/JSなどへコンパイルでき、実行性能と開発体験のバランスが高い言語です。
                サーバー・CLI・ツール開発に適しています。
              </p>
            </article>
            <article class="card">
              <h2 class="card-title">実践的な日本語情報</h2>
              <p class="card-text">
                ハンズオン資料、実装例、配信アーカイブを日本語で共有。
                初学者でも継続しやすい学習導線を整えています。
              </p>
            </article>
          </section>

          <section id="events" class="mt-12 grid gap-6 lg:grid-cols-2">
            <article class="card">
              <h2 class="card-title">次回イベント</h2>
              <ul class="space-y-4 text-slate-200">
                <li class="rounded-xl border border-slate-700/70 bg-slate-900/70 p-4">
                  <p class="text-xs font-semibold uppercase tracking-wide text-cyan-300">オンライン勉強会</p>
                  <p class="mt-1 text-lg font-bold text-white">Nim Web開発ハンズオン（Basolato入門）</p>
                  <p class="mt-1 text-sm text-slate-300">毎月第2土曜 20:00 JST / Discord開催</p>
                </li>
                <li class="rounded-xl border border-slate-700/70 bg-slate-900/70 p-4">
                  <p class="text-xs font-semibold uppercase tracking-wide text-emerald-300">LT Meetup</p>
                  <p class="mt-1 text-lg font-bold text-white">「最近作ったNimツール」共有会</p>
                  <p class="mt-1 text-sm text-slate-300">隔月開催 / 1人5分から参加OK</p>
                </li>
              </ul>
            </article>

            <article id="join" class="card">
              <h2 class="card-title">参加方法</h2>
              <ol class="space-y-3 text-sm text-slate-200">
                <li class="rounded-lg border border-slate-700/80 bg-slate-900/70 p-3">
                  1. Discordに参加し、自己紹介チャンネルでひとこと投稿
                </li>
                <li class="rounded-lg border border-slate-700/80 bg-slate-900/70 p-3">
                  2. `#beginner` または `#web-dev` で質問・相談
                </li>
                <li class="rounded-lg border border-slate-700/80 bg-slate-900/70 p-3">
                  3. 月例勉強会でコードを持ち寄ってディスカッション
                </li>
              </ol>
              <div class="mt-5 flex flex-wrap gap-3">
                <a href="https://nim-lang.org" class="rounded-lg border border-slate-600 px-4 py-2 text-xs font-semibold uppercase tracking-wide text-slate-100 hover:border-cyan-300 hover:text-cyan-200">
                  Nim公式
                </a>
                <a href="https://github.com/nim-lang/Nim" class="rounded-lg border border-slate-600 px-4 py-2 text-xs font-semibold uppercase tracking-wide text-slate-100 hover:border-cyan-300 hover:text-cyan-200">
                  GitHub
                </a>
                <a href="https://twitter.com/nim_lang" class="rounded-lg border border-slate-600 px-4 py-2 text-xs font-semibold uppercase tracking-wide text-slate-100 hover:border-cyan-300 hover:text-cyan-200">
                  X / @nim_lang
                </a>
              </div>
            </article>
          </section>
        </main>

        <footer class="border-t border-slate-800 bg-slate-950/90">
          <div class="mx-auto flex w-full max-w-6xl flex-col gap-2 px-6 py-6 text-sm text-slate-400 md:flex-row md:items-center md:justify-between">
            <p>Nim Japan Community</p>
            <p>Built with Basolato + Nim + TailwindCSS</p>
          </div>
        </footer>
      </body>
    </html>
  """
