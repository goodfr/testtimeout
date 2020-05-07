library(shiny)

ui <- fluidPage(
  
  # tags$script(HTML(
  #   "document.body.style.backgroundColor = 'skyblue';"
  # )),
  
  tags$script(src = "style.js"),
  tags$script(src = "hack.js"), 
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "hack.css")
  ),
  
  br(), br(), br(),
  textOutput(outputId = "tt"),
  hr(),
  textOutput("keep_alive")
  , hr()
  , textOutput("moretest")
)

server <- function(input, output, session) {
  stime <- Sys.time()
  vtime <- reactiveVal("Base")
  observe({
    shiny::invalidateLater(millis = 2e3, session) ;
    
    tmp <- as.character( round( difftime(time1 = Sys.time(), time2 = stime, units = c("mins") ), 2 ) )
    vtime(paste("Time running app :", as.character(tmp) ) )
    
    print("\n --- This is input --- \n")
    print(utils::str( shiny::reactiveValuesToList(input) ) )
  })
  output$tt <- renderText(expr = { vtime() })
    output$keep_alive <- renderText({
    req(input$alive_count)
    input$alive_count
  })
    output$moretest <- renderText({input$testtext})
}

app <- shiny::shinyApp(ui, server)
# ,
#                 options = list("port" = 3838,
#                                "launch.browser" = TRUE,
#                                "display.mode" = "showcase") )

app
# shiny::runApp(app) # THIS DOES NOT ALLOW WWW FILES TO WORK
