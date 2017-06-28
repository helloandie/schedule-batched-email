global class sendMonthlyCustomerSatisfactionSurvey implements Schedulable {
	global void execute(SchedulableContext sc) {
		//Sends the Customer Satisfation Survey to active client admins for 
		//clients scheduled this month. This is scheduled to go out on the
		//first Monday of each month at around 10AM.
        sendSatisfactionSurvey csat = new sendSatisfactionSurvey();
        Id batchId = Database.executeBatch(csat,10);
	}
}