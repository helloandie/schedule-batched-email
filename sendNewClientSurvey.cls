global class sendNewClientSurvey implements Database.Batchable<sObject> {
    // Set template to use - TEMPORARILY SET TO CSAT PENDING MARKETING FINISHING SURVEY!!!!!
    EmailTemplate emailTemp = [SELECT Id FROM EmailTemplate WHERE Name = 'New Client 2' limit 1];
    String templateId = emailTemp.Id;
    //Set reply to address
    String replyTo = 'jdavis@nextep.com';
    //Set display name
    String displayName = 'Nextep, Inc.';
    //String to hold contact query
    String con = 'SELECT Id ' +
            'FROM Contact ' +
            'WHERE HasOptedOutOfEmail = FALSE ' +
            'AND Email != null ' +
            'AND (EmploymentStatus__c = \'Active\' OR (Client_Employee__c = \'\' AND EmploymentStatus__c = \'\')) ' +
            'AND (ClientAdministrator__c = TRUE OR Benefits__c = TRUE OR HR__c = TRUE  ' +
            'OR Key_Executive__c = TRUE OR Payroll__c = TRUE OR Owner__c = TRUE OR Risk__c = True) ' +
            'AND Account.Status__c = \'Client\' ' +
            'AND Account.Date_of_1st_Payroll__c = LAST_MONTH ' +
            'AND Account.FirstPayrollComplete__c = TRUE ';

    global Database.QueryLocator start(Database.BatchableContext bc) {
        //Return the contact query
        return Database.getQueryLocator(con);
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) { 
        // Create list of emails
        transient List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
        //Reserve some email slots
        Messaging.reserveSingleEmailCapacity(scope.size());
        //New single email message
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //Get an instance of the emailHelper so we can use it later
        emailHelper eHelper = new emailHelper();
        //Use emailHelper to create an email for each contact in the list, add them to the list of single email 
        //messages
        for(sObject c : scope){
            mail = eHelper.createEmailFromTemplate(templateId, c.Id, replyTo, displayName);
            allMails.add(mail);
        }
        // Try sending emails
        try {
            Messaging.SendEmail(allMails, false);
        } catch(Exception e) {
            System.debug(e.getMessage());
        }
    }

    global void finish(Database.BatchableContext bc) {
    }
}