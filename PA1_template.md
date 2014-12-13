---
title: "Reproducible Research: Peer Assessment 1"
author: Bazza
output: 
html_document: 
keep_md: true
---

  
## Loading and preprocessing the data
Assume the data have been downloaded into the current working directory.  
The dataset source was:
[link](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip)  
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

  
## What is mean total number of steps taken per day?


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

```r
theMean
```

```
## [1] 10766
```
The median number of steps taken per day is:

```r
theMedian
```

```
## [1] 10765
```
  
## What is the average daily activity pattern?
Plot:

```r
intervalSteps <- aggregate(steps ~ interval, mean, data=inputData, na.rm=TRUE)
par(pch=21, col="black")
plot(intervalSteps$interval, intervalSteps$steps, xlab = "Interval (time)", ylab = "Number of steps", main = "Average number of steps by interval", type = "n")
lines(intervalSteps$interval, intervalSteps$steps, type = "l")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 
Time for max steps:

```r
mostSteps <- subset(intervalSteps, steps==max(steps))
mostStepsTime <- mostSteps[1]$interval
```


  
## Imputing missing values


  
## Are there differences in activity patterns between weekdays and weekends?

