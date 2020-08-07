The above R script run_analysis.R downloads Samsung phone data and cleans the data. 

The cleaning process includes creating a single dataframe from the various .txt files, extracting relevant columns of the data based on mean and standard deviation.
The dataframe is then processed to have meaningful labels and column titles for easy readability. 
The dataframe is then further summarized by grouping the people and their activities by getting the mean for each variable of the remaining columns. 

FinalData.txt has the resulting data from the above transformations. CodeBook.md has a more in depth description of the variables and methods used in the run_analysis stript to get the final dataframe.
