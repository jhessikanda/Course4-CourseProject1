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

plot3 <- function() {
	data_set <- getData();
	n <- length(data_set);
	sub1 <- as.numeric(data_set$Sub_metering_1);
	sub2 <- as.numeric(data_set$Sub_metering_2);
	sub3 <- as.numeric(data_set$Sub_metering_3);	
	
	datewnames <- paste(data_set$Date, " ", data_set$Time, sep = "");
	datetime <- strptime(datewnames, "%d/%m/%Y %H:%M:%S");
	
	g <- gl(3, n, labels= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
	
	
	png(filename = "plot3.png", width = 480, height = 480);
    
	with(data_set, plot(datetime,sub1, type="n", xlab="", ylab="Energy Sub Metering", main = ""));
    points(datetime[g=="Sub_metering_1"], sub1[g=="Sub_metering_1"], type="l", col="black");
	points(datetime[g=="Sub_metering_2"], sub2[g=="Sub_metering_2"], type="l", col="red");
	points(datetime[g=="Sub_metering_3"], sub3[g=="Sub_metering_3"], type="l", col="blue");
	legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1, seg.len=2, col=c("black", "red", "blue"));
	
	
    dev.off();
	
}