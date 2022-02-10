source('EDAChartData/chart1.R', local=TRUE)

EDA <- fluidPage(
  
  # Application title
  titlePanel("Exploratory Data Analysis"),
  
  # Fluid rows layout
  fluidRow(
    column(6,
      # Basic pie chart
      plotOutput("plot1Render")
      ),
    column(6,
      plotOutput("plot2Render")      
      )
  ),
  fluidRow(
    column(6,
      plotlyOutput("plot3Render")       
      )
  )
  
)

plot1 <- ggplot(chart1Data, aes(x="", y=value, fill=group)) +
  ggtitle("Sample chart 1") +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() +
  theme(plot.title=element_text(hjust=0.5, family="Arial", face='bold', size=16))

plot2 <- ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  ggtitle("Sample chart 2") +
  geom_point(size=6) +
  theme_ipsum() +
  theme(plot.title=element_text(hjust=0.5, family="Arial", face='bold', size=16))

plot3Font <- list(size = 16, x = 0.5, family="Arial")
plot3 <- plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species)%>%
  layout(title=list(text="<b>Sample Chart 3</b>", font=plot3Font))