library(shiny)
library(shinydashboard)
library(dplyr)
library(gsheet)
library(htmltools)
library(htmlwidgets)
library(DT)
df<-gsheet2tbl("https://docs.google.com/spreadsheets/d/1-VSMRylNtxMgOriLFNa5VttoL2cMWHeRXl0gbEadHjU/edit?usp=sharing")
server <- function(input, output) {
  selectedData <- reactive({
    if(input$Att1 == "NULL") Ddata <- df #Keep full data set if NULL
    else Ddata <- subset(df, `Name of Center` == input$Att1)
    Ddata
  })
  ######################
  output$c <- renderUI({selectInput("Att2", "Choose Month", choices = c("NULL", as.character(unique(selectedData()$Month))), selected = "NULL")})
  
  selectedData2 <- reactive({
    if(input$Att2 == "NULL") Vdata <- selectedData()
    else Vdata <- subset(selectedData(), Month == input$Att2)
    Vdata
  })
  #=====================
  output$table <- DT::renderDataTable({
    DT::datatable(selectedData2(), rownames=F,
                  container = htmltools::withTags(table(
                    tableHeader(selectedData2()),
                    tableFooter(sapply(selectedData2(), function(x) if(is.numeric(x)) sum(x)))
                  )), 
                  extensions = c('FixedColumns',"FixedHeader","Buttons"), 
                  options = list(scrollX = TRUE,
                                 pageLength = 20,
                                 fixedHeader=TRUE,dom = 'Bfrtip',
                                 buttons = c('copy', 'csv', 'excel', 'pdf'),
                                 fixedColumns = list(leftColumns = 2, rightColumns = 0)))
  })
}