#Code to interpolate between water temperature data points
#2014-02-24
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

#Load data
me3_3_lt <- as.data.frame(read.table("03-Me3-3 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me3_3_Sr <- as.data.frame(read.table("03-me3-3.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

#Isolate T data that Ian assigned to span of nacre measurements
water_temp3_3 <- water_temp[3219:3537]

#Set up tools to create empty matrix of same size as nacre thickness vector
#and populate it sparsely with temperature data
num_layers <- dim(me3_3_lt)[1]
gap1 <- 6
gap2 <- 7
num_6 <- 0
num_7 <- 0
water_count=1
row_count=1
waterfill <- matrix(data=0, nrow=num_layers, ncol=1)

#Populating sparsely the empty matrix with temperature data
for(i in 1:319){#imax = number of temperature points to start with
  if(row_count==1){waterfill[row_count]=water_temp3_3[water_count]
           water_count = water_count + 1
           row_count   = row_count + 1
  }
  else{
           if (sample(1:2,1)==1){
             if(num_6==169 & num_7==149){break}
             if (num_6<169){
               waterfill[row_count+gap1] <- water_temp3_3[water_count]
               water_count=water_count+1
               row_count = row_count+gap1+1
               num_6 <- num_6+1
               print(row_count)
             }
             if (num_6>=169){
               waterfill[row_count+gap2] <- water_temp3_3[water_count]
               water_count=water_count+1
               row_count = row_count+gap2+1
               num_7 <- num_7+1
               print(row_count)
             }
           }
           else{
             if(num_6==169 & num_7==149){break}
             if (num_7<149){
               waterfill[row_count+gap2] <- water_temp3_3[water_count]
               water_count=water_count+1
               row_count = row_count+gap2+1
               num_7 <- num_7+1
               print(row_count)
             }
             if (num_7>=149){
               waterfill[row_count+gap1] <- water_temp3_3[water_count]
               water_count=water_count+1
               row_count = row_count+gap1+1
               num_6 <- num_6+1
               print(row_count)
             }
           }
  }
}

#Previous code extended matrix past what it should be, this 
#cuts it down to desired size (bit of a kludge)
waterfill <- waterfill[1:2376]

#Interpolates between data points in sparse temperature matrix
row_count2 <- 1
for (i in 1:num_layers){
  base_el <- waterfill[row_count2]
  if (row_count2==2371){
    print(base_el)
  }
  if (row_count2==2376){
    print(base_el)
    break}
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
etempVlt_me3_3 <- cbind(me3_3_lt$Layer_Thickness_mic,waterfill)
write.table(waterfill,file="Me3-3_waterfill.csv",append=FALSE,quote=FALSE,
            sep=",",eol="\n",na="NA",dec=".",row.names=FALSE)




