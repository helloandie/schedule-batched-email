@isTest
private class sendMonthlyTest {
	
	@isTest static void testMonthlyCSAT() {
		sendMonthlyCustomerSatisfactionSurvey a = new sendMonthlyCustomerSatisfactionSurvey();

		Test.startTest();
		String sch = '0 0 10 * * ?'; 
		System.Schedule('Test Email', sch, a);
		Test.stopTest();
	}
	
	//@isTest static void testMonthlyNC() {
	//	sendMonthlyNewClientSurvey b = new sendMonthlyNewClientSurvey();

	//	Test.startTest();
	//	String sch = '0 0 10 * * ?'; 
	//	System.Schedule('Test Email', sch, b);
	//	Test.stopTest();
	//}
	
}