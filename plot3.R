plot3  <- function() {
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
        png("plot3.png", width=480, height=480)
        
        #set the plot window for 1 panel
        par(mfrow=c(1,1))
        #par(mar=c(5, 4, 4, 2))
        #create the plot frame
        with (subdf, plot(DateTime,Sub_metering_1, ylab = "Energy sub metering" ,xlab="" ,  type="n") )
        #add the first variable 
        with (subdf, points(DateTime,Sub_metering_1, type= "l", col = 'black' ) )
        #add the second variable 
        with (subdf, points(DateTime,Sub_metering_2, type = "l", col = 'red' ) )
        #add the third variable 
        with (subdf, points(DateTime,Sub_metering_3, type = "l", col = 'blue' ) )
        #add the legend to the top right
        legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex = 1)

        #write png file to disk
        dev.off()
}