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

#make first column a date variable, second column a time variable
plot_data[,1]<-dmy(plot_data[,1])
plot_data[,2]<-hms(plot_data[,2])

#making required plot and saving as png
png("plot3.png",width=480,height=480)
plot(plot_data$Sub_metering_1,type="n",axes=F,xlab="",ylab="Energy sub metering")
box()
axis(1,at=c(0,1500,2900),labels=c("Thurs","Fri","Sat"))
axis(2,at=c(0,10,20,30))
points(plot_data$Sub_metering_1,typ="l",col="black")
points(plot_data$Sub_metering_2,typ="l",col="red")
points(plot_data$Sub_metering_3,typ="l",col="blue")
legend("topright",legend=c("Sub metering 1","Sub metering 2","Sub metering 3"),
       lwd=c(1,1,1),col=c("black","red","blue"))
dev.off()