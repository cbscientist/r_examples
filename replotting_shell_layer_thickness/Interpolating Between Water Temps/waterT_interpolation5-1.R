#Code to interpolate between water temperature data points
#2014-02-24
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

#Load data
me5_1_lt <- as.data.frame(read.table("06-Me5-1 Layer Thickness Data_matched to Sr concentration.csv",header=TRUE,sep=","))
me5_1_Sr <- as.data.frame(read.table("06-Me51_SrKa_510_540_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

#Isolate T data that Ian assigned to span of nacre measurements
water_temp5_1 <- water_temp[2640:3410]

#Set up tools to create empty matrix of same size as nacre thickness vector
#and populate it sparsely with temperature data
num_layers <- dim(me5_1_lt)[1]
gap1 <- 1
gap2 <- 2
num_1 <- 0
num_2 <- 0
water_count=1
row_count=1
waterfill <- matrix(data=0, nrow=num_layers, ncol=1)

#Populating sparsely the empty matrix with temperature data
for(i in 1:770){#imax = number of temperature points to start with 
  if(row_count==1){waterfill[row_count]=water_temp5_1[water_count]
           water_count = water_count + 1
           row_count   = row_count + 1
  }
  else{
           if (sample(1:2,1)==1){
             if(num_1==114 & num_2==656){break}
             if (num_1<114){
               waterfill[row_count+gap1] <- water_temp5_1[water_count]
               water_count=water_count+1
               row_count = row_count+gap1+1
               num_1 <- num_1+1
               print(row_count)
             }
             if (num_1>=114){
               waterfill[row_count+gap2] <- water_temp5_1[water_count]
               water_count=water_count+1
               row_count = row_count+gap2+1
               num_2 <- num_2+1
               print(row_count)
             }
           }
           else{
             if(num_1==114 & num_2==656){break}
             if (num_2<656){
               waterfill[row_count+gap2] <- water_temp5_1[water_count]
               water_count=water_count+1
               row_count = row_count+gap2+1
               num_2 <- num_2+1
               print(row_count)
             }
             if (num_2>=656){
               waterfill[row_count+gap1] <- water_temp5_1[water_count]
               water_count=water_count+1
               row_count = row_count+gap1+1
               num_1 <- num_1+1
               print(row_count)
             }
           }
  }
}

#Previous code extended matrix past what it should be, this 
#cuts it down to desired size (bit of a kludge)
waterfill <- waterfill[1:2197]

#Interpolates between data points in sparse temperature matrix
row_count2 <- 1
for (i in 1:num_layers){
  base_el <- waterfill[row_count2]
  if(row_count2==2197){
    print(row_count2)
    break
  }
  for (j in 1:10){
    if (waterfill[j+row_count2]!=0){
      top_el <- waterfill[j+row_count2]
      numel=j-1
      break
    }
  }
  step = abs((top_el - base_el)/(numel+1))
  for (k in 1: numel){
    if (top_el > base_el){
      waterfill[k+row_count2] <- base_el + (step*k)
    }
    if (top_el < base_el){
      waterfill[k+row_count2] <- base_el - (step*k)
    }
  }
  row_count2 <- row_count2 + numel + 1
}

#Converts interpolated temperature matrix to data frame
waterfill <- as.data.frame(waterfill)

#Merge layer thickness data and interpolated temperature data and write 
#out to a .csv file
etempVlt_me5_1 <- cbind(me5_1_lt$layer_thickness_mic,waterfill)
write.table(etempVlt_me5_1,file="Me5-1_waterfill.csv",append=FALSE,quote=FALSE,
            sep=",",eol="\n",na="NA",dec=".",row.names=FALSE)




