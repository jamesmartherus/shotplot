# `shotplot`: Easily Plot NHL Shot Location Data <img src="man/figures/logo.png" align="right" width=120 />

`shotplot` contains functions to help easily visualize NHL shot location data. `geom_shotplot` wraps `geom_point` and includes a standard NHL rink as a background image. `scrape_shots` uses the NHL API to get coordinates, shot type, shooting player, and shooting player's team from a given range of seasons.

## Installation

To install the latest version of `shotplot`, use the `install_github` function from the `devtools` package:

```
library(devtools)
install_github("jamesmartherus/shotplot")
```

## Requirements

- `geom_shotplot` requires the `png`  and `grid` packages.
- `scrape_shots` requires the `jsonlite` and `curl` packages.

## `geom_shotplot()`

`geom_shotplot()` can be used like any other ggplot geom. It takes x and y shot coordinates and plots them on an image of an NHL rink. 

### Usage

geom_shotplot()

### Example

ggplot(data, aes(x = x_coords, y = y_coords)) +
  geom_shotplot


## `scrape_shots()`

`scrape_shots()` uses the NHL API to access shot location data, including x and y coordinates, shooting player's name, and shooting player's team. `scrape_shots` takes two arguments - `start_season` and `end_season`. Both arguments are integers and set the range of shots to be scraped.

The scraping process can be lengthy, so I recommend scraping one season at a time. The function includes a progress bar. I tend to use the `beepr` [package](https://cran.r-project.org/web/packages/beepr/index.html) to alert me when the process is complete. 

### Usage

`scrape_shots(start_season=2014, end_season=2019)`

### Example

`shot_data <- scrape_shots(start_season=2015, end_season=2016)`










