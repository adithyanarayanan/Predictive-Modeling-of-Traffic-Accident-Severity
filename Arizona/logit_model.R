#logistic regression model

library(rpart)
library(ROSE)
library(unbalanced)
library(randomForest)
library(DataExplorer)
library(tree) # Classification Tree
library(randomForest) # Random Forest
library(gbm) # Boosting
library(plyr)
library(caret)
library(rattle)
library(RColorBrewer)
library(ada)
library(earth)
set.seed(123)

datafr = balanced_state_AZ
datafr$Roundabout = NULL

#Splitting the data
tr_ic = sample(x = 1:nrow(datafr), size = (0.65*nrow(datafr))) 
logit_training_data <- datafr[tr_ic,]
logit_test_data <- datafr[-tr_ic,]


logit_training_data$Sig = as.factor(as.numeric(logit_training_data$Sig)-1)
logit_test_data$Sig = as.factor(as.numeric(logit_test_data$Sig)-1)


logit_model_1 = glm(Sig~., family = "binomial", data= logit_training_data)


model_predictions=predict(logit_model_1, logit_test_data , type="response")


a = 0.55
model_predictions_class = model_predictions
model_predictions_class[model_predictions_class > a] = 1
model_predictions_class[model_predictions_class < a] = 0
table(model_predictions_class,logit_test_data$Sig)
#Testing Error
mean_logit = mean(model_predictions_class!=logit_test_data$Sig)
accuracy_logit = 1- mean_logit
accuracy_logit


