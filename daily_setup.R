#This code is to set up the variables and functions that I'll need for whatever work I'm doing 
#for the rest of the day
#C. B. Salling 2014-9-22

#Loading libraries ----
library(ggplot2)
library(scales)
library(plyr)
library(chron)
library(stringr)

#Palette of former Options Away colors; 8 total ----
palette <- c('#8CC63F','#34929c','#005f7b','#011635',
                    '#e8175d','#a6a6a6','#505050','#000000')

#Themes for constructing plots ----
oa_theme_ns <- theme(legend.position = 'none',
                     text = element_text(size = 20, color = 'black'),
                     axis.text.x = element_text(size = 20, color = 'gray30',vjust=-.11),
                     axis.text.y = element_text(size = 20, color = 'gray30'),
                     axis.title.x = element_text(size = 25, color = 'black',vjust = -0.25),
                     axis.title.y = element_text(size = 25, color = 'black', vjust = 1.25),
                     title = element_text(size = 22.5)
                     )

oa_theme_sc <- theme(text = element_text(size = 20, color = 'black'),
                     axis.text.x = element_text(size = 20, color = 'gray30'),
                     axis.text.y = element_text(size = 20, color = 'gray30'),
                     axis.title.x = element_text(size = 25, color = 'black',vjust = -0.25),
                     axis.title.y = element_text(size = 25, color = 'black', vjust = 1.25),
                     title = element_text(size = 22.5)
                     )

theme_xkcd <- theme(panel.background = element_rect(fill="white"),
                    axis.ticks = element_line(colour=NA),
                    panel.grid = element_line(colour="white"),
                    axis.text.y = element_text(colour=NA),
                    axis.text.x = element_text(colour="black"),
                    text = element_text(size=16, family="HumorSans")
                    )

#Shorthand for formatting the axes ----
y_percent <- scale_y_continuous(labels=percent_format())
y_dollar <- scale_y_continuous(labels=dollar)
x_dollar <- scale_x_continuous(labels=dollar)
endxmas1 <- geom_vline(xintercept = as.numeric(as.Date('2015-01-10')),linetype = 'longdash')
endxmas2 <- annotate('text', x = as.Date('2015-03-15'), y = .015, label = 'End of holidays\n2015-01-10')

