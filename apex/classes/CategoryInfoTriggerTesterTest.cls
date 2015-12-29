@isTest
private class CategoryInfoTriggerTesterTest {

	private static User testAdminUser = CategoryInfoTriggerTester.getLoginUser();

    /**
     * テスト実行ユーザ取得
     */
    static testMethod void getLoginUserTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            User result = CategoryInfoTriggerTester.getLoginUser();
            System.assertEquals(result.Id, UserInfo.getUserId());
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリ情報
     */
    static testMethod void createCategoryInfoTest() {

        System.runAs(testAdminUser) {
            Test.startTest();

            String category = 'PC';
            
            // Insertなし
            CategoryInfo__c categoryInfo = CategoryInfoTriggerTester.createCategoryInfo(category, false);
            System.assertEquals(String.isEmpty(categoryInfo.Id), true);
            
            // Insertあり
            categoryInfo = CategoryInfoTriggerTester.createCategoryInfo(category, true);
            System.assertEquals(String.isNotEmpty(categoryInfo.Id), true);
            
            Test.stopTest();
        }
    }
}