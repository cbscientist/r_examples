#Code to avg. layer thickness data for Me3-3 and assign an avg.
#LT value to each temperature data point 
#2014-02-23
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

me3_3_lt <- as.data.frame(read.csv("03-Me3-3 Layer Thickness Data matched to Sr concentration.csv"))
me3_3_Sr <- as.data.frame(read.csv("03-me3-3.2_Sr Ka_300_400_AVG_NACRE.csv"))
water_temp <- as.data.frame(read.csv("water Temp vs. date.csv")

water_temp3_3 <- water_temp$water_temp_cel[3219:3537]

#Setting up tools to subset and avg. LT data so
#we can match to T data
num_7 <- 0
num_8 <- 0
me3_3_lt_red <- matrix(data = 0, nrow=319, ncol=1)
row_count <- 1

#Actually subsetting and averaging
for (i in 1:319){
  if (num_7==176 & num_8==143){break}
  if (num_7 == 176 & num_8<143) {
    me3_3_lt_red[i] <- mean(me3_3_lt$Layer_Thickness_mic[row_count:row_count+7])
    if (me3_3_lt_red[i] < 0.01){print(row_count)}
    row_count <- row_count+8
    num_8 <- num_8+1
  }
  if (num_8 == 143 & num_7<176){
    me3_3_lt_red[i] <- mean(me3_3_lt$Layer_Thickness_mic[row_count:row_count+6])
    if (me3_3_lt_red[i] < 0.01){print(row_count)}
    row_count <- row_count+7
    num_7 <- num_7+1
  }
  if (num_8 < 143 & num_7<176) {
    if (sample(1:2,1)==1){
      me3_3_lt_red[i] <- mean(me3_3_lt$Layer_Thickness_mic[row_count:row_count+6])
      if (me3_3_lt_red[i] < 0.01){print(row_count)}
      row_count <- row_count+7
      num_7 <- num_7+1
    }
    else {
      me3_3_lt_red[i] <- mean(me3_3_lt$Layer_Thickness_mic[row_count:row_count+7])
      if (me3_3_lt_red[i]< 0.01){print(row_count)}
      row_count <- row_count+8
      num_8 <- num_8+1
    }
  }
}

#Plotting results
plot(me3_3_lt_red ~ water_temp3_3,
     main="Nacre Layer Thickness vs. Environmental Temperature",
     xlab="Water Temperature (°C)",
     ylab="Layer Thickness (µm)")

#Linear fit and summary of fit
lm.Me3_3 <- lm(me3_3_lt_red ~ water_temp3_3)
rs.Me3_3 <- summary(lm.Me3_3)$r.squared
slope.Me3_3 <- summary(lm.Me3_3)$coefficients[2, 1]
slope.2text <- as.character(round(slope.Me3_3,3))
corco.ang <- cor(me3_3_lt_red,water_temp3_3)

#Consolidating data and writing out to .csv file
Me3_3_LTavg_T <- cbind(me3_3_lt_red,water_temp3_3)
Me3_3_LTavg_T <- as.data.frame(Me3_3_LTavg_T)
colnames(Me3_3_LTavg_T) <- cbind("LT_mic","T_degC")
write.table(Me3_3_LTavg_T,file="Me3-3_ltVT.csv",append=FALSE,quote=FALSE,
            sep=",",eol="\n",na="NA",dec=".",row.names=FALSE)