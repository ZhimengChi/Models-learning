api_url <- "https://api.weibo.com/2/statuses/home_timeline.json"
access_token <- "2.00ZkhgbHZZkUbD2d63647721ExpuiB"
data <- readLines(paste(api_url, "?access_token=", access_token, "&count=100", sep=""))
wobject <- fromJSON(data)
weibo <- list()
for(i in 1:length(wobject$statuses)){
  weibo$text[i] <- wobject$statuses[[i]]$text
  weibo$created[i] <- wobject$statuses[[i]]$created_at
}

#柱状图
Sys.setlocale("LC_TIME", "English")
for ( i in 1:length(wobject$statuses)){
  weibo$created[i] <- as.Date(paste(substring(weibo$created[i],5,19), substring(weibo$created[i],27,30)), format="%B %d %H: %M: %S %Y")
}
wb <- data.frame(text=weibo$text, created=weibo$created)
wb.daily <- wb %>% mutate(wbdate=created) %>% group_by(wbdate) %>% summarize(cnt=n())
dailydf <- data.frame(wb.daily)
barplot(dailydf$cnt, names.arg=dailydf$wbdate)

#分词及词频统计,使用Rwordseg进行中文分词
wb.txt <- unique(wb$text)
wb.txt <- gsub("[[:print]]", "", wb.txt, perl=TRUE)
wb.txt <- gsub("[｛｝［］（）｀，。？！：；“”]", "", wb.txt, perl=TRUE)
# library(Rwordseg)
res = wb.txt
res=res[res!=" "]
words=unlist(lapply(X=res, FUN=segmentCN))
word=lapply(X=words, FUN=strsplit, " ")
v=table(unlist(word))
v=sort(v, decreasing=T)
d=data.frame(word=names(v),freq=v)
d=d[-which(nchar(as.character(d[,1]))<2),] #处理stopword，通常用表格，这里只去除长度为1的词
d=d[which(d$word!="cn" & d$word!="http"),]
dd <- subset(d,rank(-freq.Freq)<25)
ggplot(dd, aes(x=reorder(word, freq.Freq), y=freq.Freq))+
  geom_bar(stat="identity", fill="grey", color="black")+
  theme(text = element_text(family='STXihei'))+
  coord_flip() + xlab("word") +
  ylab("frequency")

# 词云图
# library(wordcloud)
# library(RColorBrewer)
dd <- subset(d, freq.Freq>=2)
pal <- brewer.pal(8, "Dark2")
wordcloud(dd$word, dd$freq.Freq, scale=c(4,.2), random.order=T, rot.per=.15, colors=pal, family="STXihei")
