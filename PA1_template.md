---
title: "Reproducible Research Peer Assessment 1"
author: Bazza
output: 
html_document: 
keep_md: true
---
  
### Loading and preprocessing the data
Code assumes the data have been downloaded and unzipped into the current working directory.  
The dataset was sourced from the web here:
[Data set used in this analysis](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip)  
The dataset was downloaded on 8 December 2014.  

```r
inputData <- read.csv("activity.csv")
inputData$interval <- as.factor(inputData$interval)
inputData$date <- as.Date(inputData$date, format="%Y-%m-%d")
head(inputData)
```

```
##   steps       date interval
## 1    NA 2012-10-01        0
## 2    NA 2012-10-01        5
## 3    NA 2012-10-01       10
## 4    NA 2012-10-01       15
## 5    NA 2012-10-01       20
## 6    NA 2012-10-01       25
```
  
### What is mean total number of steps taken per day?

```r
dailySteps <- aggregate(steps ~ date, sum, data=inputData, na.rm=TRUE)
hist(dailySteps$steps, breaks = 12, xlab = "Daily # of steps", ylab = "Frequency (# of days)", main = "Frequency - numbers of steps per day")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 

```r
theMean <- round(mean(dailySteps$steps, na.rm=TRUE))
theMedian <- round(median(dailySteps$steps, na.rm=TRUE))
```
The mean number of steps taken per day is:

```
## [1] 10766
```
The median number of steps taken per day is:

```
## [1] 10765
```
  
### What is the average daily activity pattern?
Plot code and plot of average daily activity pattern:

```r
#use base plotting system to draw a line chart
intervalSteps <- aggregate(steps ~ interval, mean, data=inputData, na.rm=TRUE)
par(pch=21, col="black")
plot(intervalSteps$interval, intervalSteps$steps, xlab = "Interval (time)", ylab = "Number of steps", main = "Average number of steps by interval", type = "n")
lines(intervalSteps$interval, intervalSteps$steps, type = "l")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 
   
The highest number of steps occurs during interval 835:

```r
mostSteps <- subset(intervalSteps, steps==max(steps))
mostStepsTime <- mostSteps[1]$interval
mostStepsTime
```

```
## [1] 835
## 288 Levels: 0 5 10 15 20 25 30 35 40 45 50 55 100 105 110 115 120 ... 2355
```
  
### Imputing missing values
There are 2304 missing values among the 17568 observations:

```r
sum(is.na(inputData$steps))
```

```
## [1] 2304
```
  
There are a number of ways to adjust for missing values (NA). Substituting zeroes for all NA is the easiest approach, but unlikely to be a good choice; zero already is a common value in the data set, because people are asleep a good part of the day every day. There's no obvious basis for picking any other single number to substitute for NA. One not plausible approach is to replace the NAs in all intervals with the mean values for those same intervals across days. This does assume a consistent pattern across days of the week, though, which we haven't yet established as a good assumption.
  

```r
# add column of imputed data
adjustedData <- inputData
imputeMean <- function(x) replace(x, is.na(x), mean(x, na.rm = TRUE)) # from stackoverflow 17297897
newCol <- imputeMean(adjustedData$steps)
adjustedData["imputedSteps"] <- newCol

#identical to earlier process, with imputed data
dailyAdjustedSteps <- aggregate(imputedSteps ~ date, sum, data=adjustedData, na.rm=TRUE)
hist(dailyAdjustedSteps$imputedSteps, breaks = 12, xlab = "Daily # of steps", ylab = "Frequency (# of days)", main = "Frequency - adjusted numbers of steps per day")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png) 

```r
theAdjustedMean <- round(mean(dailyAdjustedSteps$imputedSteps, na.rm=TRUE))
theAdjustedMedian <- round(median(dailyAdjustedSteps$imputedSteps, na.rm=TRUE))
```
  
The mean number of steps taken per day (after replacing all NA) is now:

```
## [1] 10766
```
The median number of steps taken per day (after replacing all NA) is now:

```
## [1] 10766
```
  
The difference between these numbers and the prior calculations is negligible, as is the difference between the histograms.
  
### Are there differences in activity patterns between weekdays and weekends?
I used the approach supplied by fellow student Renaud Dufour, in December 2014 class discussion thread #37, to create a new column labelling all observations as either weekday or weekend. Then I plotted the weekday and weekend data separately. A simple visual comparison of the activity plots shows that the answer to this question is **YES**. Apparently this population is composed mainly of sedentary (office?) workers who sleep later and enjoy movement throughout the day on weekends.
  
   

```r
# new column for day type
library(lubridate)
adjustedData[, "dayType"] <- as.Date(NA)
adjustedData$dayType <- factor(ifelse(wday(adjustedData$date) %in% c(1,7), "weekend", "weekday"))
# one DF for weekday, another for weekend
weekdayData <- subset(adjustedData, dayType == "weekday")
weekendData <- subset(adjustedData, dayType == "weekend")
#plot two line graphs using basic plotting system
par(mfrow=c(2,1))
par(pch=21, col="black")
intervalSteps <- aggregate(steps ~ interval, mean, data=weekdayData, na.rm=TRUE)
plot(intervalSteps$interval, intervalSteps$steps, ylim=c(0,250), xlab = "Interval (time)", ylab = "Number of steps", main = "Average number of steps (weekdays)", type = "n")
lines(intervalSteps$interval, intervalSteps$steps, type = "l")
intervalSteps <- aggregate(steps ~ interval, mean, data=weekendData, na.rm=TRUE)
plot(intervalSteps$interval, intervalSteps$steps, ylim=c(0,250), xlab = "Interval (time)", ylab = "Number of steps", main = "Average number of steps (weekends)", type = "n")
lines(intervalSteps$interval, intervalSteps$steps, type = "l")
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 
  
######End document.
