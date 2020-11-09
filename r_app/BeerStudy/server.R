#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggthemes)
library(ggplot2)
library(shiny)
library(wordcloud)
library(RColorBrewer)
library(wordcloud2)
library(tm)

server <- function(input, output) {
    
    breweries = read.csv("./Data/Breweries.csv")
    beers = read.csv("./Data/Beers.csv")
    data = merge(x=breweries, y=beers, by.y ="Brewery_id" , by.x = "Brew_ID")
    # Rename the variables
    
    
    
    # Get rid of special characters in the beer styles
    data$Style = gsub("[^0-9A-Za-z' ]"," " , data$Style ,ignore.case = TRUE)
    
    #Deal with NA in IBU
    # Finds the median value per beer style
    meanIBU = matrix(nrow = 100)
    styles = list()
    for (i in 1:length(unique(data$Style)) )
    {
        beer_style = unique(data$Style)[i]
        ibu_mean = mean(data[grep(beer_style, data$Style, ignore.case = T),]$IBU,na.rm = T )
        meanIBU[i] = ibu_mean
        styles[[i]] = beer_style
    }
    
    # Create a new styles dataframe with the IBU medians per beer style
    styles_impute = data.frame(IBU=meanIBU, Style = matrix(unlist(styles), nrow=length(styles), byrow=T))
    
    # merge the beer styles median IBU dataframe with the working dataframe on style name 
    impute_data = merge(data, styles_impute, by.x="Style", by.y="Style") 
    
    # If NA in original IBU value, then use median IBU per style, else use original value 
    impute_data = impute_data %>% mutate(imputed_IBU = ifelse(is.na(IBU.x) == TRUE,IBU.y,IBU.x))
    # Impute any impute_data value with the median for the ABV and imputed_IBU columns
    impute_data= impute_data %>% mutate_at(vars(ABV,imputed_IBU),~ifelse(is.na(.x), median(.x, na.rm = TRUE), .x))
    
    # Get rid of the 5 rows without a beer style. 
    impute_data = impute_data%>% filter(!Style=="")
    
    # Drop redundant columns
    drops =  c("IBU.x","IBU.y")
    impute_data = impute_data[ , !(names(impute_data) %in% drops)]
    
    
    
    output$hist_box <- renderPlot({
        if (input$states_id_hist_box !=  "All") {
            impute_data_state = impute_data %>% filter(str_trim(State,side="both")==  input$states_id_hist_box)
            
        }  else {
            impute_data_state = impute_data
            
        }
        
        
        # Choose States for histogram box / plot
        
        
        if (input$hist_vs_box_id == "Histogram") {
            if (input$abv_vs_ibu == "IBU"){
                impute_data_state %>% ggplot() + geom_histogram(aes(x=imputed_IBU), bins = input$bins + 1) + ylab("IBU")  + ggtitle("IBU Histogram") + theme_clean()
                
            } else {
                impute_data_state %>% ggplot() + geom_histogram(aes(x=ABV), bins = input$bins + 1) + ggtitle("ABV Histogram")  + theme_clean()
            }
        } else if (input$hist_vs_box_id == "Boxplot") {
            
            if (input$abv_vs_ibu == "IBU"){
                impute_data_state %>% ggplot() + geom_boxplot(aes(x=imputed_IBU)) + ylab("IBU") + ggtitle("IBU Boxplot")  + theme_clean()
                
            } else {
                impute_data_state %>% ggplot() + geom_boxplot(aes(x=ABV)) + ggtitle("ABV Boxplot") + theme_clean()
            }
            
            
            
        }
        
        
        
    })
    
    output$scatter <- renderPlot({
        
        # Scatter plot
        
        if (input$states_id_scatter !=  "All") {
            impute_data_state = impute_data %>% filter(str_trim(State,side="both")==  input$states_id_scatter)
            
        } else {
            impute_data_state = impute_data
            
        }
        
        
        if (input$regression_id == "No")
        {
            impute_data_state %>% ggplot() + geom_point(aes(x=ABV, y=imputed_IBU)) + ggtitle("ABV vs IBU Scatter Plot")   + theme_clean()
        } else {
            impute_data_state %>% ggplot() + geom_point(aes(x=ABV, y=imputed_IBU))  + ggtitle("ABV vs IBU Scatter Plot") + geom_smooth(aes(x=ABV, y=imputed_IBU)) + theme_clean()
            
        }
    })
    
    
    output$wordCloudStyles <- renderPlot({
        
        if (input$wc_state !=  "All") {
            impute_data_state = impute_data %>% filter(str_trim(State,side="both")==  input$wc_state)
        } else {
            impute_data_state = impute_data
            
        }
        
        # Set Beer Style as Vector
        text = as.vector(impute_data_state['Style'])
        docs = Corpus(VectorSource(text))
        
        # Remove punctuations, whitespaces and numbers
        docs = docs %>%
            tm_map(removeNumbers) %>%
            tm_map(removePunctuation) %>%
            tm_map(stripWhitespace)
        
        # Move to lower case
        docs = tm_map(docs, content_transformer(tolower))
        
        # Ignore Stop Words
        docs = tm_map(docs, removeWords, stopwords("english"))
        tdm = TermDocumentMatrix(docs) 
        matrix = as.matrix(tdm) 
        words = sort(rowSums(matrix),decreasing=TRUE) 
        
        # Make a dataframe
        df_style = data.frame(word = names(words),freq=words)
        print("Word Cloud for beer styles")
        wordcloud(words = df_style$word, freq = df_style$freq, min.freq = 1,max.words=100, random.order=FALSE, rot.per=0.35,colors=brewer.pal(8, "Dark2"))
        
        
        
        
        
        
    })
    
    
    output$wordCloudNames <- renderPlot({
        
        
        if (input$wc_state !=  "All") {
            impute_data_state = impute_data %>% filter(str_trim(State,side="both")==  input$wc_state)
        } else {
            impute_data_state = impute_data
            
        }
        
        
        # Set Beer Name as Vector
        text = as.vector(impute_data_state$Name.y)
        docs = Corpus(VectorSource(text))
        
        # Remove punctuations, whitespaces and numbers
        docs = docs %>%
            tm_map(removeNumbers) %>%
            tm_map(removePunctuation) %>%
            tm_map(stripWhitespace)
        docs = tm_map(docs, content_transformer(tolower))
        
        # Ignore Stop Words
        docs = tm_map(docs, removeWords, stopwords("english"))
        tdm = TermDocumentMatrix(docs) 
        
        matrix = as.matrix(tdm) 
        words = sort(rowSums(matrix),decreasing=TRUE) 
        
        # Make a dataframe
        df_name = data.frame(word = names(words),freq=words)
        print("Word Cloud for beer names")
        wordcloud(words = df_name$word, freq = df_name$freq, min.freq = 1,max.words=100, random.order=FALSE, rot.per=0.35,colors=brewer.pal(6, "Dark2"))
        
        
        
        
        
        
        
    })
}
