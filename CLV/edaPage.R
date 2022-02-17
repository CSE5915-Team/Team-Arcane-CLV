data <- read.csv("Cleandata.csv")

eda_page <- fluidPage(
  # Application title
  titlePanel("Exploratory Data Analysis"),
  # Fluid rows layout
  fluidRow(
    column(6,
      # life stage filter
      selectInput("household_lifestage",
      label = "Household Lifestage",
      choices = unique(data$hshold_lifestage_last),
      multiple = TRUE,
      selected = "CORE")
    )
  ),
  fluidRow(
    column(6,
      # Basic pie chart
      plotlyOutput("plot_render_1")
    ),
    column(6,
      plotlyOutput("plot_render_2")
    )
  ),
  fluidRow(
    column(6,
      plotlyOutput("plot_render_3")
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
      # night count filter
      sliderInput("night_count",
        "Night Count",
        width = "100%",
        min = min(data["nght_cnt"]),
        max = max(data["nght_cnt"]),
        value = c(min(data["nght_cnt"]),
                  max(data["nght_cnt"])))
    )
  )
)
