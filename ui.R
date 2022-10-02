library(shiny)
library(shinydashboard)
library(dplyr)
library(gsheet)
library(htmltools)
library(htmlwidgets)
library(DT)
df<-gsheet2tbl("https://docs.google.com/spreadsheets/d/1-VSMRylNtxMgOriLFNa5VttoL2cMWHeRXl0gbEadHjU/edit?usp=sharing")
#-----------------------------------------------------------------------------------------------#
X <- dashboardHeader(
  title = "BLBC"
)
#-----------------------------------------------------------------------------------------------#
Y <- dashboardSidebar(
  selectInput("Att1", "Choose Center", choices = c("NULL", as.character(unique(df$`Name of Center`))), selected = "NULL"),
  uiOutput("c")
)
#----------------------------------------------------------------------------------------------#
Z <- dashboardBody(
  DT::dataTableOutput("table")
)
#----------------------------------------------------------------------------------------------#
ui<-dashboardPage(X,Y,Z)