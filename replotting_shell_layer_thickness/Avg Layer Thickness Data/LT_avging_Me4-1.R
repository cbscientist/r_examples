#Code to avg. layer thickness data for Me3-3 and assign an avg.
#LT value to each temperature data point 
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

me4_1_lt <- as.data.frame(read.table("04-Me4-1 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me4_1_Sr <- as.data.frame(read.table("04-me4-1.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

water_temp4_1 <- water_temp$water_temp_cel[3214:3537]

#Subsetting layer thickness data so we can compare it to the water temperature data
num_6 <- 0
num_7 <- 0
me4_1_lt_red <- matrix(data = 0, nrow=324, ncol=1)
row_count <- 1

#Actually subsetting and averaging
for (i in 1:324){
  if (num_6==184 & num_7==140){break}
  if (num_6 == 184 & num_7<140) {
    me4_1_lt_red[i] <- mean(me4_1_lt$layer_thickness_mic[row_count:row_count+6])
    row_count <- row_count+7
    num_7 <- num_7+1
  }
  if (num_7 == 140 & num_6<184){
    me4_1_lt_red[i] <- mean(me4_1_lt$layer_thickness_mic[row_count:row_count+5])
    row_count <- row_count+6
    num_6 <- num_6+1
  }
  if (num_7 < 140 & num_6<184) {
    if (sample(1:2,1)==1){
      me4_1_lt_red[i] <- mean(me4_1_lt$layer_thickness_mic[row_count:row_count+5])
      row_count <- row_count+6
      num_6 <- num_6+1
    }
    else {
      me4_1_lt_red[i] <- mean(me4_1_lt$layer_thickness_mic[row_count:row_count+6])
      row_count <- row_count+7
      num_7 <- num_7+1
    }
  }
}

#Plotting results
plot(me4_1_lt_red ~ water_temp4_1,
     main="Nacre Layer Thickness vs. Environmental Temperature",
     xlab="Water Temperature (°C)",
     ylab="Layer Thickness (µm)")

#Consolidating data and writing out to .csv file
Me4_1_LTavg_T <- cbind(me4_1_lt_red,water_temp4_1)
Me4_1_LTavg_T <- as.data.frame(Me4_1_LTavg_T)
colnames(Me4_1_LTavg_T) <- cbind("LT_mic","T_degC")
write.table(Me4_1_LTavg_T,file="Me4-1_ltVT.csv",append=FALSE,quote=FALSE,sep=",",
            eol="\n",na="NA",dec=".",row.names=FALSE)