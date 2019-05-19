##**********************************************************************************

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

## Converting values from string to numeric type
pwrcondata$Global_Active_Power<-as.numeric(pwrcondata$Global_Active_Power)
pwrcondata$Global_Reactive_Power<-as.numeric(pwrcondata$Global_Reactive_Power)
pwrcondata$Voltage<-as.numeric(pwrcondata$Voltage)
pwrcondata$Sub_Metering_1<-as.numeric(pwrcondata$Sub_Metering_1)
pwrcondata$Sub_Metering_2<-as.numeric(pwrcondata$Sub_Metering_2)
pwrcondata$Sub_Metering_3<-as.numeric(pwrcondata$Sub_Metering_3)

## Plotting the graph
png(file="plot4.png",width=480,height=480)
par(mfcol=c(2,2))
with(pwrcondata,{
  plot(posix,Global_Active_Power,type = "l",xlab="",ylab="Global Active Power(killowatts)")
  plot(posix,Sub_Metering_1,type="l",xlab="",ylab="Energy Sub Metering")
  lines(pwrcondata$posix,pwrcondata$Sub_Metering_2,col="#FF3F4F")
  lines(pwrcondata$posix,pwrcondata$Sub_Metering_3,col="#003FFF")
  ## Adding legend at top-right corner
  legend("topright",legend=c('Sub Metering 1', 'Sub Metering 2', 'Sub Metering 3'),col=c('black', 'red', 'blue'), lty=c(1, 1, 1),cex=0.8,bty="n")
  plot(posix,Voltage,xlab="datetime",ylab="Voltage",type="l")
  plot(posix,Global_Reactive_Power,xlab="datetime",ylab="Global Reactive Power",type="l",lwd=0.3)
})


## Closing PNG device
dev.off()
##*********************************************************************************************##
