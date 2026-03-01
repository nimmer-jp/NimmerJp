import std/asyncdispatch
import std/strutils
import basolato/controller
import ../views/pages/home_page

proc detectBaseUrl(request: Request): string =
  let headers = request.headers
  let host: string = headers.getOrDefault("Host")
  var proto: string = headers.getOrDefault("X-Forwarded-Proto")

  if proto.len == 0:
    let forwarded = headers.getOrDefault("Forwarded").toLowerAscii()
    if forwarded.contains("proto=https"):
      proto = "https"
    elif forwarded.contains("proto=http"):
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

proc index*(context:Context, params:Params):Future[Response] {.async.} =
  discard params
  let baseUrl = detectBaseUrl(context.request)
  return render(homePage(baseUrl))
