#Code to avg. layer thickness data for Me3-3 and assign an avg.
#LT value to each temperature data point 
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

me4_2_lt <- as.data.frame(read.table("05-Me4-2 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me4_2_Sr <- as.data.frame(read.table("05-me4-2.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

water_temp4_2 <- water_temp$water_temp_cel[3259:3537]

#Subsetting layer thickness data so we can compare it to the water temperature data
num_5 <- 0
num_6 <- 0
me4_2_lt_red <- matrix(data = 0, nrow=279, ncol=1)
row_count <- 1

for (i in 1:279){
  if (num_5==82 & num_6==197){break}
  if (num_5 == 82 & num_6<197) {
    me4_2_lt_red[i] <- mean(me4_2_lt$layer_thickness_mic[row_count:row_count+5])
    row_count <- row_count+6
    num_6 <- num_6+1
  }
  if (num_6 == 197 & num_5<82){
    me4_2_lt_red[i] <- mean(me4_2_lt$layer_thickness_mic[row_count:row_count+4])
    row_count <- row_count+5
    num_5 <- num_5+1
  }
  if (num_6 < 197 & num_5<82) {
    if (sample(1:2,1)==1){
      me4_2_lt_red[i] <- mean(me4_2_lt$layer_thickness_mic[row_count:row_count+4])
      row_count <- row_count+5
      num_5 <- num_5+1
    }
    else {
      me4_2_lt_red[i] <- mean(me4_2_lt$layer_thickness_mic[row_count:row_count+5])
      row_count <- row_count+6
      num_6 <- num_6+1
    }
  }
}

#Plotting results
plot(me4_2_lt_red ~ water_temp4_2,
     main="Nacre Layer Thickness vs. Environmental Temperature",
     xlab="Water Temperature (°C)",
     ylab="Layer Thickness (µm)")

#Consolidating data and writing out to .csv file
Me4_2_LTavg_T <- cbind(me4_2_lt_red,water_temp4_2)
Me4_2_LTavg_T <- as.data.frame(Me4_2_LTavg_T)
colnames(Me4_2_LTavg_T) <- cbind("LT_mic","T_degC")
write.table(Me4_2_LTavg_T,file="Me4-2_ltVT.csv",append=FALSE,quote=FALSE,sep=",",
            eol="\n",na="NA",dec=".",row.names=FALSE)