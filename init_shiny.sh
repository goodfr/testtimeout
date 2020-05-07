#!/bin/sh
mkdir -p /var/log/shiny-server
chown shiny.shiny /var/log/shiny-server
# Rscript -e 'library(methods); shiny::runApp("/srv/shiny-server/myapp", 3838)'
# Rscript -e 'source("/srv/shiny-server/run_app.R")'
Rscript -e 'shiny::runApp(appDir = "/srv/shiny-server/app.R", port = 3838)'