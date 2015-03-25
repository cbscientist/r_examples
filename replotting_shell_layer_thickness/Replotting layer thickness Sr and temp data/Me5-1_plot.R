#Code to read in and plot nacre layer thickness, Strontium data, and
#temperature data for Me5-1 
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//18-Claire-Pupa//nacre-T//Figures//Fig. 5 Files//csv")
library(gplots)
library(Hmisc)

me5_1_Sr_ian <- as.data.frame(read.table("Me5-1_SrKa.csv",header=TRUE,sep=","))

me5_1_lt <- as.data.frame(read.table("06-Me5-1 Layer Thickness Data_matched to Sr concentration.csv",header=TRUE,sep=","))
me5_1_Sr <- as.data.frame(read.table("06-Me51_SrKa_510_540_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

#max(me5_1_Sr$sr_ppm)
#min(me5_1_Sr$sr_ppm)
length(me5_1_Sr_ian$sr_ppm)

plot(me5_1_Sr_ian$sr_ppm)
plot(me5_1_Sr_ian$sr_ppm[171:437])
me5_1_Sr$sr_ppm <- me5_1_Sr_ian$sr_ppm[171:437]

water_temp5_1 <- water_temp$water_temp_cel[2640:3410]

#-----------------------------------------------------------------------
#Code to create triple y-axis plot 
#With large font formatting for publication
#x-axis: Distance from N0 (µm)
#y-axes: Layer thickness (µm); Sr con. (ppm); H20 Temp (°C)
#-----------------------------------------------------------------------
xmarks <- c(0,200,400,600,800,1000)
ymarks <- c(500,1000,1500,2000,2500)
par(mar=c(6.5,7,5,10),ps=18,cex.main=2.75,cex.axis=2.0)
plot(me5_1_lt$s03mMe5m1LayerThicknes_axis, me5_1_lt$layer_thickness_mic, type="n", main="Me5-1",
     xlab=" ",
     ylab=" ",
     ylim=c(0,1.9),
     xlim=c(-20,800),
     col.axis="seagreen",
     col.ticks="seagreen",
     cex.lab=2.5,lwd=4,
     lwd.ticks=4)
axis(side=1,col.axis="black",col="black",at=xmarks,lwd.ticks=4,srt=45)
mtext("Distance from" ~ N[0] ~ "(µm)", side=1, line=4.5,col="black",cex=2.5)
lines(me5_1_lt$s03mMe5m1LayerThicknes_axis, me5_1_lt$layer_thickness_mic, type="l",
      col="seagreen",lwd=2)
mtext("Layer Thickness (µm)", side=2, line=4,col="seagreen",cex=2.5)
par(new=T)
plot(me5_1_Sr$Me51_SrKa_510_540_AVG_axis_fromNPboundary, me5_1_Sr$Me51_SrKa_510_540_AVG_data_Nacre_Only, type="n", main="",
     xlab=" ",
     ylab=" ",
     ylim=c(500,2500),
     xlim=c(-20,800),
     yaxt="n",
     xaxt="n")
axis(side=4,col.axis="red",col="red",at=ymarks,lwd.ticks=4)
lines(me5_1_Sr$Me51_SrKa_510_540_AVG_axis_fromNPboundary, me5_1_Sr$sr_ppm, type="l",
      col="red",lwd=4)
mtext("Sr Concentration (ppm)", side=4, line=3, col="red",cex=2.5)
par(new=T)
plot(water_temp5_1, type="n", main="",
     xlab=" ",
     ylab=" ",
     ylim=c(0,25),
     xaxt="n",
     yaxt="n")
axis(side=4,line=4.75,col.axis="dodgerblue2",col="dodgerblue2",lwd.ticks=4)
lines(water_temp5_1, type="l",
      col="dodgerblue2",lwd=4)
mtext("Water Temperature (°C)", side=4, line=8.25, col="dodgerblue2",cex=2.5)

