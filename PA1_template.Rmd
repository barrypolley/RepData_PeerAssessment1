---
title: "Reproducible Research: Peer Assessment 1"
output: 
html_document: 
keep_md: true
---


## Loading and preprocessing the data
Assume the data have been downloaded into the current working directory.  
The dataset source was:
https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip  
The dataset was downloaded on 8 December 2014.  
'''{r, echo=TRUE}
inputData <- read.csv("activity.csv")
inputData$interval <- as.factor(inputData$interval)
inputData$date <- as.Date(inputData$date, format="%Y-%m-%d")
head(inputData)
'''


## What is mean total number of steps taken per day?
'''{r, echo=TRUE}
dailySteps <- aggregate(steps ~ date, sum, data=inputData, na.rm=TRUE)
hist(dailySteps$steps, breaks = 12, xlab = "Daily # of steps", ylab = "Frequency (# of days)", main = "Frequency - numbers of steps per day")
theMean <- round(mean(dailyTotals$steps, na.rm=TRUE))
theMedian <- round(median(dailyTotals$steps, na.rm=TRUE))
'''

## What is the average daily activity pattern?
Plot:
'''{r, echo=TRUE}
intervalSteps <- aggregate(steps ~ interval, mean, data=inputData, na.rm=TRUE)
par(pch=21, col="black")
plot(intervalSteps$interval, intervalSteps$steps, xlab = "Interval (time)", ylab = "Number of steps", main = "Average number of steps by interval", type = "n")
lines(intervalSteps$interval, intervalSteps$steps, type = "l")
'''
Time for max steps:
'''{r, echo=TRUE}
mostSteps <- subset(intervalSteps, steps==max(steps))
mostStepsTime <- mostSteps[1]$interval
'''



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?

