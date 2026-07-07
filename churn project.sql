-- Which contract type had the highest churn?
SELECT gender , contract,count(churn) as no_churned
 FROM hii.customerchurn
  where churn = 'yes'
 group by gender,contract;
