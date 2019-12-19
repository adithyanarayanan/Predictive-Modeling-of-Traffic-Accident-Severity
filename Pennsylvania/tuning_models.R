# Tunes and outputs final models for ada, earth, and rpart TREE


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
library(caret)


set.seed(124)

df = balanced_state_PA



#modelLookup("rf")


#Splitting the data
train_index = sample(x = 1:nrow(df), size = (0.65*nrow(df))) 
training_data <- df[train_index,]
test_data <- df[-train_index,]


#final caret control
fit_control = trainControl(method = "repeatedcv", number = 10, repeats = 3)




#setting search grid values
earth_grid = expand.grid( degree = c(1:5), nprune = floor(seq(2,100,length.out = 10)))
ada_grid = expand.grid(iter = 100, maxdepth = c(1,2,3,4,5), nu = c(0.1, 0.5, 0.9))



#fitting different models to find best tuning parameters
ada_model_caret = train(Sig~., data=tree_train, method="ada", trControl = fit_control, tuneGrid= ada_grid)
earth_model_caret = train(Sig~., data=tree_train, method="earth", trControl = fit_control, tuneGrid = earth_grid)



#Tree Modeling
tree_df = df
tree_df$Bump = NULL
tree_df$Roundabout = NULL

tree_train = tree_df[train_index,]
tree_test = tree_df[-train_index,]


tree_model_caret = train(Sig~., data=tree_train, method="rpart", trControl = fit_control)
fancyRpartPlot(tree_model_caret$finalModel)



  

