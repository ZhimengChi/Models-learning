bike <- read.csv("day.csv")
summary(bike)

# @method: one dimensional linear prediction
# qplot(atemp, cnt, data=bike) + geom_smooth(method = "lm")
# bike.lm <- lm(cnt~atemp, data=bike)
# bike.lm
# bike.res <- residuals(bike.lm)
# bike.pred <- predict(bike.lm)
# qplot(bike.res, binwidth=500, color=I("red"), fill=I("grey"))
# qplot(bike.pred, bike$cnt) + geom_smooth(method = "lm")

# @method: multiple dimensional linear prediction
# with dummy variables handle
bike.cat <- bike %>%
  select(season:weathersit) %>%
  mutate_all(funs(factor))
# tmp <- dummyVars(~., data=bike.cat)
# bike.dum <- predict(tmp, bike.cat)
# bike01 <- cbind(select(bike, temp:windspeed, cnt),bike.dum)
# bike.lm.0 <- lm(cnt~.,data=bike01)
# # using AIC mothod in MASS library to choose subclass of variable. 
# # the model is considered as optimized while AIC is minimum.
# bike.lm.1 <- stepAIC(bike.lm.0)
# qplot(residuals(bike.lm.1), binwidth=600, color=I("red"), fill=I("grey"))
# qplot(predict(bike.lm.1), bike$cnt) + geom_smooth(method="lm")

# without dummy
bike02 <- cbind(dplyr::select(bike, temp:windspeed, cnt), bike.cat)
bike02.lm <- lm(cnt~., data=bike02)
bike02.steplm <- stepAIC(bike02.lm)
qplot(residuals(bike02.steplm), binwidth=600, color=I("red"), fill=I("grey"))
qplot(predict(bike02.steplm), bike$cnt) + geom_smooth(method="lm")
