#Code to read in data about various Me shells and provide
#summary of data
#2014-02-25
#C. B. Salling

#Set current working directory and load files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

me3_3_lt <- as.data.frame(read.table("03-Me3-3 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me3_3_Sr <- as.data.frame(read.table("03-me3-3.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp3_3 <- water_temp$water_temp_cel[3219:3537]

me4_1_lt <- as.data.frame(read.table("04-Me4-1 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me4_1_Sr <- as.data.frame(read.table("04-me4-1.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp4_1 <- water_temp$water_temp_cel[3214:3537]

me4_2_lt <- as.data.frame(read.table("05-Me4-2 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me4_2_Sr <- as.data.frame(read.table("05-me4-2.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp4_2 <- water_temp$water_temp_cel[3259:3537]

me5_1_lt <- as.data.frame(read.table("06-Me5-1 Layer Thickness Data_matched to Sr concentration.csv",header=TRUE,sep=","))
me5_1_Sr <- as.data.frame(read.table("06-Me51_SrKa_510_540_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp5_1 <- water_temp$water_temp_cel[2640:3410]

mean(me3_3_lt$Layer_Thickness_mic)
mean(me4_1_lt$layer_thickness_mic)
mean(me4_2_lt$layer_thickness_mic)
mean(me5_1_lt$layer_thickness_mic)

max(me3_3_lt$s03mMe3m3LayerThicknes_axis)
max(me4_1_lt$s03mMe4m1LayerThicknes_axis)
max(me4_2_lt$s03mMe4m2LayerThicknes_axis)
max(me5_1_lt$s03mMe5m1LayerThicknes_axis)
