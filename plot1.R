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

plot1 <- function() {
	data_set <- getData();
	x <- as.numeric(data_set$Global_active_power);
	
	with(data_set, hist(x, freq=TRUE, main = "Global Active Power", xlab="Global Active Power(kilowatts)", ylab="Frequency", col="red"));
		
	png(filename = "plot1.png", width = 480, height = 480);
	dev.off();
	
}