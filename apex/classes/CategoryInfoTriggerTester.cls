public with sharing class CategoryInfoTriggerTester {

    /**
     * テスト実行ユーザ取得
     */
    public static User getLoginUser() {
        return new User(Id = UserInfo.getUserId());
    }

    /**
     * カテゴリ情報
     */
    public static CategoryInfo__c createCategoryInfo(String category, Boolean isInsert) {
        
        CategoryInfo__c categoryInfo = new CategoryInfo__c(       
             Category__c = category
            ,CategoryNo__c = null
        );
        
        if (isInsert) {
            insert categoryInfo;
        }
        
        return categoryInfo;
    }
}