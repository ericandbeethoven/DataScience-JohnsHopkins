library(caret)
library(randomForest)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test) 
head(vowel.train)
head(vowel.test)
dim(vowel.train) # 528  11
dim(vowel.test) # 462  11
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
modelRf <- train(y ~ .,
                 method = "rf",
                 data = vowel.train
)
set.seed(33833)
modelGBM <- train(y ~ .,
                 method = "gbm",
                 data = vowel.train,
                 verbose=F
                 )
predRf <- predict(modelRf, vowel.test)
predGBM <- predict(modelGBM, vowel.test)

# RF Accuracy: 0.6060606
confusionMatrix(predRf, vowel.test$y)$overall[1]
# GBM Accuracy: 0.530303
confusionMatrix(predGBM, vowel.test$y)$overall[1]
pred <- data.frame(predRf, predGBM, y=vowel.test$y, agree=predRf == predGBM)
head(pred)
accuracy <- sum(predRf[pred$agree] == pred$y[pred$agree]) / sum(pred$agree)
accuracy # Agreement Accuracy: 0.6569579

library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData <- data.frame(diagnosis, predictors)
inTrain <- createDataPartition(adData$diagnosis, p=3/4)[[1]]
training <- adData[inTrain, ]
testing <- adData[-inTrain, ]
dim(adData) # 333 131
# head(adData)
set.seed(62433)
fitRf <- train(diagnosis ~ ., data=training, method="rf")
fitGBM <- train(diagnosis ~ ., data=training, method="gbm")
fitLDA <- train(diagnosis ~ ., data=training, method="lda")
predRf <- predict(fitRf, testing)
predGBM <- predict(fitGBM, testing)
predLDA <- predict(fitLDA, testing)
pred <- data.frame(predRf, predGBM, predLDA, diagnosis=testing$diagnosis)
# Stack the predictions together using random forests ("rf")
fit <- train(diagnosis ~., data=pred, method="rf")
predFit <- predict(fit, testing)
c1 <- confusionMatrix(predRf, testing$diagnosis)$overall[1]
c2 <- confusionMatrix(predGBM, testing$diagnosis)$overall[1]
c3 <- confusionMatrix(predLDA, testing$diagnosis)$overall[1]
c4 <- confusionMatrix(predFit, testing$diagnosis)$overall[1]
print(paste(c1, c2, c3, c4)) 


library(AppliedPredictiveModeling)
data(segmentationOriginal)

data <- segmentationOriginal
set.seed(125)
inTrain <- data$Case == "Train"
trainData <- data[inTrain, ]
testData <- data[!inTrain, ]
cartModel <- train(Class ~ ., data=trainData, method="rpart")
cartModel$finalModel
plot(cartModel$finalModel, uniform=T)
text(cartModel$finalModel, cex=0.8)

library(pgmm)
data(olive)
olive = olive[,-1]

newdata = as.data.frame(t(colMeans(olive)))
treeModel <- train(Area ~ ., data=olive, method="rpart2")
treeModel
newdata <- as.data.frame(t(colMeans(olive)))
predict(treeModel, newdata) # 2.875

library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

# Then set the seed to 13234 and fit a logistic regression model (method="glm", be sure to specify 
# family="binomial") with Coronary Heart Disease (chd) as the outcome and age at onset, 
# current alcohol consumption, obesity levels, cumulative tabacco, type-A behavior, 
# and low density lipoprotein cholesterol as predictors. 
# Calculate the misclassification rate for your model using this function 
# and a prediction on the "response" scale:
set.seed(13234)
SAHD = train(chd ~ age + alcohol + obesity + tobacco + typea + ldl,
             data=trainSA,
             method="glm",
             family="binomial")
SAHD.pred.TEST = predict(SAHD, newdata = testSA)
SAHD.pred.TRAIN = predict(SAHD, trainSA)

# Training Set Misclassification rate
missClass(trainSA$chd, SAHD.pred.TRAIN) # 0.2727273
# Test Set Misclassification rate
missClass(testSA$chd, SAHD.pred.TEST) # 0.3116883

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

library(ElemStatLearn)
library(randomForest)
data(vowel.train)
data(vowel.test) 
head(vowel.train)
head(vowel.test)
dim(vowel.train) # 528  11
dim(vowel.test) # 462  11
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
modelRf <- randomForest(y ~ ., data = vowel.train, importance = FALSE)
order(varImp(modelRf), decreasing=T)


