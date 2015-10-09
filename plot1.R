library(lubridate)
library(dplyr)


# This function assumes that the 'household_power_consumption.txt' file is
# available in the current working directory
plot1 <- function() {
    dt <- read.csv2('household_power_consumption.txt', dec='.', na.strings='?',
                    stringsAsFactors=FALSE)
    start <- ymd('2007-02-01')
    end <- ymd('2007-02-03')
    dt <- dt %>%
        mutate(DateTime=dmy_hms(paste(Date, Time))) %>%
        select(DateTime, Global_active_power:Sub_metering_3) %>%
        filter(DateTime >= start, DateTime < end)

    png(filename='plot1.png', width=480, height=480, units='px')
    with(dt, hist(dt$Global_active_power, col='red',
                  xlab='Global Active Power (kilowatts)',
                  main='Global Active Power'))
    dev.off()
}
