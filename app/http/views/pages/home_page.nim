import basolato/view


proc homePage*(baseUrl = "https://nimmer.jp"): Component =
  let ogImageUrl = baseUrl & "/ogp.png?v=20260301"
  tmpli"""
    <!DOCTYPE html>
    <html lang="ja">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nim Japan Community</title>
        <meta name="description" content="Nim言語の日本コミュニティ公式ホームページ。勉強会・資料・参加方法をまとめています。">
        <meta name="keywords" content="Nim,Nim言語,Nim Japan,日本コミュニティ,プログラミング言語,勉強会,LT会">
        <meta name="robots" content="index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1">
        <link rel="canonical" href="$(baseUrl)/">
        <link rel="sitemap" type="application/xml" href="$(baseUrl)/sitemap.xml">
        <link rel="alternate" type="text/plain" href="$(baseUrl)/llms.txt" title="LLMs.txt">
        <link rel="icon" href="/images/favicon.png" type="image/png">
        <meta property="og:title" content="Nim Japan Community">
        <meta property="og:description" content="Nim言語の日本コミュニティ公式ホームページ。勉強会・資料・参加方法をまとめています。">
        <meta property="og:type" content="website">
        <meta property="og:url" content="$(baseUrl)/">
        <meta property="og:image" content="$(ogImageUrl)">
        <meta property="og:image:secure_url" content="$(ogImageUrl)">
        <meta property="og:image:type" content="image/png">
        <meta property="og:image:width" content="500">
        <meta property="og:image:height" content="500">
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="Nim Japan Community">
        <meta name="twitter:description" content="Nim言語の日本コミュニティ公式ホームページ。勉強会・資料・参加方法をまとめています。">
        <meta name="twitter:image" content="$(ogImageUrl)">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;500;700;900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/github-dark.min.css">
        <link rel="stylesheet" href="/css/tailwind.css">
      </head>
      <body class="theme-grid min-h-screen bg-slate-950 text-slate-100">
        <header class="sticky top-0 z-20 border-b border-cyan-300/20 bg-slate-950/85 backdrop-blur">
          <div class="mx-auto flex w-full max-w-6xl items-center justify-between px-6 py-4">
            <a href="/" class="inline-flex items-center gap-2 text-lg font-black tracking-wide text-cyan-300">
              <img src="/images/favicon.png" alt="Nim Japan crown icon" class="h-7 w-7">
              <span>Nim Japan Community</span>
            </a>
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
                  <br class="md:hidden">
                  日本コミュニティ
                </h1>
                <p class="mt-5 max-w-2xl text-base leading-relaxed text-slate-200 md:text-lg">
                  Nim日本コミュニティは、初心者から実務ユーザーまでがつながる学習・交流の場です。
                  オンライン勉強会、LT会、コード共有を通して、Nimの知見を日本語で蓄積しています。
                </p>
                <div class="mt-8 flex flex-col gap-3 sm:flex-row">
                  <a href="https://discord.gg/t4H8x7W7r9" class="inline-flex items-center justify-center rounded-xl bg-cyan-400 px-6 py-3 text-sm font-bold text-slate-950 shadow-[0_0_15px_rgba(34,211,238,0.4)] transition hover:bg-cyan-300 hover:shadow-[0_0_20px_rgba(34,211,238,0.6)]">
                    コミュニティに参加する
                  </a>
                  <a href="https://nim-lang.org" class="inline-flex items-center justify-center rounded-xl border border-slate-600 px-6 py-3 text-sm font-semibold text-slate-100 transition hover:border-cyan-300 hover:text-cyan-200">
                    Nim公式
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

          <div id="about" class="h-0"></div>
          <section class="mt-12 grid gap-5 md:grid-cols-3">
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
              <h2 class="card-title">実践的な日本語でのNim情報</h2>
              <p class="card-text">
                ハンズオン資料、実装例、配信アーカイブを日本語で共有。
                初学者でも継続しやすい学習導線を整えています。
              </p>
            </article>
            <article class="card min-w-0 md:col-span-3">
              <h2 class="card-title">Nim 記述サンプル</h2>
              <p class="card-text">
                Nimは読みやすい構文で、型安全と実行性能を両立できます。
              </p>
              <pre class="mt-4 w-full max-w-full overflow-x-auto rounded-xl border border-slate-700 bg-slate-950 pr-4 pl-4 text-sm text-slate-200">
                <code class="language-nim m-0">import std/strformat
  
type
  Person = object
    name: string
    age: Natural
  
let people = [
  Person(name: "John", age: 45),
  Person(name: "Kate", age: 30)
]
  
for person in people:
  echo(fmt"{person.name} is {person.age} years old")
  
iterator oddNumbers[Idx, T](a: array[Idx, T]): T =
  for x in a:
    if x mod 2 == 1:
      yield x
  
for odd in oddNumbers([3, 6, 9, 12, 15, 18]):
  echo odd
  
import macros, strutils
  
macro toLookupTable(data: static[string]): untyped =
  result = newTree(nnkBracket)
  for w in data.split(';'):
    result.add newLit(w)
  
const
  data = "mov;btc;cli;xor"
  opcodes = toLookupTable(data)
  
for o in opcodes:
  echo o
</code>
              </pre>
            </article>
          </section>

          <section id="events" class="mt-12 grid gap-6 lg:grid-cols-2">
            <article class="card">
              <h2 class="card-title mb-4">次回イベント</h2>
              <ul class="space-y-4 text-slate-200">
                <li class="rounded-xl border border-dashed border-slate-600/80 bg-slate-900/70 p-5">
                  <p class="text-xs font-semibold uppercase tracking-wide text-amber-300">Status</p>
                  <p class="mt-1 text-lg font-bold text-white">未定</p>
                  <p class="mt-2 text-sm text-slate-300">
                    次回イベントは調整中です。日程とテーマが決まり次第、ここに追加します。
                  </p>
                </li>
              </ul>
            </article>

            <article id="join" class="card">
              <h2 class="card-title mb-4">参加方法</h2>
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

          <section id="timeline" class="mt-12">
            <article class="card">
              <h2 class="card-title mb-3">Nim公式 X タイムライン</h2>
              <p class="mb-5 text-sm text-slate-300">
                Nim公式アカウントの最新投稿です。コミュニティでも話題共有に使ってください。
              </p>
              <div class="overflow-hidden rounded-xl border border-slate-700/80 bg-slate-900/70 p-2">
                <a
                  class="twitter-timeline"
                  data-theme="dark"
                  data-lang="ja"
                  data-height="560"
                  href="https://x.com/nim_lang"
                >
                  Posts by @nim_lang
                </a>
              </div>
            </article>
          </section>
        </main>

        <script defer src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>
        <script defer src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/languages/nim.min.js"></script>
        <script>
          document.addEventListener("DOMContentLoaded", function () {
            if (window.hljs) {
              window.hljs.highlightAll();
            }
          });
        </script>
        <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

        <footer class="border-t border-slate-800 bg-slate-950/90">
          <div class="mx-auto flex w-full max-w-6xl flex-col gap-2 px-6 py-6 text-sm text-slate-400 md:flex-row md:items-center md:justify-between">
            <p>Nim Japan Community</p>
            <p>Built with Basolato</p>
          </div>
        </footer>
      </body>
    </html>
  """
