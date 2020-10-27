
# Welcome!

Welcome to the etherpad. This is a collaborative notetaking space.

## Useful Links

- Etherpad: https://etherpad.wikimedia.org/p/ds4biomed-oct20
- ds4biomed materials: https://ds4biomed.tech/
- Slides and papers: http://bit.ly/ds4biomed-gdrive
- Glossary: https://glosario.carpentries.org/

- post workshop code: https://github.com/chendaniely/ds4biomed-oct20

- Learner personas: https://ds4biomed.tech/who-is-this-book-for.html#the-personas

- pre-workshop survey: https://virginiatech.qualtrics.com/jfe/form/SV_engOiEQzu6dmLbL
- post-workshop survey: https://virginiatech.qualtrics.com/jfe/form/SV_02sBEHGrJQeKobX

## Sign-in
## Part 1 - Oct 20

- Lesson materials: https://ds4biomed.tech/
- Slides and papers: http://bit.ly/ds4biomed-gdrive
- Glossary (Jargon): https://glosario.carpentries.org/


### Introduction

People are generally indifferent with their data -- indicates a gap to fill to bridge between wanting to work with data and the actually ability to program 

To best identify what learning strategy is best for you, see which persona you identify with: https://ds4biomed.tech/who-is-this-book-for.html#the-personas

Learning curve involved -- communities are key to success such as R community twitter, software carpentry, etc.

Debugging -- lengthy but important process, remember it's okay to be frustrated. Consult your community resources!

The focus today is that you have a plan for data curation and inspiration for future projects

Knowledge covered today will help make you more literate in general with the analyst who actually handle your data

### Spreadsheets

Units are very important to consider:

putting the unit information in each cell can appear helpful but this will involve having multiple bits of info in one cell -- this means it's harder to perform calculations (ie multiplying Celsius versus Fahrenheit

Alternative ways to solve units problem could be to separate the units into their own column (so for instance making a column labeled "temperature unit" and list either Celsius or Fahrenheit)

Ultimately you only want one bit of info per cell, for instance rather than having blood pressure listed as a whole, seperate into diastolic/systolic

same can be done with things such as last name/first name

separations of info in a cell that has multiple bits can be done after the fact but requires special data cleaning

Avoid using spaces when making labels, rather use underscores "_"

generally it is better to use all lowercase for labels of columns as it avoids the case sensitive problem that may arise

When dealing with multiple data values over time there are different possible solutions:

keeping separate sheets can be useful if you have a focus on different data sets such as for different patients and you don't necessarily want to compare multiple data sets

Limitation is there are calculations required to combine datasets if you want to do analysis between different datasets

Leaving line spaces can be useful as it is visually and computationally easy to separate between datasets

the potentially con to this solution is that it can be tempting to use that empty space to make calculations and dirty up the data

Another solution is to introduce an additional column name that holds the additional info (such as making a column for day) (generally best solution)

the potential limitation to making additional columns is that there is a potential limitation on the number of columns you can have (covid UK example)

also you will have duplicate values which may be a problem for some software

This is the best solution but make sure to list in chronological order so that there is one less step when entering into to data software

Color coding is a possible solution to identifying "bad," "good," or otherwise noteworthy cells but has it's problems

eg coloring cells red that have a blood pressure over 140

This however, can lead to having multiple bits of data per cell 

A better solution than using colors would be to have the flag for an "important value" listed in its own column (eg a column named high_bp)

As a general rule, make your dataset a dataset (in a raw form) NOT as a data visualization -- this makes it easier to distribute and use

There is often an additional column for notes, this may be helpful to add explanations for data values (ie. patient's BP was high because they had just finished a workout)


### Rstudio

click `File --> save as` to save a script or you can click the white piece of paper in the top left

`control + enter` will run selected code or you can click the "run" button

#### Rstudio settings

Tools --> global settings --> uncheck "Restore most recently opened project at startup"

also uncheck "Restore previously open source documents at startup"

also uncheck "Restore .RData into workspace at startup"

then click apply and restart RStudio

this will make it so you open with a clean slate each time

#### RStudio projects

to load a project click the "project (none)" at the top right

### Loading data

`tidyverse` is a collection of packages for R which makes it useful as a first time learning tool for R

comes with packages for reading excel, csv files, and Pivoting datasets, etc.

can even read in excel file with multiple sheets in excel

you can refer to a file based on a relative path (which starts from your present working directory) or the absolute path (which is the total, long, written out path)

To go up a directory, use the shorthand `../` which tells your computer to go up one directory and then continue on

The first start in a project should be creating and saving a new file

when naming your files, list a number at the beginning of each file to make them listed automatically in order

make sure to load in tidyverse package by using :

```r
library(tidyverse)
```

use `tab` to autofill file names (this will help avoid typos)

remember this is all case sensitive so make sure capitals/lowercases are appropriate 

the <- indicates what you want to assign something to

eg `tumor <- read_csv("tumor_data.csv")` will make a dataset that contains that csv data called "tumor"

To read excel files rather than just csv, you need to load it with: library(readxl)

Although spaces don't matter, it is a good idea to put them around operators to help the visibility of the code

clicking on datasets on the right will allow you to check your dataset

#### Selecting columns

use the select command to print out only certain columns:

`select(dataset_name, column_name)`

eg select(tumor, SIze) will print out only the Size column in the tumor dataset

pipe operator (`%>%`) passes a value into the select command

tumor %>% select(Size) would be equivalent to example above

#### Filtering rows

Filter is similar to select but allows us to search for specific values in rows 

`filter(dataset_name, value)`

eg `filter(tumor, Group == 1)` will show us all rows that contain that have their group value set to 1

the pipe command can also be used: `tumor %>% fileter(Group == 3)`

You can also filter by multiple values using and operators :

eg `tumor %>% filter(Group == 3, Day == 0)`

this will give us all rows that have their group values equal to three and day value equal to 0

The & can also be used in place of a comma

You can specifcy or operators using a |

eg `tumor %>% filter(Day == 0 | Day == 13)`

#### Multiple operations

You can perform multiple operations together using pipes to select rows and columns:

```r
tumor %>% 
  select(Group, Day, Size) %>%
  filter(Size > 2000)
```

You can also combine the assignment operator (<-) to keep a filtered and selected dataset

```r
filtered <- tumor %>%
select(Group, ID, Day, Size) %>%
filter(Day == 0 | Day == 13)
```

this makes a whole new dataset named `filtered`

#### Writing out files

We can export our new datasets by using `write_csv()`

eg `write_csv(filtered, "data/tumor_filtered.csv")`

this will export a new file in the `data/` directory called `tumor_filtered.csv`

#### Pipelines

clicking `session --> restart R` (control+shift+F10)

great when starting a new script so that you have a fresh slate

creating a pipeline: take an output from one file and make it the input for another

to run analysis such as mean() use pull() rather than select()

pull() produces a list of values rather than a column like select does, a list of values is necessary for mean() to function

eg:

```r
filtered %>%
    filter(Day == 0) %>%
    pull(Size) %>%
    mean()
```

To make comments in the code, use # (this is important for documentation)

To run calculations on multiple groups, specify that with group_by() and summarize()

group_by specifies to perform something on multiple groups

summarize() creates a new column with a summary statistic assigned

example

```r
filtered %>%
    filter(Day == 0) %>%
    group_by(Group) %>%
    summarize (avg_size = mean(Size),
               min_size = min(Size)
    )
```

This example above makes 2 new columns with summary statistics performed

## Part 2 - Oct 22

## Tidy Data
Tuesday's focus was setting up your own data, today is focuses on the principles from "Tidy Data," a paper by Hadly wickham

Pivoting the table will switch columns versus rows

pivoting can be used to highlight different aspects of data (eg is the focus one variable or the other?)

Tidy data may at first look more complex for an average person reading, but it actually makes data more usable from a computational perspective

Each variable in tidy data forms a column: (eg `ID`, `name`, `color`)

each observation forms a row: (eg row of `ID = 1`, etc)

Once again, each cell should only have one unit of data

Once data is tidy, it is easy to convert into other forms, combine with other datasets, etc

common data problems:

column headers are values, not variable names (ie. income values listed in column headers)

to solve use `pivot_longer()`

```r
tumor_tidy <- tumor %>%
  pivot_longer(`0`:last_col(), names_to = "day", values_to = "size")

      will show us  jst day and values pivoted
```

```r
tumor_tidy %>%
  group_by(Group, day) %>%
  summarize(avg_size = mean(size, na.rm = TRUE))
```

this will create a new column that has the average listed for group and day

making calculations within dataset (like you would do in excel)

make your columns named with characters that aren't numbers, R will have to insert backticks for numbers (`1`)

having multiple variables in one column such as having a column labeled m65 for males who are `65`

to solve this, we first use pivot longer

we can also use the `starts_with()` and concatenate command `c()` which will pull out individual aspects in values such as 

`c('m', 'f')` which will pull out all values that start with `m` or `f`

`tb <- read_csv("data/tb_long.csv")`

```r
tb_long <- tb%>%
  pivot_longer(starts_with(c('m', 'f')))
```

this gets us most of the way there, but we also need to separate these values using the `separate()` command, 

we can specify what columns to separate them into and to what character we chop off

Final product for separating multiple variables in one column: first we pivot longer for things starting with m or f
(using the `c()` command) then we separate those weird values (`m65` or `f14`)
into 2 different ones (sex = m, age = 65, sex = f, age = 14)

```r
tb <- read_csv("data/tb_long.csv")

tb_long <- tb%>%
  pivot_longer(starts_with(c('m', 'f')))

tb_long
```

```r
tb_tidy <- tb_long %>%
  separate(name, into = c("sex", "age_group"), sep = 1)
```

variables stored in rows (eg:
we can use `pivot_wider()` which basically create more columns from values in rows rather than make more rows from values in columns (such as `pivot_longer` does)

### Visualization (ggplot2):

different types of variables:

- nominal: unrealted to one another (such as control group, experiemental group)
- ordinal: inherent ordered relation (-1, 0, 1)
- Binary: 2 mutually exclusive outcomes (yes or no format, true or false, eg was the patient cured or not)

the type of data you store will dictate the type of visualization you can make

Plots are created via layers from bottom to top: 

- Data (values)
- Mapping (x variable and y variable)
- statistics (counting, average, etc)
- scale (such as logarithmics or base 10 etc)
- geometries (this is where we start drawiing, what do you want? bars, boxes?)
- facets, cooridinates (polar or euclidian)
- themes(fonts, style, etc) 

When making box plots, also useful to make a violen plot to accompany it because it can show skews: `geom_violin`

Facets are useful to separate extra variables in scatterplots that may be overcrowded

`theme_THEMENAME` is useful for quickly changing color/style and whatnot

### Fitting a model

logistic regression model: only works if the outcome variable is binary, good for epidemiology/health (did the patient pass/develop disease: yes or no)

Betas: parts of our model

logistic regression models are super helpful for yes/no because linear regression will have a line that goes into negatives

f

## General R tips/comments

Working in R:

working with project from yesterday

once again, click the paper with plus mark --> R script to start a new script file

when saving files, make sure to include numbers in front of names to help organization

pivot longer creates more rows from columns that are values rather than variables (i.e. salary)

pivot_longer("column range start": "column range end", names_to = "new name", values_to = "new_value"

eg 

`pivot_longer(`0`:last_col(), names_to = "day", values_to = "size")`

`c()` stands for concatenate and can separate out different aspects in values

ie. `c('m', 'f')`

this would select only the columns that have m or f in them

using mutate command will allows us to convert data types, for instance

`mutate(day = as.numeric(day))` will convert all values in the day column to a value that we can perform operations on

remember to `session --> restart R` after opening each new file

## Day 2 Conclusions:

There is a huge R community looking to help. "R for DS" is a great free book to learn more

"R for Data Science" Slack community you join to ask questions and find new peers on this journey

Weekly office hours. They have "TAs" that can help find bugs in code

"Tidy Tuesday" hashtag on Twitter. Every tuesday, a dataset is released and participants have 1 hour to complete some goal. Great way to see workflows

David Robin steams a 1 hour analysis on the Tidy Tuesday each week on YouTube

R-Ladies global slack channel for minorities and those that identify as woman

R-Medicine slack channel focused on using R within the medical field

Contact us! (Dan Chen or Anne Brown)

biostat.centers.vt.edu 

has drop in consulting hours on Mondays and Wednesdays

https://lib.vt.edu/research-teaching/data-services.html

Carpentries (Software Carpentries and Data Carpentries) are great sources of learning material on R and Python

Thank you!
