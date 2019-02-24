#导入数据，命名。因子化spambase，因为是类别预测而不是数值预测。
spambase <- read.csv("spambase.data", header=F)
colnames(spambase) <- read.table("spambase.names", skip=33, sep=":", comment.char="")[,1]
colnames(spambase)[ncol(spambase)] <- "spam"
spambase$spam <- as.factor(spambase$spam)

set.seed(1234)
samp <- sample(4601,2500)
spambase.train <- spambase[samp,]
spambase.test <- spambase[-samp,]

#使用kernlab包执行基本分析
spambase.svml <- ksvm(spam~., data=spambase.train, C=10, cross=10)

