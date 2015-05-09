plot4  <- function() {
        #This function plots plot3
        #packages lubridate and sqldf must be installed to run this
        
        #check for the test data file in the current directory
        if (!file.exists("household_power_consumption.txt")) stop("Test data file is not in the current directory")
        
        #load the libraries
        library(lubridate)
        library(sqldf)
        
        #load the whole data set into a dataframe
        consf <- read.table("household_power_consumption.txt", header=TRUE, sep=";",colClasses = "character")
        #load the subset for the two dates of interest into another dataframe
        subdf <- sqldf("select * from consf where Date in('1/2/2007','2/2/2007')")
        #create a new column with date and time together as a datetime class
        subdf$DateTime <- dmy_hms(paste(subdf$Date,subdf$Time))

        #write to png file
        png("plot4.png", width=480, height=480)
        
        #set the window for 4 panels - 2 col, 2 row
        par(mfrow=c(2,2))
        #plot
        with (subdf, {
                # 1st panel
                plot(DateTime,Global_active_power,type='l',ylab="Global Active Power",xlab="")
                # 2nd panel
                plot(DateTime,Voltage,type='l',ylab="Voltage",xlab="datetime")
                # 3rd panel (with 3 points)
                plot(DateTime,Sub_metering_1, ylab = "Energy sub metering" ,xlab="" ,  type="n")
                points(DateTime,Sub_metering_1, type= "l", col = 'black' )
                points(DateTime,Sub_metering_2, type = "l", col = 'red' )
                points(DateTime,Sub_metering_3, type = "l", col = 'blue' )
                legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty="n")
                # 4th panel
                plot(DateTime,Global_reactive_power,type='l',ylab="Global_reactive_power",xlab="datetime")        
        })
        
        #write png file to disk
        dev.off()
}