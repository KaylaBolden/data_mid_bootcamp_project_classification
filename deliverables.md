# Project_FIFA_MoneyBall

![photo](https://github.com/KaylaBolden/data_mid_bootcamp_project_classification/blob/master/Screen%20Shot%202021-12-04%20at%205.08.14%20PM.png)

# Objective 
Credit Card Services are a large revenue driver for the bank, however blindly offering to everyone is costly and inefficient. It is necessary to understand what our market looks like and who best to target.. 

So, the goal is to understand the demographics and other characteristics of the bank’s customers that accept a credit card offer and that do not accept a credit card.
Build a model to predict if a customer is likely to accept or reject a credit card offer.
 
 # Used tools 
  Programs: 
  
      1. Jupiter - python
      2. Tableau
      3. Powerpoint
  
  Methods:
  
      1. Logistic Regression
      2. Histograms, distribution plots, heat maps, box-whisker plots, confusion matrix, bar plots
      
  Libraries:
  
      1. Normalizer
      2. StandardScaler
      3. confusion_matrix
      4. cohen_kappa_score
      5. math
      6. statistics 
      7. matplotlib.pyplot
      8. seaborn
      9. statsmodels.api
      10. train_test_split
      11. one hot encoder
      12. numpy
      13. pandas
      14. statsmodels.formula.api
      15. linear_model
      16. is_numeric_dtype
      17. LogisticRegression
      18. roc_auc_score
      19. accuracy_score
      20. PIL
      
 # Workflow
      1. Gather the Data 
      2. Explore the Data 
      3. Clean the Data 
          a. Categorical data: 
            i. needs to be grouped into fewer buckets
            ii. dropped if there are too many instances
            iii. cleaned if there are various values with the same meaning 
          b. Numerical data: 
            i. needs to be converted to number if object (may require functions for data transformations)
      4. Dealing with Nulls 
      5. Dealing with Outliers 
      6. Transform numerical columns to conform to a more normal standard distribution
      7. Check Multicollinearity (but no need to modify since logistic regression isn't impacted by multicollinearity) 
      8. Normalize and or standardize the data 
      9. Check and rectify data imbalance
      10. Apply Train-Test Split 
      11. Train Model 
      12. Test Model

# Transformations
    Tested a variety of methods to convert my continuos variables into normal distributions:
    1. log
    2. square root
    3. square
    4. cubed 
    
    Ultimately the square root was the best transformation on the quarterly variables. While the log transformation was the best for the average balance variable. 

# Scaling and Balancing data

    Tested a variety of scaling methods:
      1. Normalizer
      2. Standard Scaler
      3. Min – Max Scaler

    Tested multiple data balancing methods:
      1. Random Over Sampling
      2. Random Under Sampling
      3. SMOTE
      4. Tomeklinks

    Out of all the methods, standard scaler and Random over Sampling preoduced the highest ROC-AUC and Kappa scores:
![photo](https://github.com/KaylaBolden/data_mid_bootcamp_project_classification/blob/master/table.png)

# Results and conlusions 
      The accuracy of the model on test set is: 0.70 and the Kappa of the model is: 0.41. The ROC-AUC is 77%
![photo](https://github.com/KaylaBolden/data_mid_bootcamp_project_classification/blob/master/Screen%20Shot%202021-12-04%20at%204.51.05%20PM.png)

      
# Improvements
      Remove highly correlated columns and then remove outliers so that fewer rows are filtered out.
      
## Dataset

The dataset provided [**creditcardmarketing.csv**](https://github.com/KaylaBolden/data_mid_bootcamp_project_classification/blob/master/creditcardmarketing.csv) 


This data set includes:

1. **CreditCardMarketing** data:

    |   |   |
    |---|---|
    |  Customer Number | Offer Accepted   |
    | Mailer Type  | Income Level  |
    | Bank Accounts Open  |  Overdraft Protection |
    |  Credit Rating | Credit Cards Held  |
    | Homes Owned|Household Size|
    | Own Your Home|Average Balance|
    | Balance||
    |||


# SQL
The dataset provided [**Classisfication Model.sql**](https://github.com/KaylaBolden/data_mid_bootcamp_project_classification/blob/master/Classisfication%20Model.sql). 

# Tableau
A full analysis with visuals breaking down key drivers and customer demographic profiles can be found in [**Credit Card Offers.twbx**]
(https://github.com/KaylaBolden/data_mid_bootcamp_project_classification/blob/master/Credit%20Card%20Offers.twbx). 

# Presentation
A powerpoint containing the agenda and tying it all together can be found in [**Offer Acceptance Slides.pptx**]
(https://github.com/KaylaBolden/data_mid_bootcamp_project_classification/blob/master/Offer%20Acceptance%20Slides.pptx). 

