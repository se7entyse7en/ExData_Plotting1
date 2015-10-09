library(lubridate)
library(dplyr)


# This function assumes that the 'household_power_consumption.txt' file is
# available in the current working directory
plot3 <- function() {
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

    png(filename='plot3.png', width=480, height=480, units='px')
    with(dt, {
        plot(DateTime, Sub_metering_1, type='n', xlab='',
             ylab='Energy sub metering')
        lines(DateTime, Sub_metering_1, col='black')
        lines(DateTime, Sub_metering_2, col='red')
        lines(DateTime, Sub_metering_3, col='blue')
        legend(x='topright',
               legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
               lty=rep('solid', 3), col=c('black', 'red', 'blue'))
    })
    dev.off()
}
