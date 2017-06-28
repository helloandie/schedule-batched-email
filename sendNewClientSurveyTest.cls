@isTest
private class sendNewClientSurveyTest {
	
	@isTest static void testNCSurvey() {
		//Test data
		Account aa = new Account(Name = 'Alpha', Status__c = 'Client', FirstPayrollComplete__c = TRUE,
								Date_of_1st_Payroll__c = Date.today().addMonths(-1));
		insert aa;

		Contact ca = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'One', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE);
		insert ca;
		Contact cb = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'Two', Email = 'test@gmail.com',
								ClientAdministrator__c = FALSE);
		insert cb;
		Contact cc = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'Three',
								ClientAdministrator__c = TRUE);
		insert cc;
		Contact cd = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'Four', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE, HasOptedOutOfEmail = TRUE);
		insert cd;


		Account ab = new Account(Name = 'Beta', Status__c = 'Prospect', FirstPayrollComplete__c = FALSE,
								Date_of_1st_Payroll__c = Date.today().addMonths(-1));
		insert ab;
		Contact ce = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'One', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE);
		insert ce;
		Contact cf = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'Two', Email = 'test@gmail.com',
								ClientAdministrator__c = FALSE);
		insert cf;
		Contact cg = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'Three',
								ClientAdministrator__c = TRUE);
		insert cg;
		Contact ch = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'Four', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE, HasOptedOutOfEmail = TRUE);
		insert ch;
		

		Account ac = new Account(Name = 'Gamma', Status__c = 'Client', FirstPayrollComplete__c = TRUE,
								Date_of_1st_Payroll__c = Date.today());
		insert ac;
		Contact ci = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'One', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE);
		insert ci;
		Contact cj = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'Two', Email = 'test@gmail.com',
								ClientAdministrator__c = FALSE);
		insert cj;
		Contact ck = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'Three',
								ClientAdministrator__c = TRUE);
		insert ck;
		Contact cl = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'Four', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE, HasOptedOutOfEmail = TRUE);
		insert cl;

		//Call sendNewClientSurvey - should also call emailHelper via sendNewClientSurvey
		Test.startTest();
		sendNewClientSurvey a = new sendNewClientSurvey();
		Test.stopTest();

		//TODO Assertions to test that expected number of emails are being sent

	}
	@isTest static void testNCSurveyBatch() {
		//Test data
		Account aa = new Account(Name = 'Alpha', Status__c = 'Client', FirstPayrollComplete__c = TRUE, 
								Date_of_1st_Payroll__c = Date.today().addMonths(-1));
		insert aa;

		Contact ca = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'One', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE);
		insert ca;
		Contact cb = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'Two', Email = 'test@gmail.com',
								ClientAdministrator__c = FALSE);
		insert cb;
		Contact cc = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'Three',
								ClientAdministrator__c = TRUE);
		insert cc;
		Contact cd = new Contact(AccountId = aa.id, FirstName = 'Test', LastName = 'Four', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE, HasOptedOutOfEmail = TRUE);
		insert cd;


		Account ab = new Account(Name = 'Beta', Status__c = 'Prospect', FirstPayrollComplete__c = FALSE, 
								Date_of_1st_Payroll__c = Date.today().addMonths(-1));
		insert ab;
		Contact ce = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'One', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE);
		insert ce;
		Contact cf = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'Two', Email = 'test@gmail.com',
								ClientAdministrator__c = FALSE);
		insert cf;
		Contact cg = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'Three',
								ClientAdministrator__c = TRUE);
		insert cg;
		Contact ch = new Contact(AccountId = ab.id, FirstName = 'Test', LastName = 'Four', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE, HasOptedOutOfEmail = TRUE);
		insert ch;
		

		Account ac = new Account(Name = 'Gamma', Status__c = 'Client', FirstPayrollComplete__c = TRUE, 
								Date_of_1st_Payroll__c = Date.today());
		insert ac;
		Contact ci = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'One', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE);
		insert ci;
		Contact cj = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'Two', Email = 'test@gmail.com',
								ClientAdministrator__c = FALSE);
		insert cj;
		Contact ck = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'Three',
								ClientAdministrator__c = TRUE);
		insert ck;
		Contact cl = new Contact(AccountId = ac.id, FirstName = 'Test', LastName = 'Four', Email = 'test@gmail.com',
								ClientAdministrator__c = TRUE, HasOptedOutOfEmail = TRUE);
		insert cl;

		//Call sendNewClientSurvey - should also call emailHelper via sendNewClientSurvey
		Test.startTest();
		sendNewClientSurvey a = new sendNewClientSurvey();
        ID batchId = Database.executeBatch(a);
		Test.stopTest();

		//TODO Assertions to test that expected number of emails are being sent

	}
}