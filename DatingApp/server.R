#Michael Vander Lugt

library(shiny)
library(plotly)
library(neuralnet)
#clean_data = read.csv("/Users/mvlugt/Documents/Winter 2017/TO 414/Final Project/sdclean.csv", header = T)
#raw_data = read.csv("/Users/mvlugt/Documents/Winter 2017/TO 414/Final Project/Speed Dating Data.csv", header = T)
clean_data = read.csv("sdclean.csv", header = T)
raw_data = read.csv("Speed Dating Data.csv", header = T)

#Logistic models are used for both predictions because they proved to be the only ones fast enough to be interactive.
shinyServer(function(input, output) {
  
  
  output$plot <- renderPlotly({
    lower_bound <- input$range[1]
    upper_bound <- input$range[2]
    train2 <- subset(clean_data, race != input$race & (age < lower_bound | age >= upper_bound))
    test2 <- subset(clean_data, race == input$race & (age >= lower_bound & age < upper_bound))
    
    log_all8 = glm(match ~ int_corr + age_o + pf_o_sin + pf_o_sha + attr_o + fun_o + amb_o + prob_o + met_o + imprace + exercise + gaming + concerts + exphappy + intel2_1, data = train2, family = "binomial")
    predict.model.log_all8 = predict(log_all8, newdata = test2, type = "response")
    predict.model.log_all8 = as.data.frame(predict.model.log_all8, na.rm = TRUE)
    predict.model.log_all8$predict.model <- as.numeric(predict.model.log_all8$predict.model)
    predict.model.log_all8$match <- ifelse(predict.model.log_all8$predict.model > 0.5, 1, 0)
    predict.model.log_all8$X <- test2$X
    predict.model.log_all8$agreement = ifelse(predict.model.log_all8$match == test2$match, "True", "False")
    predict.model.log_all8$agreement = as.factor(predict.model.log_all8$agreement)
    predict.model.log_all8
    x <- data.frame(prop.table(table(predict.model.log_all8$agreement)))
    
    
    plot_labels <- c("Correct Match Prediction", "Incorrect Match Prediction")
    getName <- switch(strtoi(input$race, base = 0L), "African American","Caucasian","Hispanic/Latina", "Asian","NULL", "Other")
    label <- paste("Correct Match Predictions for",getName, "from Ages", toString(input$range[1]), "to", toString(input$range[2]), "\n")
    plot_ly(x, labels = ~plot_labels, values = ~Freq, type = 'pie')%>%
      layout(title = label,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
 
  output$plot2 <- renderPlotly({
    raw_data <- raw_data[-35] #Drop Field
    raw_data <- raw_data[-42] #Drop From
    raw_data <- raw_data[-47] #Drop Career
    raw_data <- raw_data[-1] #Drop iid
    raw_data <- raw_data[-1]# Drop id
    raw_data <- raw_data[-10]# Drop pid
    raw_data <- raw_data[-2]
    raw_data <- raw_data[-3]
    raw_data <- raw_data[-3]
    raw_data <- raw_data[-3]
    raw_data <- raw_data[-4]
    raw_data <- raw_data[-4]
    
    num = sapply(raw_data, is.numeric)
    nums = raw_data[,num]
    nums <- nums[sample(nrow(nums), nrow(nums)),] #Get a random sample since the data is organized by participant
    
    nums[nums=='NA'] <- NA
    for(i in 1:ncol(nums)){
      nums[is.na(nums[,i]), i] <- mean(nums[,i], na.rm = TRUE)
    }
    
    lower_bound <- input$range[1]
    upper_bound <- input$range[2]
    love_train <- subset(nums, race != input$race & (age < lower_bound | age >= upper_bound))
    love_test <- subset(nums, race == input$race & (age >= lower_bound & age < upper_bound))
    
    
    love_all8 = glm(dec_o ~ ., data = love_train, family = "binomial")
    predict.model.love_all8 = predict(love_all8, newdata = love_test, type = "response")
    predict.model.love_all8 = as.data.frame(predict.model.love_all8, na.rm = TRUE)
    predict.model.love_all8$predict.model <- as.numeric(predict.model.love_all8$predict.model)
    predict.model.love_all8$match <- ifelse(predict.model.love_all8$predict.model > 0.5, 1, 0)
    predict.model.love_all8$X <- love_test$X
    predict.model.love_all8$agreement = ifelse(predict.model.love_all8$match == love_test$match, "True", "False")
    predict.model.love_all8$agreement = as.factor(predict.model.love_all8$agreement)
    predict.model.love_all8
    prop.table(table(predict.model.love_all8$agreement))
    
    z <- data.frame(prop.table(table(predict.model.love_all8$agreement)))
    
    
    love_labels <- c("Correct Love Predictions", "Incorrect Love Prediction")
    getName <- switch(strtoi(input$race, base = 0L), "African American","Caucasian","Hispanic/Latina", "Asian","NULL", "Other")
    label <- paste("Correct Love Predictions for",getName, "from Ages", toString(input$range[1]), "to", toString(input$range[2]), "\n")
    plot_ly(z, labels = ~love_labels, values = ~Freq, type = 'pie')%>%
      layout(title = label,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
  })
})
