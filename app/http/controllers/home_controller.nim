import std/asyncdispatch
import std/httpcore
import std/strutils
import basolato/controller
import ../views/pages/home_page

proc detectBaseUrl(request: Request): string =
  let hdr = request.headers
  let host = $hdr.getOrDefault("Host")
  var proto = $hdr.getOrDefault("X-Forwarded-Proto")

  if proto.len == 0:
    let forwarded = $hdr.getOrDefault("Forwarded")
    let forwardedLower = forwarded.toLowerAscii()
    if forwardedLower.contains("proto=https"):
      proto = "https"
    elif forwardedLower.contains("proto=http"):
      proto = "http"

  if proto.len == 0:
    if host.startsWith("localhost") or host.startsWith("127.0.0.1"):
      proto = "http"
    else:
      proto = "https"

  let normalizedProto = proto.split(",")[0].strip().toLowerAscii()
  if host.len == 0:
    return "https://nimmer.jp"

  return normalizedProto & "://" & host

proc index*(context: Context): Future[Response] {.async.} =
  let baseUrl = detectBaseUrl(context.request)
  return render(homePage(baseUrl))
