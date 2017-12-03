
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyUI(fluidPage(

  # Application title
  titlePanel("Getting probability"),
  tags$div(class="header", checked=NA,
           tags$p("Select the mean, standard deviation and de range to see the probability under the graphic.")),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("mean",
                  "Mean:",
                  min = -30,
                  max = 30,
                  value = 0),
      sliderInput("sd",
                  "Standard deviation:",
                  min = 1,
                  max = 13,
                  value = 7),
      sliderInput("menos",
                  "Z:",
                  min = -75,
                  max = 0,
                  value = -4),
      sliderInput("mas",
                  "X:",
                  min = 0,
                  max = 75,
                  value = 4)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      textOutput("zless"),
      textOutput("zmore"),
      textOutput("xless"),
      textOutput("xmore"),
      textOutput("ztox")
    )
  ),
  tags$div(class="header", checked=NA,
           tags$p("This is a simple project given the short time frame."))
))
