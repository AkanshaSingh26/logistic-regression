# Read the train and test csv file
read_data <- read.csv("train_u6lujuX_CVtuZ9i.csv", na.strings=c("","NA"))
read_data_test <- read.csv("test_Y3wMUE5_7gLdaTN.csv", na.strings=c("","NA"))
str(read_data)
# save the data in train and test variable
train <- read_data
test <- read_data_test
summary(test)
summary(train)

# Cleanind the train & data set. Replacing NA's with the relevant value

# Train Dataset - replacing 3+ with 4 in Dependents column
train$Dependents <- as.character(train$Dependents)
train$Dependents[train$Dependents == "3+"] <- "4"
as.numeric(train$Dependents)
train$Dependents[which(is.na(train$Dependents))] <- 0


# Test Dataset - replacing 3+ with 4
test$Dependents <- as.character(test$Dependents)
test$Dependents[test$Dependents == "3+"] <- "4"
as.numeric(test$Dependents)
test$Dependents[which(is.na(test$Dependents))] <- 0

# Train Dataset - replacing NA with Male/Female in Gender column as per the below condition and frequency of the value
with(train, Gender[Married == "Yes" & CoapplicantIncome != 0])
train[is.na(train$Gender) & train$Married == "Yes" & train$CoapplicantIncome != 0,]$Gender <- "Male"

with(train, Gender[Married == "Yes" & CoapplicantIncome == 0])
train[is.na(train$Gender) & train$Married == "Yes" & train$CoapplicantIncome == 0,]$Gender <- "Female"
#
with(train, Gender[Married == "No" & CoapplicantIncome != 0])
train[is.na(train$Gender) & train$Married == "No" & train$CoapplicantIncome != 0,]$Gender <- "Male"

with(train, Gender[Married == "No" & CoapplicantIncome == 0])
train[is.na(train$Gender) & train$Married == "No" & train$CoapplicantIncome == 0,]$Gender <- "Female"
train[is.na(train$Gender),]

# Train Dataset - replace NA with Yes/No in Married column as per the frequency of value
train[is.na(train$Married) & train$CoapplicantIncome=="0",]$Married <- "No"
train[is.na(train$Married),]$Married <- "Yes"

# Train Dataset - replace NA with Yes/No in Self_Employed column as per the frequecy of value
train[is.na(train$Self_Employed) & train$Education=="Not Graduate",]$Self_Employed <- "Yes"
train[is.na(train$Self_Employed),]$Self_Employed <- "No"

# Train Dataset - replacing NA with mean value of loan amount 
meanValueLoanAmount <- mean(train$LoanAmount, trim = 0, na.rm = TRUE)
train$LoanAmount[which(is.na(train$LoanAmount))] <- round(meanValueLoanAmount, digits = 1)

# Train Dataset - replacing NA with frequency of value in loan amount term
train$Loan_Amount_Term[which(is.na(train$Loan_Amount_Term))] <- 360

# Train Dataset - replacing NA with 1 & 0 in credit history based on loan status
train[is.na(train$Credit_History) & train$Loan_Status=="Y",]$Credit_History <- 1
train[is.na(train$Credit_History) & train$Loan_Status=="N",]$Credit_History <- 0
 #---------------------------------------------------------------------------------------

# Train Dataset - Replacing categorical value with 1 and 0

# Train Dataset - Female -> 0 and Male -> 1
contrasts(train$Gender)

# Train Dataset - No -> 0 and Yes -> 1
contrasts(train$Married)

# Train Dataset - Graduate -> 0 and Not Graduate -> 1
contrasts(train$Education)

# Train Dataset - No -> 0 and Yes -> 1
contrasts(train$Self_Employed)

# Train Dataset - when Rural -> 1, Semiurban & Urban -> 0, when Semiurban -> 1, Rural & Urban -> 0, when Urban -> 1, Rural & Semiurban -> 0
contrasts(train$Property_Area)

# Train Dataset - No -> 0, Yes -> 1
contrasts(train$Loan_Status)

# Train Dataset - Adding ApplicantIncome and CoapplicantIncome as a new Income column
new_train <- data.frame(transform(train,income = train$ApplicantIncome + train$CoapplicantIncome))

# Train Dataset - Removing Loan_ID, ApplicantIncome & CoapplicantIncome columns from new_train dataframe
new_train <- new_train[,-c(1,7,8)]

# Train Dataset - Rearranging column in new_train dataframe
new_train <- new_train[,c(1,2,3,4,5,11,6,7,8,9,10)]
# ----------------------------- Data Munging of train set completed -------------------------------------------------


#---------------------------------------Cleaning test data applying ------------------------------------------------

# Test Dataset - Replacing NA with Male/Female in Gender column based on below condition and frequency of values
with(test, Gender[Married == "Yes" & CoapplicantIncome != 0])
test[is.na(test$Gender) & test$Married == "Yes" & test$CoapplicantIncome != 0,]$Gender <- "Male"

with(test, Gender[Married == "Yes" & CoapplicantIncome == 0])
test[is.na(test$Gender) & test$Married == "Yes" & test$CoapplicantIncome == 0,]$Gender <- "Female"
#
with(test, Gender[Married == "No" & CoapplicantIncome != 0])
test[is.na(test$Gender) & test$Married == "No" & test$CoapplicantIncome != 0,]$Gender <- "Male"

with(test, Gender[Married == "No" & CoapplicantIncome == 0])
test[is.na(test$Gender) & test$Married == "No" & test$CoapplicantIncome == 0,]$Gender <- "Female"

# Test Dataset - check if there is any NA value in Gender column
test[is.na(test$Gender),]

# Test Dataset -Replace NA with Yes/No in Self_Employed column based on frequency of values
test[is.na(test$Self_Employed) & test$Education=="Not Graduate",]$Self_Employed <- "Yes"
test[is.na(test$Self_Employed),]$Self_Employed <- "No"

# Test Dataset - replacing NA with mean of loan amount column
meanValueLoanAmount <- mean(test$LoanAmount, trim = 0, na.rm = TRUE)
test$LoanAmount[which(is.na(test$LoanAmount))] <- round(meanValueLoanAmount, digits = 1)

# Test Dataset - replacing NA with 1 & 0 in loan amount term based on frequency of values
test$Loan_Amount_Term[which(is.na(test$Loan_Amount_Term))] <- 360

# Test Dataset -replacing NA with 1 & 0 in credit history based on the below condition
test[is.na(test$Credit_History) & test$Married=="Yes" & test$CoapplicantIncome != 0,]$Credit_History <- 1
test[is.na(test$Credit_History) & test$Married=="Yes" & test$CoapplicantIncome == 0 & test$Dependents != 0,]$Credit_History <- 0
test[is.na(test$Credit_History) & test$Married=="Yes" & test$CoapplicantIncome == 0 & test$Dependents == 0,]$Credit_History <- 1
test[is.na(test$Credit_History) & test$Married=="No" & test$CoapplicantIncome != 0,]$Credit_History <- 1
test[is.na(test$Credit_History) & test$Married=="No" & test$CoapplicantIncome == 0 & test$Dependents != 0,]$Credit_History <- 0
test[is.na(test$Credit_History) & test$Married=="No" & test$CoapplicantIncome == 0 & test$Dependents == 0,]$Credit_History <- 1
test[is.na(test$Credit_History),]$Credit_History

#Test Dataset - replacing categorical value with 1 and 0

#Test Dataset - Female -> 0 and Male -> 1
contrasts(test$Gender)

#Test Dataset - No -> 0 and Yes -> 1
contrasts(test$Married)

#Test Dataset - Graduate -> 0 and Not Graduate -> 1
contrasts(test$Education)

#Test Dataset - No -> 0 and Yes ->1
contrasts(test$Self_Employed)

#Test Dataset - when Rural -> 1, Semiurban & Urban -> 0, when Semiurban -> 1, Rural & Urban -> 0, when Urban -> 1, Rural & Semiurban -> 0
contrasts(test$Property_Area)

#Test Dataset - Adding ApplicantIncome and CoapplicantIncome as a new Income column
new_test <- data.frame(transform(test,income = test$ApplicantIncome + test$CoapplicantIncome))

#Test Dataset - Removing Loan_ID, ApplicantIncome & CoapplicantIncome columns from new_train dataframe
new_test <- new_test[,-c(1,7,8)]

#Test Dataset - Rearranging column in new_train dataframe
new_test <- new_test[,c(1,2,3,4,5,10,6,7,8,9)]

#------------------------------------Data Munging of test dataset completed-----------------------------------------------

#--------------------------------- applying Logistic Regression on new_train dataframe --------------------
# including all variables
model <- glm (Loan_Status ~ ., data = new_train, family = binomial)

# final model - excluding Gender, dependents and self_employed features
model <- glm (Loan_Status ~ .-Gender -Dependents -Self_Employed, data = new_train, family = binomial)
summary(model)
#----------------------------------------------------------------------------------------------------

# predict loan_status of new_test data
predict <- predict(model,new_test, type = 'response')

# convert prediction to Y/N
loan_status_Y_N <- ifelse(predict > .5, "Y", "N")
output <- cbind(new_test,loan_status_Y_N)

write.csv(output, file = "submit.csv")
