Course Project - Getting and Cleaning Data

The goal of this project is to prepare tidy data that can be used for later analysis. To do that a dataset representing data collected from the accelerometers from the Samsung Galaxy S smartphone was used. This project contains an R file, named `run_analysis.r`, to do the following tasks:

1. Download the dataset from UCI Machine Learning Repository;
2. Get and clean features names from file features.txt to prepare train and test datasets;
3. Load, clean and prepare train dataset to bind test dataset;
4. Load, clean and prepare test dataset to bind train dataset;
5. Put both datasets, train and test, together into only one repository;
6. Get and clean activities label from file activity_labels.txt;
7. Replace activities codes by activities labels to become activity variable more descriptive;
8. Group all data by activity and subject then summarise others columns calculate their means;
9. Write summarized data into text tidy file, named `tidy_repository.txt`.
