version       = "0.1.0"
author        = "Nim Japan Community"
description   = "Nim language Japanese community homepage powered by Basolato + TailwindCSS"
license       = "MIT"
srcDir        = "."
bin           = @["nimmerjp"]
backend       = "c"

requires "nim >= 2.0.0"
# basolato is installed by ./scripts/setup.sh from GitHub directly.
# Keeping it out of `requires` avoids Nimble package index resolution issues.

before build:
  exec "./scripts/tailwind.sh build"

task css, "Build Tailwind CSS":
  exec "./scripts/tailwind.sh build"

task dev, "Run Tailwind watcher + Basolato hot reloading server":
  exec "./scripts/dev.sh"
