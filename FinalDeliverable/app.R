# Loads required libraries
library("shiny")
library(rsconnect)

# Defines the UI value and server functions
source("app_ui.R")
source("app_server.R")

# Runs the shinyApp() application
shinyApp(ui = ui, server = my_server)

