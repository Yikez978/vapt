ready = ->
  $('.chosen-it').chosen()

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
