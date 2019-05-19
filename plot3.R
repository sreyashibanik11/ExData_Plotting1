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

## Converting submetering values from string to numeric type
pwrcondata$Sub_Metering_1<-as.numeric(pwrcondata$Sub_Metering_1)
pwrcondata$Sub_Metering_2<-as.numeric(pwrcondata$Sub_Metering_2)
pwrcondata$Sub_Metering_3<-as.numeric(pwrcondata$Sub_Metering_3)

## Plotting the graph
png(file="plot3.png",width=480,height=480)
with(pwrcondata,plot(posix,Sub_Metering_1,type="l",xlab="",ylab="Energy Sub Metering"))
lines(pwrcondata$posix,pwrcondata$Sub_Metering_2,col="#FF3F4F")
lines(pwrcondata$posix,pwrcondata$Sub_Metering_3,col="#003FFF")

## Adding legend at to-right corner
legend("topright",legend=c('Sub Metering 1', 'Sub Metering 2', 'Sub Metering 3'),col=c('black', 'red', 'blue'), lty=c(1, 1, 1))


## Closing PNG device
dev.off()
##*********************************************************************************************##
