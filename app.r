library(shiny)
library(shinythemes)
library(shinyWidgets)
library(Benchmarking)
library(ggplot2)

#This is an application that performs a DEA analysis under all the DEA assumptions of CRS, FDH, VRS, IRS, DRS, and FDH+
#This application also determines the Peers and Lambdas under each of the above assumptions.

ui <- fluidPage(theme = shinytheme("lumen"),
  setBackgroundImage(src = "https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/3601401/300/200/m1/fpnw/wm0/vector-of-abstract-geometric-white-background-.jpg?1511111647&s=aa7ce548f27bed32810405594753530b"),
  h2("Data Envelopment Analysis Project", align = 'center'), 
  h6("*This is an application that performs a DEA analysis under all the DEA assumptions of CRS, FDH, VRS, IRS, DRS, and FDH+"),
  h6("*This application also determines the Peers and Lambdas under each of the above assumptions."),
  selectInput(inputId = "variable", label = " Choose DEA Model ",  
              choices = c("crs","fdh","vrs","irs","drs","fdh+"), selected = "null",selectize = T, width = 130, size = NULL),
  flowLayout(tableOutput("P"),tableOutput("L")), plotOutput("Plot" , width = "35%"))

server <- function(input, output, session) { 
  input_file <- data.frame(
    "x" = c(150,400,320,520,350,320),
    "y"= c(0.2,0.7,1.2,2.0,1.2,0.7))
    output$P <- renderTable({peers(dea(input_file$x,input_file$y, RTS = input$variable ))})
    output$L <- renderTable({lambda(dea(input_file$x,input_file$y, RTS = input$variable))})
    output$Plot <- renderPlot({dea.plot(input_file$x,input_file$y, RTS = input$variable , main = "Plot")})}
shinyApp(ui = ui, server = server)