data(Titanic)
Titanic.df <- expand.table(Titanic)
Titanic.tree <- rpart(Survived~., data=Titanic.df, method="class")
Titanic.tree2 <- rpart(Survived~., data=Titanic.df,method="class",cp=0.083)
data(diamonds)
diamonds2 <- subset(diamonds, subset = carat>=1.5 & carat<2 & clarity %in% c("I1", "SI2"))
boxplot(diamonds2$price)
# 因为是数值变量，method为anova
diamonds.tree <- rpart(formula=price ~ carat+cut+clarity+color, data=diamonds, method="anova")
plot(as.party(diamonds.tree))
# 训练
train <- diamonds[1:50000,]
test <- diamonds[50001:nrow(diamonds),]
diamonds.tree2 <- rpart(formula=price ~ carat+cut+clarity+color, data=train, method="anova", cp=0.078)
p <- predict(diamonds.tree2, newdata=test)
