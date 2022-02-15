source("EDAChartData/chart1.R", local = TRUE)
data <- read.csv("Cleandata.csv")

eda_page <- fluidPage(
  # Application title
  titlePanel("Exploratory Data Analysis"),
  # Fluid rows layout
  fluidRow(
    column(6,
      # Basic pie chart
      plotlyOutput("plot_render_1")
      ),
    column(6,
      plotOutput("plot_render_2")
      )
  ),
  fluidRow(
    column(6,
      plotlyOutput("plot_render_3")
      ),
    column(6,
      sliderInput("income",
                  "Total Income",
                  width = "100%",
                  min = min(data["income_1_avg"]),
                  max = max(data["income_1_avg"]),
                  value = c(min(data["income_1_avg"]), max(data["income_1_avg"])))
      )
  )
)

ggplot1 <- ggplot(data, aes(x = nght_cnt, y = tot_amt, color = hshold_lifestage_last)) +
  ggtitle("Night count vs. Total Amount") +
  geom_point(size = 3) +
  geom_smooth(method = lm, color = "red", se = FALSE) +
  theme_ipsum() +
  xlab("Night Count") +
  ylab("Total Amount ($)") +
  labs(color = "Household Lifestage") +
  theme(plot.title = element_text(hjust = 0.5, family = "Arial", face = "bold", size = 16))
plot1 <- ggplotly(ggplot1)

plot2 <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  ggtitle("Sample chart 2") +
  geom_point(size = 6) +
  theme_ipsum() +
  theme(plot.title = element_text(hjust = 0.5, family = "Arial", face = "bold", size = 16))

plot3_font <- list(size = 16, x = 0.5, family = "Arial")
plot3 <- plot_ly(type = "scatter", mode = "markers", data = iris, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species) %>%
  layout(title = list(text = "<b>Sample Chart 3</b>", font = plot3_font))