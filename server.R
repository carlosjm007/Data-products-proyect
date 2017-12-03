
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    r <- rnorm(300, m=input$mean, sd=input$sd)
    x <- seq(-75,75,length=300)
    y <- dnorm(x,mean=input$mean,sd=input$sd)
    data = data.frame(r,y,x)
    ggplot(data=data, aes(x=r)) + 
      geom_histogram(colour="#7b7b7b") +
      xlim(c(-75,75)) +
      scale_y_continuous(sec.axis = sec_axis(~./600, name = "Gauss distribution")) +
      geom_line(data = data, mapping = aes(x = x, y = y*600, color="dnomr"),size=2) +
      geom_vline(aes(xintercept=input$menos, color="Z"),size=1) +
      geom_vline(aes(xintercept=input$mas, colour="X"),size=1) +
      scale_color_manual(name = "Lines",
                         values = c(Z = "#3e73e3", X = "#55bc66", dnomr="#99003e"),
                         labels = c(Z = "Z", X = "X", dnomr="Gauss bell"))
  })
  output$zless <- renderText({
    zless <- pnorm(input$menos, mean=input$mean, sd=input$sd)*100
    paste("The probability to get Z lesser than ", input$menos, " is " , round(zless,1), "%")
  })
  output$xless <- renderText({
    xless <- pnorm(input$mas, mean=input$mean, sd=input$sd)*100
    paste("The probability to get X lesser than ", input$mas, " is " , round(xless,1), "%")
  })
  output$zmore <- renderText({
    zmore <- pnorm(input$menos, mean=input$mean, sd=input$sd, lower.tail=FALSE)*100
    paste("The probability to get Z greater than ", input$menos, " is " , round(zmore,1), "%")
  })
  output$xmore <- renderText({
    xmore <- pnorm(input$mas, mean=input$mean, sd=input$sd, lower.tail=FALSE)*100
    paste("The probability to get X greater than ", input$mas, " is " , round(xmore,1), "%")
  })
  output$ztox <- renderText({
    zmore <- pnorm(input$menos, mean=input$mean, sd=input$sd, lower.tail=FALSE)*100
    xmore <- pnorm(input$mas, mean=input$mean, sd=input$sd, lower.tail=FALSE)*100
    paste("The probability to get z greater than ", input$menos, " but with x lesser than ", input$mas, " is " , round(zmore - xmore,1), "%")
  })
})