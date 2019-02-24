ws.customer <- read.csv("Wholesale customers data.csv")
ws.customer$Channel <- factor(ws.customer$Channel, labels=c("Horeca","Retail"))
ws.customer$Region <- factor(ws.customer$Region, labels=c("Lisbon","Oporto","Other Region"))
channel.tab <- table(ws.customer$Channel)
# qplot(Channel, data=ws.customer, fill=Region, ylab="count", position="fill")
# hist(ws.customer$Milk, breaks=10, xlim=c(0,80000), ylim=c(0,400), main="")
# plot(ws.customer$Detergents_Paper, ws.customer$Delicassen, xlab="Det", ylab="Deli")
qplot(Grocery, Detergents_Paper, color=Region, size=Fresh, data=ws.customer, facets = ~Region)
 
