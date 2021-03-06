#STATS 506 Group Project
#Parametric and Non-parametric ANOVA analysis in R
#Matthew Farr

#One Way ANOVA

#Read in the dataset
diet.R = read.csv("./diet.csv", header = TRUE)

#Check for and omit and NA values in the data
diet.R[!complete.cases(diet.R),]
diet.R = na.omit(diet.R)

#Tell R that Diet and gender are factors
diet.R$Diet = as.factor(diet.R$Diet)
diet.R$gender = factor(diet.R$gender,c(0,1))

#Create the variable weightlost
diet.R$weightlost = diet.R$pre.weight - diet.R$weight6weeks

#Check and see if dataset looks like you want it to
head(diet.R)
summary(diet.R)

#Split the data into two subsets by gender
Diet.female = subset(diet.R, gender==0)
Diet.male = subset(diet.R, gender==1)

#Making sure the data split correctly
head(Diet.female)

#Create One-way ANOVA model and Analyze for Females
anovaFemale = aov(weightlost~Diet, data = Diet.female)
summary(anovaFemale)

#Create One-way ANOVA model and Analyze for Males
anovaMale = aov(weightlost~Diet, data = Diet.male)
summary(anovaMale)

#See which Diet group is significantly different from the others
TukeyHSD(anovaFemale)
TukeyHSD(anovaMale)

#Plot the models
library(gplots)
plotmeans(weightlost~Diet, data = Diet.female)
plotmeans(weightlost~Diet, data = Diet.male)

#Nonparametric Analysis of the datasets
kruskal.test(weightlost~Diet, data = Diet.female)
kruskal.test(weightlost~Diet, data = Diet.male)


#Two-way ANOVA

#Create Two-way ANOVA model and analyze
anova2 = aov(weightlost~gender*Diet,data=diet.R)
Anova(anova2,type = "III")
