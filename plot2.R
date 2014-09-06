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

plot2 <- function() {
	data_set <- getData();
	y <- as.numeric(data_set$Global_active_power);
    datewnames <- paste(data_set$Date, " ", data_set$Time, sep = "");
    datetime <- strptime(datewnames, "%d/%m/%Y %H:%M:%S");
	
	with(data_set, plot(datetime,y, type="l", xlab="", ylab="Global Active Power(kilowatts)"));
	
	png(filename = "plot2.png", width = 480, height = 480);
	dev.off();
	
}