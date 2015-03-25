#Code to read in and plot nacre layer thickness, Strontium data, and
#temperature data for Me5-1 
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//18-Claire-Pupa//nacre-T//Figures//Fig. 5 Files//csv")
library(gplots)
library(Hmisc)

me3_3_lt <- as.data.frame(read.table("03-Me3-3 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me3_3_Sr <- as.data.frame(read.table("03-me3-3.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
me3_3_temp <- as.data.frame(read.table("03-date_wt_Me3-3.csv",header=TRUE,sep=","))

lc1_2_lt <- as.data.frame(read.table("07-Lc_lt.csv",header=TRUE,sep=","))

xmarks <- c(0,2000,4000)
#par(mfrow=c(2,3)) # all plots on one page 
par(mar=c(6.5,7,5,10),ps=18,cex.main=2.75,cex.axis=2.0)
#Lc1-2 Plot
plot(lc1_2_lt$distance_mic, lc1_2_lt$avg_lt_mic, type="n", main="Lc1-2",
     xlab=" ",
     ylab=" ",
     ylim=c(0,1.9),
     xlim=c(-20,4000),
     yaxt="n",
     xaxt="n",
     cex.lab=2.5)
mtext("Distance from" ~ N[0] ~ "(µm)", side=1, line=4.5,col="black",cex=2.5)
axis(side=1,col.axis="black",col="black",at=xmarks,lwd.ticks=4)
axis(side=2,col.axis="seagreen",col="seagreen",lwd.ticks=4)
lines(lc1_2_lt$distance_mic, lc1_2_lt$avg_lt_mic, type="l",
      col="seagreen",lwd="2")
mtext("Layer Thickness (µm)", side=2, line=4,col="seagreen",cex=2.5)

