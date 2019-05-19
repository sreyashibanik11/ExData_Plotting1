##*********************************************************************************************##

## Loading dataset
pwrcondata<-read.table("household_power_consumption.txt",sep=";",stringsAsFactors = FALSE)

## Modifying Column Names
cnames<-c("Date","Time","Global_Active_Power","Global_Reactive_Power","Voltage","Global_Intensity","Sub_Metering_1","Sub_Metering_2","Sub_Metering_3")
pwrcondata<-pwrcondata[2:nrow(pwrcondata),]
colnames(pwrcondata)<-cnames

## Converting Date from string to Date type
pwrcondata$Date=as.Date(pwrcondata$Date,"%d/%m/%Y")

## Subsetting data based on date and desired column
gactivepower<-subset(pwrcondata,Date=="2007-02-01" | Date=="2007-02-02",Global_Active_Power)

## Removing missing values
gactivepower<-gactivepower[gactivepower!="?"]

## Converting gactivepower from string to numeric type
gactivepower<-as.numeric(gactivepower)

## Ploting the histogram
hist(gactivepower,col="#FF004F",xlab="Global Active Power(killowatts)",main="Global Active Power")

## Copying the histogram to png device
dev.copy(png,file="plot1.png")

## Closing current deviceS
dev.off()

##******************************************************************************************************##