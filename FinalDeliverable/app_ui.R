library(shiny)
library("dplyr")
library("ggplot2")
library("ggmap")
library("mapproj")
library("leaflet")
library("knitr")
library("plotly")

data_df <- read.csv("AB_NYC_2019.csv", stringsAsFactors = FALSE)

# x_input_bar <- selectInput(
#     "x_var",
#     label = "X Variable",
#
# )

title <- tabPanel(
  "Overview & Introduction to Project",
  titlePanel("Overview of Project - Airbnb Listings in New York City"),
  sidebarLayout(
    sidebarPanel(
      HTML("<h2>Questions Our Project Investigated</h2>"),

      HTML("<li>How do the types of different rooms for Airbnb listings in New
           York City compare?</li>"),
      HTML("<li>How are Airbnb-hosted houses in New York City geographically
           distributed?</li>"),
      HTML("<li>How does the average cost of an Airbnb listing vary depending
           on the neighborhood?</li>"),
      HTML("<li>How does the price of Airbnb listings in certain neighborhood
           groups in New York City compare?</li>"),
      HTML("<li>How does the minimum number of nights required for a Airbnb
           listing in certain neighborhood groups in New York City
           compare?</li>")
    ),

    mainPanel(
      HTML("<h3>Introduction to the Project</h3>"),
      HTML("<p>The purpose of this project is to evaluate how Airbnb listing
      information compares within NYC. Airbnb is gaining marketshare in the 
           tourist accommodation market, which has been dominated by hotels, 
           hostels, and motels in the past, and pricing has changed overtime, 
           since it has become much more accessible to a larger audience of 
           people. Services such as Uber, Doordash, Fiverr, where individuals
           offer services is only something that has come about relatively 
           recently. And as one of the most prominent examples, our group 
           believes it is important to find the impact Airbnb will have 
           on the future.</p>"),

      h3("Data Source"),
      a("NYC Airbnb Dataset from Kaggle", href = "https://www.kaggle.com
        /dgomonov/new-york-city-airbnb-open-data"),

      p(),
      p(),

      img(
        src = "https://video-images.vice.com/articles/5c3cfa75a4786f0007380ad0/lede/1547500483819-shutterstock_665040679-copy.jpeg?crop=1xw%3A0.843644544431946xh%3Bcenter%2Ccenter&resize=2000%3A*",
        height = "90%", width = "90%"
      ),
    )
  )
)

page_one <- tabPanel(
  "Pie Graph of Room Types",
  titlePanel("Pie Graph of Room Types"),

  sidebarLayout(
    # Widget and Sidebar Content
    sidebarPanel(
      # Widget: the neighbourhood the user want to explore.
      selectInput(
        inputId = "pieNeighbourhoodInput",
        label = "Select a neighbourhood you would like to explore:",
        choices = unique(data_df$neighbourhood_group)
      )
    ),
    # Pie Graph
    mainPanel(
      h2("New York City, 2019"),
      p("This pie chart shows us the percentage breakdown of the 
        different types of rooms by neighborhood group in NYC 
        Airbnb listings."),
      plotlyOutput("pie")
    )
  )
)

page_two <- tabPanel(
  "Map of Airbnb Listings",
  titlePanel("Map of Airbnb Listings"),

  sidebarLayout(
    # Widgets and Sidebar Content
    sidebarPanel(
      # Widget 1: The feature the user want to explore.
      selectInput(
        inputId = "mapFeature",
        label = "Select a feature you would like to explore:",
        choices = list(
          "ID Number of Listing" = "id",
          "Name of Listing" = "name",
          "Listing's Host ID Number" = "host_id",
          "Listing's Host Name" = "host_name",
          "Listing's Neighbourhood Group" = "neighbourhood_group",
          "Listing's Neighbourhood" = "neighbourhood",
          "Listing's Latitude" = "latitude",
          "Listing's Longitude" = "longitude",
          "Listing's Room Type" = "room_type",
          "Listing's Price" = "price",
          "Listing's Minimum Number of Nights Required" = "minimum_nights",
          "Listing's Number of Reviews Recieved" = "number_of_reviews",
          "Listing's Most Recent Review" = "last_review",
          "Number of Reviews Listing Recieves per Month" = "reviews_per_month",
          "Listing's Host's Total Number of Listings Posted" =
            "calculated_host_listings_count",
          "Listing's Availability out of 365 Days" = "availability_365"
        ),
        selected = "Name of Listing"
      ),
      # Widget 2: The size of the dots.
      sliderInput(
        inputId = "mapSlider",
        label = "Select radius size:",
        min = 50,
        max = 200,
        step = 10,
        value = 100
      )
    ),
    # Map
    mainPanel(
      h2("New York City, 2019"),
      p("This interactive map pinpoints every listing that was hosted
      on the Airbnb website in New York City in 2019. Select a feature
        and click on any point on the map to see the feature-value 
        for that particular house."),
      leafletOutput(outputId = "map"),
      p("(You're looking at over 48,000 data points, so it may take
        a second to load)")
    )
  )
)

page_three <- tabPanel(
  "Bar Graph by Neighborhood Groups",
  titlePanel("Bar Graph by Neighborhood Groups"),

  sidebarLayout(
    # Widget and Sidebar Content
    sidebarPanel(
      # Widget 1: The feature the user want to explore.
      selectInput(
        inputId = "barFeature",
        label = "Select a feature you would like to explore:",
        choices = c(
          "Number of Listings" = "num_listings",
          "Average Price of a Listing" = "avg_price"
        ),
        selected = "Number of Listings"
      ),
    ),
    # Bar Chart
    mainPanel(
      h2("New York City, 2019"),
      p("This bar graph shows us the average price per Airbnb and the 
        number of listings for each neighbourhood group in New
        York City."),
      plotlyOutput(outputId = "bar_graph")
    )
  )
)

summary <- tabPanel(
  "Summary of Project Findings",
  titlePanel("Summary & Key Takeaways"),
  # Table of Takeaways
  mainPanel(
    tableOutput("table"),
    h3("Notable Data-Insights"),
    HTML("<li>The neighborhood that on average is the most expensive to 
         rent on Airbnb is Manhattan with an average of about <i>$200</i>
         per night.</li>"),
    HTML("<li>The rest of the neighborhoods seem to cost almost half as 
         much with an average of about <i>$100</i> per night. This may 
         be due to the fact that Manhattan is a more populated area.</li>"),
    HTML("<li><b>Most</b> of the Airbnb listings are closer to a coast or near
         central NY. Perhaps because people are attracted to the view.</li>"),
    HTML("<li>The number of entire home/apt listings is <i>almost</i> the same
         as the number of private room listings.</li>"),

    h3("Broader Implications"),
    HTML("<p>Having this information and key insights can provide crucial
         insight for Airbnbs understanding of their market place and which
         specific areas are in high demand. This can also be crucial for 
         those who are posting Airbnb listings themselves. In order to 
         gauge their competitors and post their own listings, individuals
         can use the following information about average prices in certain
         neighborhoods to know how much they should be charging for. On a 
         more macro scale, having a general idea of how the Airbnb market
         is in New York City can help individuals understand the housing 
         market, population density, and gentrification issues in 
         New York City.</p>")
  )
)

# Application Layout
ui <- navbarPage(
  "New York City Airbnb Listings (INFO 201 Application)",
  title,
  page_one,
  page_two,
  page_three,
  summary
)
