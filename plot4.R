getData <- function() {
    require(sqldf);
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
    file <- download.file(url, "household_power_consumption.zip");
    
    # get the first file name in the zip file
    fname = unzip("household_power_consumption.zip", list=TRUE)$Name[1];
    
    unzip("household_power_consumption.zip", files=fname, overwrite=TRUE);
    
    query="SELECT * FROM file WHERE Date IN('1/2/2007', '2/2/2007')";
    
    data_set <- read.csv.sql( file='household_power_consumption.txt', sep=";", sql=query, header=TRUE);
    
    data_set;
}

plot4 <- function() {
    data_set <- getData();
    act_pow <- as.numeric(data_set$Global_active_power);
    voltage <- as.numeric(data_set$Voltage);
    rea_pow <- as.numeric(data_set$Global_reactive_power);
    sub1 <- as.numeric(data_set$Sub_metering_1);
    sub2 <- as.numeric(data_set$Sub_metering_2);
    sub3 <- as.numeric(data_set$Sub_metering_3);	
    n <- length(data_set);
    datewnames <- paste(data_set$Date, " ", data_set$Time, sep = "");
    datetime <- strptime(datewnames, "%d/%m/%Y %H:%M:%S");
    
    par(mfrow= c(2,2));
    
    # Plot (1,1)
    plot(datetime, act_pow, type="l", xlab="", ylab="Global Active Power", main="");
    
    # Plot (1,2)
    plot(datetime, voltage, type="l", xlab="datetime", ylab="voltage", main="");
    
    # Plot (2,1)
    g <- gl(3, n, labels= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
    plot(datetime,sub1, type="n", xlab="", ylab="Energy Sub Metering", main="");
    
    with(data_set, points(datetime[g=="Sub_metering_1"], sub1[g=="Sub_metering_1"], type="l", col="black"));
    with(data_set, points(datetime[g=="Sub_metering_2"], sub2[g=="Sub_metering_2"], type="l", col="red"));
    with(data_set, points(datetime[g=="Sub_metering_3"], sub3[g=="Sub_metering_3"], type="l", col="blue"));
    
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, seg.len=2, col=c("black", "red", "blue"), cex=0.5, bty = 'n');
    
    # Plot (2,2)
    plot(datetime, rea_pow, type="l", xlab="datetime", ylab="Global_reactive_power", main="");
    
    dev.copy(png, file="plot4.png");
    dev.off();
    
}