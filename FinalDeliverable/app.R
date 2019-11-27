library(shiny)
library("dplyr")
library("rsconnect")

source("ui.R")
source("server.R")


rsconnect::deployApp('../FinalDeliverable/')

shinyApp(ui = ui, server = my_server)
