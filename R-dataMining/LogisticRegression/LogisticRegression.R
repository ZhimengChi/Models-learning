# Logistic Regression
spambase <- read.csv("spambase.data", header=F)
colnames(spambase) <- read.table("spambase.names",skip=33, sep=":", comment.char="")[,1]
colnames(spambase)[ncol(spambase)] <- "spam"
# qplot(word_freq_your, spam, data=spambase, alpha=I(0.03))

# # @method: one dimensional logistic
# spam.your.lst <- glm(spam~word_freq_your,data=spambase, family="binomial")
# a <- coef(spam.your.lst)[2]
# b <- coef(spam.your.lst)[1]
# lst.fun <- function(x){
#   1/(1+exp(-(a*x+b)))
# }
# qplot(word_freq_your, spam, data=spambase, alpha=I(0.03), xlim=c(-5,15)) + 
#   stat_function(fun=lst.fun, geom="line") 

# @method: multiple dimensional logistic
spam.glm <- glm(spam~., data=spambase, family="binomial")
spam.glm.best <- stepAIC(spam.glm)
# summary(spam.glm.best)
spam.best.pred <- predict(spam.glm.best, type="resp")
(tb.best <- table(spam=spambase$spam, pred=round(spam.best.pred)))
smoothScatter(spam.best.pred, spambase$spam) + stat_function(fun=spam.glm.best)
