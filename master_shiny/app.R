library(shiny)
library(dplyr)
library(ggplot2)

load("loaded.Rdata")
source("function.R")
# source(paste0(folder, "load_data.R"))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Low Budget COVID-19 Dash"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("select", h3("Select from the Americas"),
                        choices = sort(us_states), selected = "Alabama"),
            "COVID-19 New Cases Summary:",
            textOutput("text")
        
        ),
        mainPanel(
          plotOutput("plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$selection <- renderText({
    quote(input$select)
    })
  
  
    output$text <- renderText({
      email_body_func(state_fun(input$select))
    })
    

    output$plot <- renderPlot({
      mavg_plot_func(state_fun(input$select))
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)