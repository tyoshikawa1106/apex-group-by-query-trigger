trigger CategoryInfoTrigger on CategoryInfo__c (before insert) {

    CategoryInfoTriggerHandler handler = new CategoryInfoTriggerHandler();

    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            // カテゴリNoのセット
            handler.doSetCategoryNo(Trigger.new);
        }
    }
}