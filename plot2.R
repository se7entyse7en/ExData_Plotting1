library(lubridate)
library(dplyr)


# This function assumes that the 'household_power_consumption.txt' file is
# available in the current working directory
plot2 <- function() {
    dt <- read.csv2('household_power_consumption.txt', dec='.', na.strings='?',
                    stringsAsFactors=FALSE)
    start <- ymd('2007-02-01')
    end <- ymd('2007-02-03')
    dt <- dt %>%
        mutate(DateTime=dmy_hms(paste(Date, Time)),
               Weekday=wday(DateTime, label=TRUE)) %>%
        select(DateTime, Weekday, Global_active_power:Sub_metering_3) %>%
        filter(DateTime >= start, DateTime < end,
               Weekday >= 'Thurs', Weekday <= 'Sat')

    png(filename='plot2.png', width=480, height=480, units='px')
    with(dt, {
        plot(DateTime, Global_active_power, type='n', xlab='',
             ylab='Global Active Power (kilowatts)')
        lines(DateTime, Global_active_power)
    })
    dev.off()
}
