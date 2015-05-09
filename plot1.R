plot1  <- function() {
        #This function plots the histogram of power Global Active Power
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
        png("plot1.png", width=480, height=480)
        
        #set the plot window for 1 panel
        par(mfrow=c(1,1))
        #plot the histogram
        hist(as.numeric(subdf$Global_active_power),col="red",xlim=c(0,6),ylim=c(0,1200),main="Global Active Power",xlab="Global Active Power (kilowatts)",xaxt='n')
        #set the x axis labels
        axis(side=1,at=seq(0,6,2),labels=seq(0,6,2))

        #write png file to disk
        dev.off()
}