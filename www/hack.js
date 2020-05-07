var socket_timeout_interval;
var n = 0;

$(document).on('shiny:connected', function(event) {
  socket_timeout_interval = setInterval(function() {
    Shiny.onInputChange('alive_count', n++);
  }, 2000);
  Shiny.setInputValue("testtext", "blablabla");
});

$(document).on('shiny:disconnected', function(event) {
  clearInterval(socket_timeout_interval);
});