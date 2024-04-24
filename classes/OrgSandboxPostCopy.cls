//
// Script that is run after a sandbox is refreshed.  This is where additional configuration can be performed. 
// Author: Brian.Armstrong
//
global class OrgSandboxPostCopy implements SandboxPostCopy {

    global void runApexClass(SandboxContext context) {

        System.debug('OrgSandboxPostCopy.runApexClass - Org Id: ' + context.organizationId() +
                     '  Sandbox Id: ' + context.sandboxId() + '  Sandbox Name: ' + context.sandboxName());

        // Insert logic below to prepare the sandbox for use.

        try {
            System.debug('Clean up the queue email addresses.  Append the sandbox name to the end of the email address.');

            // Clean up the queue email addresses.  Append the sandbox name to the end of the email address. 
            Group[] groups = [SELECT Id, Type, Name, Email FROM Group WHERE Type = 'Queue' AND Email != ''];
            for (Group grp : groups ) {
                System.debug('group Id: ' + grp.Id + ', Name: ' + grp.Name + ', Old Email: ' + grp.Email);
                grp.Email = grp.Email + '.' + context.sandboxName();
                System.debug('group Id: ' + grp.Id + ', Name: ' + grp.Name + ', New Email: ' + grp.Email);
            }
            Update(groups);
        }
        catch(Exception e){
            System.debug('Failed to clean up queue email addresses.  ' + e);
        }

    }

}