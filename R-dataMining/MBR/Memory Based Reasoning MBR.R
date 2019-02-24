ws.customer <- read.csv("Wholesale customers data.csv")
ws.customer$Channel <- factor(ws.customer$Channel, labels=c("Horeca", "Retail"))
ws.customer$Region <- factor(ws.customer$Region, labels=c("Lisbon", "Oporto", "Other Region"))

# rough plot to see distinguish at begining
# plot(ws.customer[,3:8],col=(ws.customer$Region), pch=as.numeric(ws.customer$Region))

# sample 220
sampA <- sample(1:440, 220)
sampB <- (1:440)[-sampA]

# using knn
wsc.knn <- knn(ws.customer[sampA,3:8], ws.customer[sampB, 3:8], ws.customer[sampA, 2], k=5)

# find optimized k value
mcrate <- numeric(20)
for (i in 3:20){
  wsc.knn <- knn(ws.customer[sampA,3:8], ws.customer[sampB, 3:8], ws.customer[sampA, 2], k=i)
  cr <- table(wsc.knn, ws.customer[sampB,2])
  mcrate[i] <- (sum(cr)-sum(diag(cr)))/sum(cr)
}
# plot(3:20, mcrate[3:20], type="l") 
# bullshit, 最低时为other region全分类
 
# 变量基准化（各变量min＝0， max＝1）， 标准化（min＝0， std＝1）


