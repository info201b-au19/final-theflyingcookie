library(shiny)
library("dplyr")
library("rsconnect")

source("../FinalDeliverable/ui.R")
source("../FinalDeliverable//server.R")


rsconnect::deployApp('../FinalDeliverable/')

shinyApp(ui = ui, server = my_server)
