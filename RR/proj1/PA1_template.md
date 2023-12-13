---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
date: "2023-12-12"
---



#### *Loading and Preprocessing the data*\
Show any code that is needed to

1. Load the data (i.e. `read.csv()`)


```r
act <- read.csv('activity.csv')
head(act)
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

2. Process/transform the data (if necessary) into a format suitable for your analysis


```r
str(act)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ steps   : int  NA NA NA NA NA NA NA NA NA NA ...
##  $ date    : chr  "2012-10-01" "2012-10-01" "2012-10-01" "2012-10-01" ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```


```r
act$date <- as.Date(act$date, format = '%Y-%m-%d')
```


```r
summary(act)
```

```
##      steps             date               interval     
##  Min.   :  0.00   Min.   :2012-10-01   Min.   :   0.0  
##  1st Qu.:  0.00   1st Qu.:2012-10-16   1st Qu.: 588.8  
##  Median :  0.00   Median :2012-10-31   Median :1177.5  
##  Mean   : 37.38   Mean   :2012-10-31   Mean   :1177.5  
##  3rd Qu.: 12.00   3rd Qu.:2012-11-15   3rd Qu.:1766.2  
##  Max.   :806.00   Max.   :2012-11-30   Max.   :2355.0  
##  NA's   :2304
```

#### *What is mean total number of steps taken per day?*

For this part of the assignment, you can ignore the missing values in the dataset.

1. Calculate the total number of steps taken per day


```r
steps_by_day <- act |>
  group_by(date) |>
  summarise(steps_per_day = sum(steps))

steps_by_day
```

```
## # A tibble: 61 × 2
##    date       steps_per_day
##    <date>             <int>
##  1 2012-10-01            NA
##  2 2012-10-02           126
##  3 2012-10-03         11352
##  4 2012-10-04         12116
##  5 2012-10-05         13294
##  6 2012-10-06         15420
##  7 2012-10-07         11015
##  8 2012-10-08            NA
##  9 2012-10-09         12811
## 10 2012-10-10          9900
## # ℹ 51 more rows
```

2. Make a histogram of the total number of steps taken each day


```r
hist(steps_by_day$steps_per_day,
     breaks = 20,
     main = 'Total Number of Steps Taken',
     xlab = 'Step')
```

![](PA1_template_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

3. Calculate and report the mean and median of the total number of steps taken per day


```r
mean(steps_by_day$steps_per_day, na.rm = TRUE)
```

```
## [1] 10766.19
```

```r
median(steps_by_day$steps_per_day, na.rm = TRUE)
```

```
## [1] 10765
```

#### *What is the average daily activity pattern?*

1. Make a time series plot (i.e. `type = "l"`) of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)


```r
avgsteps <- aggregate(steps ~ interval, data = act, mean, na.rm = TRUE)

#avgsteps

plot(avgsteps$interval, avgsteps$steps,
     type = 'l',
     main = 'Average Number of Steps Taken',
     xlab = 'Interval',
     ylab = 'Step')
```

![](PA1_template_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?


```r
avgsteps$interval[which.max(avgsteps$steps)]
```

```
## [1] 835
```

#### *Imputing missing values*

Note that there are a number of days/intervals where there are missing values (coded as `NA`). The presence of missing days may introduce bias into some calculations or summaries of the data.

1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with `NA`s)


```r
sum(is.na(act))
```

```
## [1] 2304
```

2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.

3. Create a new dataset that is equal to the original dataset but with the missing data filled in.


```r
filled_act <- act |>
  left_join(avgsteps, by = 'interval') |>
  mutate(steps = ifelse(is.na(act$steps), avgsteps$steps, act$steps)) |>
  select(date, steps, interval)

head(filled_act)
```

```
##         date     steps interval
## 1 2012-10-01 1.7169811        0
## 2 2012-10-01 0.3396226        5
## 3 2012-10-01 0.1320755       10
## 4 2012-10-01 0.1509434       15
## 5 2012-10-01 0.0754717       20
## 6 2012-10-01 2.0943396       25
```


```r
str(filled_act)
```

```
## 'data.frame':	17568 obs. of  3 variables:
##  $ date    : Date, format: "2012-10-01" "2012-10-01" ...
##  $ steps   : num  1.717 0.3396 0.1321 0.1509 0.0755 ...
##  $ interval: int  0 5 10 15 20 25 30 35 40 45 ...
```


```r
summary(filled_act)
```

```
##       date                steps           interval     
##  Min.   :2012-10-01   Min.   :  0.00   Min.   :   0.0  
##  1st Qu.:2012-10-16   1st Qu.:  0.00   1st Qu.: 588.8  
##  Median :2012-10-31   Median :  0.00   Median :1177.5  
##  Mean   :2012-10-31   Mean   : 37.38   Mean   :1177.5  
##  3rd Qu.:2012-11-15   3rd Qu.: 27.00   3rd Qu.:1766.2  
##  Max.   :2012-11-30   Max.   :806.00   Max.   :2355.0
```

4. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates of the total daily number of steps?


```r
filled_steps_by_day <- filled_act |>
  group_by(date) |>
  summarise(steps_per_day = sum(steps))

hist(filled_steps_by_day$steps_per_day,
     breaks = 20,
     main = 'Total Number of Steps Taken',
     xlab = 'Step')
```

![](PA1_template_files/figure-html/unnamed-chunk-15-1.png)<!-- -->


```r
mean(filled_steps_by_day$steps_per_day)
```

```
## [1] 10766.19
```


```r
median(filled_steps_by_day$steps_per_day)
```

```
## [1] 10766.19
```

#### *Are there differences in activity patterns between weekdays and weekends?*

For this part the `weekdays()` function may be of some help here. Use the dataset with the filled-in missing values for this part.

1. Create a new factor variable in the dataset with two levels – “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.


```r
filled_act <- filled_act |>
  mutate(day = ifelse(weekdays(date) %in% c('Saturday', 'Sunday'), 'weekend', 'weekday'))

#filled_act
```

2. Make a panel plot containing a time series plot (i.e. `type = "l"`) of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all weekday days or weekend days (y-axis). See the README file in the GitHub repository to see an example of what this plot should look like using simulated data.


```r
filled_avgsteps <- filled_act |>
  group_by(interval, day) |>
  summarise(steps = mean(steps))
```

```
## `summarise()` has grouped output by 'interval'. You can override using the
## `.groups` argument.
```

```r
#filled_avgsteps
```


```r
ggplot(filled_avgsteps, aes(x = interval, y = steps, color = day)) +
  geom_line() +
  facet_grid(day~.)
```

![](PA1_template_files/figure-html/unnamed-chunk-20-1.png)<!-- -->






