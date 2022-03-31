library("shinycssloaders")
eda_page <- function() {
  fluidPage(
  # Application title
  titlePanel("Exploratory Data Analysis"),
  # Fluid rows layout
  fluidRow(
    column(6,
       selectInput("x_axis",
                   label = "X Axis Input",
                   choices = names(data),
                   multiple = FALSE,
                   selected = names(data)[1]),
       selectInput("y_axis",
                   label = "Y Axis Input",
                   choices = names(data),
                   multiple = FALSE,
                   selected = names(data)[1]),
    ),
    column(6,
      # life stage filter
      selectInput("household_lifestage",
        label = "Household Lifestage",
        choices = unique(data$hshold_lifestage_last),
        multiple = TRUE,
        selected = data$hshold_lifestage_last[1]),
      # night count filter
      sliderInput("night_count", "Night Count", width = "100%",
                min = min(data["nght_cnt"]),
                max = max(data["nght_cnt"]),
                value = c(min(data["nght_cnt"]),
                max(data["nght_cnt"])))
    ),
    column(6,
      # income filter
      sliderInput("income", "Total Income", width = "100%",
                 min = min(data["income_1_avg"] + data["income_2_avg"]),
                 max = max(data["income_1_avg"] + data["income_2_avg"]),
                 value = c(min(data["income_1_avg"] + data["income_2_avg"]),
                           max(data["income_1_avg"] + data["income_2_avg"]))),
      # net-worth filter
      sliderInput("networth", "Total Networth", width = "100%",
                 min = min(data["networth_1_avg"] + data["networth_2_avg"]),
                 max = max(data["networth_1_avg"] + data["networth_2_avg"]),
                 value = c(min(data["networth_1_avg"] + data["networth_2_avg"]),
                           max(data["networth_1_avg"] + data["networth_2_avg"]))),
    )
  ),
  fluidRow(
      # Basic pie chart
      plotlyOutput("plot_render_1") %>% withSpinner(type = 5)
  )
  )
}
