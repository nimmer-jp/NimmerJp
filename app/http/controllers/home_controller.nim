import std/asyncdispatch
import basolato/controller
import ../views/pages/home_page


proc index*(context:Context, params:Params):Future[Response] {.async.} =
  discard context
  discard params
  return render(homePage())
