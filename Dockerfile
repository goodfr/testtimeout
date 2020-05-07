## Start with the official rocker image (lightweight Debian)
FROM rocker/shiny:3.6.0

## APP TEST ## 
# Install R packages required by your Shiny app
RUN R -e 'install.packages("shiny", repos="http://cloud.r-project.org")'

# Copy your Shiny app to /srv/shiny-server/myapp
COPY app.R /srv/shiny-server/app.R
# shiny::runApp(appDir = "/srv/shiny-server/app.R", port = 3838, display.mode = "showcase")
# include JS files
COPY www /srv/shiny-server/www
# to launch it and get the www file
# COPY run_app.R /srv/shiny-server/run_app.R

# INSTALLATION DES PRERREQUIS
RUN apt-get update && apt-get install -y  \
    nginx \
    openssl
# CONFIGURATION NGINX
COPY server.conf /etc/nginx/sites-enabled/shiny.conf
RUN rm /etc/nginx/sites-enabled/default

# EXPOSITION DE PORT & LANCEMENT DE CONTENEUR 
EXPOSE 80
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
COPY init_shiny.sh /init_shiny.sh
RUN chmod +x init_shiny.sh
ENTRYPOINT ["/entrypoint.sh"]