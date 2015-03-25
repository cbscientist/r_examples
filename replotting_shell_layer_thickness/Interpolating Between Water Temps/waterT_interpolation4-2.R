#Code to interpolate between water temperature data points
#2014-02-24
#C.B. Salling

#Set and check current working directory, list current files
setwd("//Users//clairesalling//Dropbox//11-Shell Paleothermometer//Replotting_shell_lt")
library(gplots)
library(Hmisc)

#Load data
me4_2_lt <- as.data.frame(read.table("05-Me4-2 Layer Thickness Data matched to Sr concentration.csv",header=TRUE,sep=","))
me4_2_Sr <- as.data.frame(read.table("05-me4-2.2_Sr Ka_300_400_AVG_NACRE.csv",header=TRUE,sep=","))
water_temp <- as.data.frame(read.table("water Temp vs. date.csv",header=TRUE,sep=","))

#Isolate T data that Ian assigned to span of nacre measurements
water_temp4_2 <- me4_2_temp$water_temp_cel[3259:3537]

#Set up tools to create empty matrix of same size as nacre thickness vector
#and populate it sparsely with temperature data
num_layers <- dim(me4_2_lt)[1]
gap1 <- 4
gap2 <- 5
num_4 <- 0
num_5 <- 0
water_count=1
row_count=1
waterfill <- matrix(data=0, nrow=num_layers, ncol=1)

#Populating sparsely the empty matrix with temperature data
for(i in 1:278){#imax = number of temperature points to start with
  if(row_count==1){waterfill[row_count]=water_temp4_2[water_count]
           water_count = water_count + 1
           row_count   = row_count + 1
  }
  else{
           if (sample(1:2,1)==1){
             if(num_4==77 & num_5==201){break}
             if (num_4<77){
               waterfill[row_count+gap1] <- water_temp4_2[water_count]
               water_count=water_count+1
               row_count = row_count+gap1+1
               num_4 <- num_4+1
               print(row_count)
             }
             if (num_4>=77){
               waterfill[row_count+gap2] <- water_temp4_2[water_count]
               water_count=water_count+1
               row_count = row_count+gap2+1
               num_5 <- num_5+1
               print(row_count)
             }
           }
           else{
             if(num_4==77 & num_5==201){break}
             if (num_5<201){
               waterfill[row_count+gap2] <- water_temp4_2[water_count]
               water_count=water_count+1
               row_count = row_count+gap2+1
               num_5 <- num_5+1
               print(row_count)
             }
             if (num_5>=201){
               waterfill[row_count+gap1] <- water_temp4_2[water_count]
               water_count=water_count+1
               row_count = row_count+gap1+1
               num_4 <- num_4+1
               print(row_count)
             }
           }
  }
}

#Interpolates between data points in sparse temperature matrix
row_count2 <- 1
for (i in 1:num_layers){
  base_el <- waterfill[row_count2]
  if(row_count2==1592){
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
etempVlt_me4_2 <- cbind(me4_2_lt$layer_thickness_mic,waterfill)
write.table(etempVlt_me4_2,file="Me4-2_waterfill.csv",append=FALSE,quote=FALSE,
            sep=",",eol="\n",na="NA",dec=".",row.names=FALSE)




