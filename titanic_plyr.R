#Learning Plyr
library("plyr")
library("extrafont")
font_import()
loadfonts()
fonts()
fonttable()

titanic <- read.table("titanic.csv", sep = ",", header = TRUE)
names(titanic)
class(titanic$Class)
class(titanic$Sex)
class(titanic$Age)
class(titanic$Survived)
class(titanic$Freq)

ddply(titanic, .(Class), function(df)median(df$Freq))
ddply(titanic, .(Sex), function(df)median(df$Freq))
ddply(titanic, .(Age), function(df)median(df$Freq))
ddply(titanic, .(Survived, Sex), function(df)median(df$Freq))
class(ddply(titanic, .(Survived, Class), function(df)mean(df$Freq)))
test <- ddply(titanic, .(Survived, Class), function(df)mean(df$Freq))

ddply(titanic, .(Class), function(df)mean(df$Freq))

ddply(titanic, .(Survived, Class), function(df){as.data.frame(table(df$Survived, df$Class)/length(df$Class))})

ddply(titanic, c("Survived", "Class"), function(df)mean(df$Freq))
ddply(titanic, c("Survived", "Class"), summarize, People = sum(Freq))
summarize(titanic, num_genders = length(unique(Sex)))

transform(titanic, Freq = -Freq)
transform(titanic, Survived = "Maybe")

ddply(titanic, .(Class), transform, total.count = sum(Freq))

