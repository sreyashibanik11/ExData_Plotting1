##*********************************************************************************************##

## Loading dataset
pwrcondata<-read.table("household_power_consumption.txt",sep=";",stringsAsFactors = FALSE)

## Modifying Column Names
cnames<-c("Date","Time","Global_Active_Power","Global_Reactive_Power","Voltage","Global_Intensity","Sub_Metering_1","Sub_Metering_2","Sub_Metering_3")
pwrcondata<-pwrcondata[2:nrow(pwrcondata),]
colnames(pwrcondata)<-cnames

## Converting "?" to NAs
pwrcondata[pwrcondata=="?"]<-NA

## Converting Date from string to Date type
pwrcondata$Date=as.Date(pwrcondata$Date,format="%d/%m/%Y")

## Subsetting data based on date
pwrcondata<-pwrcondata[pwrcondata$Date>=as.Date("2007-02-01") & pwrcondata$Date<=as.Date("2007-02-02"),]
  
## Merging date and time to create new posix object
pwrcondata$posix<-as.POSIXct(strptime(paste(pwrcondata$Date,pwrcondata$Time,sep=" "),format = "%Y-%m-%d %H:%M:%S"))

## Converting Global_Active_Power from string to numeric type
pwrcondata$Global_Active_Power<-as.numeric(pwrcondata$Global_Active_Power)

## Plotting the graph
png(file="plot2.png",width = 480,height=480)
with(pwrcondata,plot(posix,Global_Active_Power,type = "l",xlab="",ylab="Global Active Power(killowatts)"))

## Closing PNG device
dev.off()
##*********************************************************************************************##