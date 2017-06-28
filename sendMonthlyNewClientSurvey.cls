global class sendMonthlyNewClientSurvey implements Schedulable {
	global void execute(SchedulableContext sc) {
		//Sends the New Client Survey to active client admins for 
		//clients scheduled this month. This is scheduled to go out on the
		//third Tuesday of each month at around 10AM.
        sendNewClientSurvey ncs = new sendNewClientSurvey();
        Id batchId = Database.executeBatch(ncs,10);
	}
}