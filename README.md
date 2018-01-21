# Loan Prediction Challenge AnalyticVidhya

Competition URL - [AnalyticsVidhya](https://datahack.analyticsvidhya.com/contest/practice-problem-loan-prediction-iii/)

Loan prediction using Logistic regression machine learing algorithm to predict loan status.
@ aks.singh26@gmail.com  asingh07@syr.edu

# Data

### Column Metadata

| Column | Description |
| ------ | ------ |
| Loan_ID | Unique Loan ID |
| Gender | Male/ Female |
| Married | Applicant married (Y/N) |
| Dependents | Number of dependents |
| Education | Applicant Education (Graduate/ Under Graduate) |
| Self_Employed | Self employed (Y/N) |
| ApplicantIncome | Applicant income |
| CoapplicantIncome | Coapplicant income |
| LoanAmount | Loan amount in thousands |
| Loan_Amount_Term | Term of loan in months |
| Credit_History | credit history meets guidelines |
| Property_Area | Urban/ Semi Urban/ Rural |
| Loan_Status | Loan approved (Y/N) |

There are 2 datasets:
1. Train dataset: 13 features(columns) and 614 observations(rows)
2. Test dataset: 12 features(columns) excluding Loan_status column and 367 observations(rows)

# Data Munging

Summary of Train dataset

   ```sh
summary(train)
```
```
Loan_ID       Gender    Married    Dependents        Education   Self_Employed 
LP001002:  1   Female:112   No  :213   0   :345   Graduate    :480   No  :500      
LP001003:  1   Male  :489   Yes :398   1   :102   Not Graduate:134   Yes : 82      
LP001005:  1   NA's  : 13   NA's:  3   2   :101                      NA's: 32      
LP001006:  1                           3+  : 51                                    
LP001008:  1                           NA's: 15                                    
LP001011:  1                                                                      
(Other) :608    

ApplicantIncome CoapplicantIncome   LoanAmount   
Min.   :  150   Min.   :    0     Min.   :  9.0  
1st Qu.: 2878   1st Qu.:    0     1st Qu.:100.0  
Median : 3812   Median : 1188     Median :128.0  
Mean   : 5403   Mean   : 1621     Mean   :146.4
3rd Qu.: 5795   3rd Qu.: 2297     3rd Qu.:168.0  
Max.   :81000   Max.   :41667     Max.   :700.0  
                                  NA's   :22     
   
Loan_Amount_Term Credit_History     Property_Area Loan_Status 
Min.   : 12      Min.   :0.0000   Rural    :179   N:192      
1st Qu.:360      1st Qu.:1.0000   Semiurban:233   Y:422      
Median :360      Median :1.0000   Urban    :202              
Mean   :342      Mean   :0.8422                              
3rd Qu.:360      3rd Qu.:1.0000                              
Max.   :480      Max.   :1.0000                              
NA's   :14       NA's   :50   
 ```  
## Missing values
- Categorical Values: Replace with the highest frequency of value
- Dependents variable: Replace 3+ with 4
- LoanAmount: Replace with Mean of LoanAmount
- Loan_Amount_Term: Replace with the highest frequency of value
- Credit_History: Replace w.r.t Loan_Status, when Loan_Status ->1, Credit_History ->1 and vice-versa
 ### Replace categorical value with 1 and 0 for modelling
 eg: ```contrasts(train$Gender)```
 ## Loan Prediction
 #### by Akansha Singh
 @ aks.singh26@gmail.com asingh07@syr.edu