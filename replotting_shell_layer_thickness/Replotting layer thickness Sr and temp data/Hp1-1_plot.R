#Code to read in and plot nacre layer thickness, Strontium data, and
#temperature data for Hp1-1
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//18-Claire-Pupa//nacre-T//Figures//Fig. 5 Files//csv")
library(gplots)
library(Hmisc)

hp1_1_lt <- as.data.frame(read.table("08-Hp1-1 Layer Thickness Data.csv",header=TRUE,sep=","))

xmarks <- c(0,75,150,225)
#par(mfrow=c(2,3)) # all plots on one page 
par(mar=c(6.5,7,5,10),ps=18,cex.main=2.75,cex.axis=2.0)
#Hp1-1 Plot
plot(hp1_1_lt$rel_lay_cen_WRTS_mic, hp1_1_lt$layer_thickness_mic, type="n", main="Hp1-1",
     xlab=" ",
     ylab=" ",
     ylim=c(0,1.9),
     xlim=c(-20,261),
     cex.lab=2.5,
     yaxt="n",
     xaxt="n")
axis(side=1,col.axis="black",col="black",at=xmarks,lwd.ticks=4)
mtext("Distance from" ~ N[0] ~ "(µm)", side=1, line=4.5,col="black",cex=2.5)
axis(side=2,col.axis="seagreen",col="seagreen",lwd.ticks=4)
lines(hp1_1_lt$rel_lay_cen_WRTS_mic, hp1_1_lt$layer_thickness_mic, type="l",
      col="seagreen",lwd=2)
mtext("Layer Thickness (µm)", side=2, line=4,col="seagreen",cex=2.5)

