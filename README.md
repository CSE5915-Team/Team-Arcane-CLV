# Customer Lifetime Value Project

## Introduction

This project involves creating models that calculate Customer Lifetime Value (CLV). We go through the entire data analysis process, from preprocessing raw data, to creating an EDA, to churn and modeling.

## Required Packages

The following R packages are required to be installed in order to run the Shiny web application locally.

- [Shiny](https://shiny.rstudio.com/): the R framework for web application development
- [ggplot2](https://ggplot2.tidyverse.org/): used for creating static plots
- [plotly](https://plotly.com/r/): used for creating interactive plots
- [hrbrthemes](https://github.com/hrbrmstr/hrbrthemes): themes that are used for the plots made
- [showtext](https://cran.rstudio.com/web/packages/showtext/vignettes/introduction.html): renders fonts properly

## How To Run

Open R console in ./CLV and run:

```R
shiny::runApp()
```

OR start RStudio and click "Run App" in ./CLV/app.R

## Exploratory Data Analysis Page

This page consists of graphs using data that has only been pre-processed. We have included graphs of interesting relationships among attributes. User can choose to analyze specific demographics in the text bar on the top as well as adjust the sliders on the bottom to view particular data and its affect on the corresponding relationships between attributes.

## Exploratory Data Analysis After Churn Page

This page consists of an ECDF churn plot, multiple line graphs comparing probabilities of churn against various attributes of data. The ECDF plot uses pre-processed data while the line graphs uses data that has been pre-processed and removed of its guaranteed churned customers. The user can interact with the line graphs by adjusting the sliders on the bottom to view particular data and its affect on the corresponding relationships between attributes.

## Contributors

- [Ben Barasch](https://github.com/orgs/CSE5915-Team/people/bbarasch)
- [Bryse Wagner](https://github.com/orgs/CSE5915-Team/people/bryse1225)
- [Derek Nelson](https://github.com/orgs/CSE5915-Team/people/Megaden44)
- [Supreeth Voona](https://github.com/orgs/CSE5915-Team/people/supreethvoona)
- [Charlie Ringler](https://github.com/orgs/CSE5915-Team/people/Pike1z)
