---
title: "Reproducible Research Peer Assessment 1"
author: Bazza
output: 
html_document: 
keep_md: true
---

  
### Loading and preprocessing the data
Assume the data have been downloaded and unzipped into the current working directory.  
The dataset was sourced from the web:
[Data Set](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip)  
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
Plot code and plot:

```r
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
  
There are a number of ways to adjust for missing values (NA). One easy and not obviously silly approach is to replace the NAs with the mean value for that interval across days where numbers are reported.
  
### Are there differences in activity patterns between weekdays and weekends?
TBD
