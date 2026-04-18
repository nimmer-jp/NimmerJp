import std/os
import std/strutils
import basolato
import app/http/controllers/home_controller

let routes = @[
  Route.get("/", home_controller.index),
]

serve(routes, Settings.new(
  host = getEnv("HOST", "0.0.0.0"),
  port = parseInt(getEnv("PORT", "8080"))
))
