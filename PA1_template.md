---
title: "Reproducible Research: Peer Assessment 1"
output: 
html_document: 
keep_md: true
---


## Loading and preprocessing the data
inputData <- read.csv("activity.csv")
inputData$interval <- as.factor(inputData$interval)
inputData$date <- as.Date(inputData$date, format="%Y-%m-%d")



## What is mean total number of steps taken per day?
dailySteps <- aggregate(steps ~ date, sum, data=inputData, na.rm=TRUE)

hist(dailySteps$steps, breaks = 12, xlab = "Total # of steps", ylab = "Frequency (# of days)", main = "Frequency - total numbers of steps per day")

theMean <- round(mean(dailyTotals$steps, na.rm=TRUE))
theMedian <- round(median(dailyTotals$steps, na.rm=TRUE))


## What is the average daily activity pattern?



## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?

