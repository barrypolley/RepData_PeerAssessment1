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
inputData <- read.csv("activity.csv")
inputData$interval <- as.factor(inputData$interval)
inputData$date <- as.Date(inputData$date, format="%Y-%m-%d")



## What is mean total number of steps taken per day?
dailySteps <- aggregate(steps ~ date, sum, data=inputData, na.rm=TRUE)

hist(dailySteps$steps, breaks = 12, xlab = "Daily # of steps", ylab = "Frequency (# of days)", main = "Frequency - numbers of steps per day")

theMean <- round(mean(dailyTotals$steps, na.rm=TRUE))
theMedian <- round(median(dailyTotals$steps, na.rm=TRUE))


## What is the average daily activity pattern?
intervalSteps <- aggregate(steps ~ interval, mean, data=inputData, na.rm=TRUE)

par(pch=21, col="black")
plot(intervalSteps$interval, intervalSteps$steps, xlab = "Interval (time)", ylab = "Number of steps", main = "Average number of steps by interval", type = "n")
lines(intervalSteps$interval, intervalSteps$steps, type = "l")




## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?

