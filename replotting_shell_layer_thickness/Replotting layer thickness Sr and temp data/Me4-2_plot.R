#Code to read in and plot nacre layer thickness, Strontium data, and
#temperature data for Me4-2 
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//18-Claire-Pupa//nacre-T//Figures//Fig. 5 Files//csv")
library(gplots)
library(Hmisc)

me4_2_Sr_ian <- as.data.frame(read.table("Me4-2_SrKa.csv",header=TRUE,sep=","))

me4_2_lt <- as.data.frame(read.table("05-Me4-2 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me4_2_Sr <- as.data.frame(read.table("05-me4-2.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
me4_2_Sr$me4_2p2_300_400_AVG_data_NACRE_ONLY <- me4_2_Sr$me4_2p2_300_400_AVG_data_NACRE_ONLY*0.134496
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

me4_2_Sr$sr_ppm <- me4_2_Sr_ian$sr_ppm[280:572]

water_temp4_2 <- water_temp$water_temp_cel[3259:3537]

#-----------------------------------------------------------------------
#Code to create triple y-axis plot 
#With large font formatting for publication
#x-axis: Distance from N0 (µm)
#y-axes: Layer thickness (µm); Sr con. (ppm); H20 Temp (°C)
#-----------------------------------------------------------------------

xmarks <- c(100,300,500)
par(mar=c(6.5,7,5,10),ps=18,cex.main=2.75,cex.axis=2.0)
plot(me4_2_lt$s03mMe4m2LayerThicknes_axis, me4_2_lt$layer_thickness_mic, type="n", main="Me4-2",
     xlab=" ",
     ylab=" ",
     ylim=c(0,1.9),
     xlim=c(-20,570),
     col.axis="seagreen",
     col.ticks="seagreen",
     cex.lab=2.5,
     xaxt="n",
     lwd.ticks=4)
axis(side=1,col.axis="black",col="black",at=xmarks,lwd.ticks=4,srt=45)
mtext("Distance from" ~ N[0] ~ "(µm)", side=1, line=4.5,col="black",cex=2.5)
lines(me4_2_lt$s03mMe4m2LayerThicknes_axis, me4_2_lt$layer_thickness_mic, type="l",
      col="seagreen",lwd=2)
mtext("Layer Thickness (µm)", side=2, line=4,col="seagreen",cex=2.5)
par(new=T)
plot(me4_2_Sr$me4_2p2_300_400_AVG_axis_toNPboundary, me4_2_Sr$sr_ppm, type="n", main="",
     xlab=" ",
     ylab=" ",
     ylim=c(500,2500),
     xlim=c(-20,570),
     yaxt="n",
     xaxt="n")
axis(side=4,col="red",col.axis="red",lwd.ticks=4)
lines(me4_2_Sr$me4_2p2_300_400_AVG_axis_toNPboundary, me4_2_Sr$sr_ppm, type="l",
      col="red",lwd=4)
mtext("Sr Concentration (ppm)", side=4, line=3, col="red",cex=2.5)
par(new=T)
plot(water_temp4_2, type="n", main="",
     xlab=" ",
     ylab=" ",
     ylim=c(0,25),
     xaxt="n",
     yaxt="n")
axis(side=4,line=4.75,col="dodgerblue2",col.axis="dodgerblue2",lwd.ticks=4)
lines(water_temp4_2, type="l",
      col="dodgerblue2",lwd=4)
mtext("Water Temperature (°C)", side=4, line=8.25, col="dodgerblue2",cex=2.5)

