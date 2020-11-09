#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(shiny)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(tm)


states = c("All","AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT",
           "NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD", "TN","TX","UT","VT","VA","WA","WV","WI","WY")
ui <- fluidPage(
    
    # App title ----
    titlePanel("Beer Study"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            
            #  Input Select hist vs box
            selectInput(inputId = "abv_vs_ibu",
                        label = "Choose the feature you want to explore!",
                        choices = c("ABV", "IBU"),
                        selected = "ABV",
                        multiple = FALSE,
                        selectize = TRUE,
                        width = NULL,
                        size = NULL
            ),
            
            #  Input Select hist vs box
            selectInput(inputId = "hist_vs_box_id",
                        label = "Choose between Histograms or Boxplot!",
                        choices = c("Histogram", "Boxplot"),
                        selected = "Histogram",
                        multiple = FALSE,
                        selectize = TRUE,
                        width = NULL,
                        size = NULL
            ),
            
            #  Input: Slider for the number of bins ----
            sliderInput(inputId = "bins",
                        label = "Number of bins:(only applicable for Histograms)",
                        min = 1,
                        max = 50,
                        value = 30),
            
            # Input: Bins to select state
            selectInput(inputId = "states_id_hist_box",
                        label = "Choose the States for the Histogram or Boxplot",
                        choices = states,
                        selected = "All",
                        multiple = TRUE,
                        selectize = TRUE,
                        width = NULL,
                        size = NULL),
            
            # Input: Select if regression is enabled
            selectInput(inputId = "regression_id",
                        label = "Do you want to see the regression line?",
                        choices = c("Yes", "No"),
                        selected = "Yes",
                        multiple = FALSE,
                        selectize = TRUE,
                        width = NULL,
                        size = NULL),
            
            # Input: select state for Scatter
            selectInput(inputId = "states_id_scatter",
                        label = "Choose the States for the Scatter Plot? ",
                        choices = states,
                        selected = "All",
                        multiple = TRUE,
                        selectize = TRUE,
                        width = NULL,
                        size = NULL),
            
            # Input: select state for word clouds
            selectInput(inputId = "wc_state",
                        label = "Choose the States for the Word Clouds ",
                        choices = states,
                        selected = "All",
                        multiple = TRUE,
                        selectize = TRUE,
                        width = NULL,
                        size = NULL)
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Histogram ----
            plotOutput(outputId = "hist_box"),
            plotOutput(outputId = "scatter"),
            
            plotOutput(outputId = "wordCloudStyles"),
            plotOutput(outputId = "wordCloudNames")
            
            
            
            
        )
    )
)
