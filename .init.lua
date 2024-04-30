package.path = package.path .. ";.lua/?.lua"

local h = require "html"
local fm = require "fullmoon"

fm.setRoute("/css/*.css", fm.serveAsset)

local INDEX = h.html {
   h.head {
      h.meta { charset = "utf-8" },
      h.meta { name = "viewport", content = "width=device-width, initial-scale=1" },
      h.meta { name = "color-scheme", content = "light dark" },
      h.link { rel = "stylesheet", href = "/css/pico.classless.jade.min.css" },
      h.title { "BeanMaker" },
   },
   h.body {
      h.main {
         h.get "content",
      },
   },
}

fm.setRoute("/", function()
   local body = h.div {
      h.h1 { "Hello World" },
      h.form {
         action = "/create",
         method = "POST",
         h.fieldset {
            h.label {
               "Name",
            },
            h.input { name = "name" },
         },
         h.input { type = "submit", value = "Finish" },
      },
   }

   h.render(INDEX, Write, { content = body })

   return fm.serveResponse(200)
end)

fm.setRoute({ "/create", method = "POST" }, function(r)
   for k, v in pairs(r) do
      Log(kLogError, k)
   end

   local body = h.div {
      h.h1 { "Sheet" },
      h.h2 { r.params.name },
   }

   h.render(INDEX, Write, { content = body })

   return fm.serveResponse(200)
end)

fm.run()
