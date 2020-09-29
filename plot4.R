#If the zipped folder containing the dataset doesn't exist in the working
#directory, download the dataset, and unzip it.
if( !file.exists("data.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold
                _power_consumption.zip", destfile="./data.zip")
  unzip("data.zip")
}

#read the entire dataset and subset the required rows
all_data<-read.table("./household_power_consumption.txt", head=T, sep=";",
                     na.str="?", colClasses=c(rep("character",2),rep("numeric",7)))
plot_data<-subset(all_data, dmy(all_data[,1])==dmy("01/02/2007")|
                    dmy(all_data[,1])==dmy("02/02/2007"))

#make a single datetime column
plot_data<-plot_data %>% 
  mutate(datetime=dmy(Date)+hms(Time), .before=1, Date=NULL, Time=NULL)

