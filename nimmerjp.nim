import basolato
import app/http/controllers/home_controller

let routes = @[
  Route.get("/", home_controller.index),
]

serve(routes)
