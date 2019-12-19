#prediction accuracies of tuning models

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
library(ElemStatLearn)
set.seed(123)


#RPART CLASSIFICATION TREE
predictions= predict(tree_model_caret, test_data ,type="raw")
table(predictions,test_data$Sig)
mean_tree = mean(predictions!=test_data$Sig)
mean_tree
accuracy_tree = 1- mean_tree
accuracy_tree


#BAGGING METHODS
bag_model_1 = randomForest(training_data$Sig~., data = training_data, mtry =9, importance = TRUE, ntree=1000)
plot(bag_model_1, type='l', main = "Number of Trees for RF and Bagging")
#let ntree = 400 since error stagnates after 400
bag_model_2 = randomForest(training_data$Sig~., data = training_data, mtry =9, importance = TRUE, ntree=400)
bag_predictions = predict(bag_model_2, test_data, type="class")
table(bag_predictions,test_data$Sig)
mean_bag = mean(bag_predictions!=test_data$Sig) 
accuracy_bag = 1- mean_bag
accuracy_bag

#RANDOM FOREST MODEL
ensemble_error = c()
for(i in 1:(ncol(training_data)-1)){
  rf_model_1 = randomForest(training_data$Sig~., data=training_data, mtry=i, importance=TRUE, ntree=400)
  ensemble_error[i] <- rf_model_1$err.rate[400]
}
plot(ensemble_error,type = "l", main="OOB errors", xlab = "Number of Predictors", ylab = "Error Rate")

#number of predictors chosen = 10
rf_model_2 = randomForest(training_data$Sig~., data=training_data, mtry=10, importance=TRUE, ntree=400)
pred_y_rf = predict(rf_model_2, test_data, type="class")
table(pred_y_rf,test_data$Sig)
mean_rf = mean(pred_y_rf!=test_data$Sig)
accuracy_rf = 1-mean_rf
accuracy_rf



#ADA BOOSTED MODEL
pred_y_ada = predict(ada_model_caret, test_data, type="raw")
table(pred_y_ada,test_data$Sig)
mean_ada = mean(pred_y_ada!=test_data$Sig)
accuracy_ada = 1- mean_ada
accuracy_ada




#MARS MODEL
mars_predict = predict(earth_model_caret, test_data, type="raw")
table(mars_predict,test_data$Sig)
mean_mars = mean(mars_predict!=test_data$Sig)
accuracy_mars = 1- mean_mars
accuracy_mars


importance(rf_model_2)
varImpPlot(rf_model_2)
