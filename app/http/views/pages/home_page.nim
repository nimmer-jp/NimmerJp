import std/json
import basolato/view

proc buildJsonLd(baseUrl, ogImageUrl, pageDescription: string): string =
  ## json.%* は @ で始まるキーでマクロ展開が壊れるため、JsonNode を明示構築する。
  var org = newJObject()
  org["@type"] = %*"Organization"
  org["@id"] = %(baseUrl & "/#organization")
  org["name"] = %*"Nim Japan Community"
  org["alternateName"] = %*"Nim日本コミュニティ"
  org["url"] = %(baseUrl & "/")
  org["description"] = %*"Nim言語の日本コミュニティ。勉強会・資料・参加方法をまとめた公式サイト。"
  var logo = newJObject()
  logo["@type"] = %*"ImageObject"
  logo["url"] = %(baseUrl & "/images/favicon.png")
  org["logo"] = logo
  org["image"] = %ogImageUrl
  var sameAs = newJArray()
  sameAs.add(%*"https://discord.gg/t4H8x7W7r9")
  org["sameAs"] = sameAs

  var site = newJObject()
  site["@type"] = %*"WebSite"
  site["@id"] = %(baseUrl & "/#website")
  site["url"] = %(baseUrl & "/")
  site["name"] = %*"Nim Japan Community"
  site["description"] = %pageDescription
  site["inLanguage"] = %*"ja-JP"
  var publisher = newJObject()
  publisher["@id"] = %(baseUrl & "/#organization")
  site["publisher"] = publisher

  var page = newJObject()
  page["@type"] = %*"WebPage"
  page["@id"] = %(baseUrl & "/#webpage")
  page["url"] = %(baseUrl & "/")
  page["name"] = %*"Nim Japan Community"
  page["description"] = %pageDescription
  page["inLanguage"] = %*"ja-JP"
  var isPartOf = newJObject()
  isPartOf["@id"] = %(baseUrl & "/#website")
  page["isPartOf"] = isPartOf
  var about = newJObject()
  about["@id"] = %(baseUrl & "/#organization")
  page["about"] = about
  var primaryImg = newJObject()
  primaryImg["@type"] = %*"ImageObject"
  primaryImg["url"] = %ogImageUrl
  page["primaryImageOfPage"] = primaryImg

  var graph = newJArray()
  graph.add(org)
  graph.add(site)
  graph.add(page)
  var root = newJObject()
  root["@context"] = %*"https://schema.org"
  root["@graph"] = graph
  return $root

proc homePage*(baseUrl = "https://nimmer.jp"): Component =
  let ogImageUrl = baseUrl & "/ogp.png?v=20260301"
  let pageDescription =
    "Nim言語の日本コミュニティ公式ホームページ。勉強会・資料・参加方法をまとめています。"
  let jsonLdStr = buildJsonLd(baseUrl, ogImageUrl, pageDescription)
  tmpl"""
    <!DOCTYPE html>
    <html lang="ja">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nim Japan Community</title>
        <meta name="description" content="$(pageDescription)">
        <meta name="keywords" content="Nim,Nim言語,Nim Japan,日本コミュニティ,プログラミング言語,勉強会,LT会">
        <meta name="robots" content="index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1">
        <link rel="canonical" href="$(baseUrl)/">
        <link rel="sitemap" type="application/xml" href="$(baseUrl)/sitemap.xml">
        <link rel="alternate" type="text/plain" href="$(baseUrl)/llms.txt" title="LLMs.txt">
        <link rel="icon" href="/images/favicon.png" type="image/png">
        <meta property="og:title" content="Nim Japan Community">
        <meta property="og:description" content="$(pageDescription)">
        <meta property="og:type" content="website">
        <meta property="og:url" content="$(baseUrl)/">
        <meta property="og:locale" content="ja_JP">
        <meta property="og:site_name" content="Nim Japan Community">
        <meta property="og:image" content="$(ogImageUrl)">
        <meta property="og:image:secure_url" content="$(ogImageUrl)">
        <meta property="og:image:type" content="image/png">
        <meta property="og:image:width" content="500">
        <meta property="og:image:height" content="500">
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="Nim Japan Community">
        <meta name="twitter:description" content="$(pageDescription)">
        <meta name="twitter:image" content="$(ogImageUrl)">
        <script type="application/ld+json">$(jsonLdStr|raw)</script>
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
              <a href="#community-repos" class="hover:text-cyan-300">nimmer-jp</a>
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

          <section id="community-repos" class="mt-16 md:mt-24">
            <div class="mb-10 text-center">
              <span class="inline-flex items-center gap-2 rounded-full border border-cyan-400/30 bg-cyan-950/40 px-3 py-1 text-xs font-semibold text-cyan-300">
                <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 24 24"><path fill-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clip-rule="evenodd"/></svg>
                Open Source
              </span>
              <h2 class="mt-4 text-3xl font-black text-white md:text-4xl">
                コミュニティプロジェクト
              </h2>
              <p class="mt-4 text-slate-300">
                nimmer-jp コミュニティで開発中の各種オープンソースプロジェクトです。<br class="hidden md:block">
                ぜひスターやコントリビュートでお気軽にご参加ください。
              </p>
            </div>
            
            <div class="grid gap-6 md:grid-cols-2">
              <!-- nimmer-jp -->
              <a href="https://github.com/nimmer-jp" target="_blank" rel="noopener noreferrer" class="group relative overflow-hidden rounded-2xl border border-slate-700/80 bg-slate-900/60 p-6 transition-all hover:-translate-y-1 hover:border-cyan-500/50 hover:shadow-lg hover:shadow-cyan-500/20 md:col-span-2">
                <div class="absolute -right-10 -top-10 h-32 w-32 rounded-full bg-cyan-500/10 blur-2xl transition-all group-hover:bg-cyan-500/20"></div>
                <div class="relative z-10 flex flex-col gap-4 md:flex-row md:items-center">
                  <div class="flex h-14 w-14 shrink-0 items-center justify-center rounded-xl border border-cyan-800/50 bg-cyan-950 text-cyan-400 shadow-inner">
                    <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z" /></svg>
                  </div>
                  <div class="flex-1">
                    <h3 class="text-xl font-bold text-white transition-colors group-hover:text-cyan-300">Nim in Japan (nimmer-jp)</h3>
                    <p class="mt-1 text-sm text-slate-400">コミュニティのオーガニゼーション。ここからすべてのプロジェクトが生まれています。オーガニゼーションへの参加も大歓迎です！</p>
                  </div>
                  <div class="hidden shrink-0 items-center text-cyan-400 md:flex">
                    <svg class="h-6 w-6 -translate-x-2 opacity-0 transition-all group-hover:translate-x-0 group-hover:opacity-100" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"/></svg>
                  </div>
                </div>
              </a>

              <!-- Crown -->
              <a href="https://github.com/nimmer-jp/crown" target="_blank" rel="noopener noreferrer" class="group relative overflow-hidden rounded-2xl border border-slate-700/80 bg-slate-900/60 p-6 transition-all hover:-translate-y-1 hover:border-indigo-500/50 hover:shadow-lg hover:shadow-indigo-500/20">
                <div class="absolute -right-10 -top-10 h-32 w-32 rounded-full bg-indigo-500/10 blur-2xl transition-all group-hover:bg-indigo-500/20"></div>
                <div class="mb-4 flex h-14 w-14 items-center justify-center rounded-xl border border-indigo-800/50 bg-indigo-950 text-indigo-400 shadow-inner">
                  <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" /></svg>
                </div>
                <h3 class="text-xl font-bold text-white transition-colors group-hover:text-indigo-300">Crown</h3>
                <p class="mt-2 text-sm text-slate-400">Next.jsライクなNim製フルスタックWebフレームワーク。ファイルベースルーティングやSSR/SSGなどをNimの快適な型安全性とともに実現します。</p>
              </a>

              <!-- Tiara -->
              <a href="https://github.com/nimmer-jp/tiara" target="_blank" rel="noopener noreferrer" class="group relative overflow-hidden rounded-2xl border border-slate-700/80 bg-slate-900/60 p-6 transition-all hover:-translate-y-1 hover:border-pink-500/50 hover:shadow-lg hover:shadow-pink-500/20">
                <div class="absolute -right-10 -top-10 h-32 w-32 rounded-full bg-pink-500/10 blur-2xl transition-all group-hover:bg-pink-500/20"></div>
                <div class="mb-4 flex h-14 w-14 items-center justify-center rounded-xl border border-pink-800/50 bg-pink-950 text-pink-400 shadow-inner">
                  <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" /></svg>
                </div>
                <h3 class="text-xl font-bold text-white transition-colors group-hover:text-pink-300">Tiara</h3>
                <p class="mt-2 text-sm text-slate-400">美しいUIコンポーネントライブラリ。Tailwind CSSベースで、Crownですぐに使える洗練されたモダンなデザインパーツを提供します。</p>
              </a>

              <!-- nimtra -->
              <a href="https://github.com/nimmer-jp/nimtra" target="_blank" rel="noopener noreferrer" class="group relative overflow-hidden rounded-2xl border border-slate-700/80 bg-slate-900/60 p-6 transition-all hover:-translate-y-1 hover:border-emerald-500/50 hover:shadow-lg hover:shadow-emerald-500/20">
                <div class="absolute -right-10 -top-10 h-32 w-32 rounded-full bg-emerald-500/10 blur-2xl transition-all group-hover:bg-emerald-500/20"></div>
                <div class="mb-4 flex h-14 w-14 items-center justify-center rounded-xl border border-emerald-800/50 bg-emerald-950 text-emerald-400 shadow-inner">
                  <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4m0 5c0 2.21-3.582 4-8 4s-8-1.79-8-4" /></svg>
                </div>
                <h3 class="text-xl font-bold text-white transition-colors group-hover:text-emerald-300">nimtra</h3>
                <p class="mt-2 text-sm text-slate-400">Nim製の強力で軽量なORM。型安全で直感的なデータベース操作を可能にし、堅牢なバックエンド開発をサポートします。</p>
              </a>

              <!-- nimchat -->
              <a href="https://github.com/nimmer-jp/nimchat" target="_blank" rel="noopener noreferrer" class="group relative overflow-hidden rounded-2xl border border-slate-700/80 bg-slate-900/60 p-6 transition-all hover:-translate-y-1 hover:border-amber-500/50 hover:shadow-lg hover:shadow-amber-500/20">
                <div class="absolute -right-10 -top-10 h-32 w-32 rounded-full bg-amber-500/10 blur-2xl transition-all group-hover:bg-amber-500/20"></div>
                <div class="mb-4 flex h-14 w-14 items-center justify-center rounded-xl border border-amber-800/50 bg-amber-950 text-amber-400 shadow-inner">
                  <svg class="h-7 w-7" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 10h.01M12 10h.01M16 10h.01M9 16H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-5l-5 5v-5z" /></svg>
                </div>
                <h3 class="text-xl font-bold text-white transition-colors group-hover:text-amber-300">nimchat</h3>
                <p class="mt-2 text-sm text-slate-400">Nim製のLLMチャットクライアント。OpenAIやAnthropicなどのAPIと連携し、日々のAIとのやりとりをより快適にします。</p>
              </a>
            </div>
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
