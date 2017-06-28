global class sendSatisfactionSurvey implements Database.Batchable<sObject> {
        // Set template to use
        EmailTemplate emailTemp = [SELECT Id FROM EmailTemplate WHERE Name = 'Client Satisfaction - 12.29' limit 1];
        String templateId = emailTemp.Id;
        //Set reply to address
        String replyTo = 'lnichols@nextep.com';
        //Set display name
        String displayName = 'Nextep, Inc.';
        //String to hold contact query
        String con = 'SELECT Id ' +
            'FROM Contact ' +
            'WHERE HasOptedOutOfEmail = FALSE ' +
            'AND Email != null ' +
            'AND (EmploymentStatus__c = \'Active\' OR (Client_Employee__c = \'\' AND EmploymentStatus__c = \'\')) ' +
            'AND (Key_Contact_Roles__c = \'Owner\' OR Key_Contact_Roles__c = \'Key Contact\' OR Access_Level__c = \'Partial Access\' OR Access_Level__c = \'Full Access\') ' +
            'AND Account.Status__c = \'Client\' ' +
            'AND Account.NextCSATSent__c = THIS_MONTH ';

        global Database.QueryLocator start(Database.BatchableContext bc) {
            //Retrun the contact query
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
            // Try sending emails and updating accounts
            try {
                Messaging.SendEmail(allMails, false);
                //update accToUpdate;
            } catch(Exception e) {
                System.debug(e.getMessage());
            }
        }

        global void finish(Database.BatchableContext bc) {
            //Now we need to update the account with the new LastCSATSent__c date of today:

            //Create a list of Accounts to update later
            List<Account> accToUpdate = new List<Account>();
            //Get list of accounts
            List<Account> accList = new List<Account>([
                SELECT Id
                FROM Account
                WHERE Status__c = 'Client'
                AND NextCSATSent__c = THIS_MONTH]);
            //Update the Last CSAT Sent field for each account in accList
            for(Account a: accList) {
                a.LastCSATSent__c = date.today();
                accToUpdate.add(a);
            }
            try {
                //Messaging.SendEmail(allMails, false);
                update accToUpdate;
            } catch(Exception e) {
                System.debug(e.getMessage());
            }
        }
}