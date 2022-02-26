data <- read.csv("Cleandata.csv")

eda_after_churn_page <- function() {
  fluidPage(
  # Application title
  titlePanel("Exploratory Data Analysis After Churn"),
  # Fluid rows layout
  fluidRow(
    column(6,
      # life stage filter
      selectInput("churn_household_lifestage", label = "Household Lifestage",
                 choices = unique(data$hshold_lifestage_last), multiple = TRUE,
                 selected = "CORE"),
      # night count filter
      sliderInput("churn_night_count", "Night Count", width = "100%",
                 min = min(data["nght_cnt"]), max = max(data["nght_cnt"]),
                 value = c(min(data["nght_cnt"]), max(data["nght_cnt"])))
    ),
    column(6,
      # income filter
      sliderInput("churn_income", "Total Income", width = "100%",
                 min = min(data["income_1_avg"] + data["income_2_avg"]),
                 max = max(data["income_1_avg"] + data["income_2_avg"]),
                 value = c(min(data["income_1_avg"] + data["income_2_avg"]),
                           max(data["income_1_avg"] + data["income_2_avg"]))),
      # net-worth filter
      sliderInput("churn_networth", "Total Networth", width = "100%",
                 min = min(data["networth_1_avg"] + data["networth_2_avg"]),
                 max = max(data["networth_1_avg"] + data["networth_2_avg"]),
                 value = c(min(data["networth_1_avg"] + data["networth_2_avg"]),
                           max(data["networth_1_avg"] + data["networth_2_avg"])))
    )
  ),
  fluidRow(
    column(6,
           plotOutput("ecdf_plot_render")
    ),
    column(6,
           # Basic pie chart
           plotlyOutput("churn_plot_render_1")
    ),
    column(6,
           plotlyOutput("churn_plot_render_2")
    ),
    column(6,
           plotlyOutput("churn_plot_render_3")
    )
  ),
  fluidRow(
    plotOutput("churn_plot_render_4")
  )
)
}
