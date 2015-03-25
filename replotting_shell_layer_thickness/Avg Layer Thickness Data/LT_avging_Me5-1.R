#Code to avg. layer thickness data for Me3-3 and assign an avg.
#LT value to each temperature data point 
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

me5_1_lt <- as.data.frame(read.table("06-Me5-1 Layer Thickness Data_matched to Sr concentration.csv",header=TRUE,sep=","))
me5_1_Sr <- as.data.frame(read.table("06-Me51_SrKa_510_540_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

water_temp5_1 <- water_temp$water_temp_cel[2640:3410]

#Subsetting layer thickness data so we can compare it to the water temperature data
num_2 <- 0
num_3 <- 0
me5_1_lt_red <- matrix(data = 0, nrow=771, ncol=1)
row_count <- 1

for (i in 1:771){
  if (num_2 == 116 & num_3 == 655){break}
  if (num_2 == 116 & num_3 <  655){
    me5_1_lt_red[i] <- mean(me5_1_lt$layer_thickness_mic[row_count:row_count+2])
    row_count <- row_count+3
    num_3 <- num_3+1
  }
  if (num_3 == 655 & num_2 <  116){
    me5_1_lt_red[i] <- mean(me5_1_lt$layer_thickness_mic[row_count:row_count+1])
    row_count <- row_count+2
    num_2 <- num_2+1
  }
  if (num_3 < 655 & num_2<116) {
    if (sample(1:2,1)==1){
      me5_1_lt_red[i] <- mean(me5_1_lt$layer_thickness_mic[row_count:row_count+1])
      row_count <- row_count+2
      num_2 <- num_2+1
    }
    else {
      me5_1_lt_red[i] <- mean(me5_1_lt$layer_thickness_mic[row_count:row_count+2])
      row_count <- row_count+3
      num_3 <- num_3+1
    }
  }
}

#Plotting results
plot(me5_1_lt_red ~ water_temp5_1,
     main="Nacre Layer Thickness vs. Environmental Temperature",
     xlab="Water Temperature (°C)",
     ylab="Layer Thickness (µm)")

#Consolidating data and writing out to .csv file
Me5_1_LTavg_T <- cbind(me5_1_lt_red,water_temp5_1)
Me5_1_LTavg_T <- as.data.frame(me5_1_lt_red)
colnames(Me5_1_LTavg_T) <- cbind("LT_mic","T_degC")
write.table(Me5_1_LTavg_T,file="Me5_1_ltVT.csv",append=FALSE,quote=FALSE,sep=",",
            eol="\n",na="NA",dec=".",row.names=FALSE)