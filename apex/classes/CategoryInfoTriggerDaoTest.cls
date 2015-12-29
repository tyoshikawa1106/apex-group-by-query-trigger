@isTest
private class CategoryInfoTriggerDaoTest {

    private static CategoryInfoTriggerDao dao = new CategoryInfoTriggerDao();
    private static User testAdminUser = CategoryInfoTriggerTester.getLoginUser();

    /**
     * カテゴリ毎のカテゴリNo最大値取得
     * 値なし
     */
    static testMethod void getOldCategoryInfoListTest1() {
        
        System.runAs(testAdminUser) {

            Set<String> categories = new Set<String>();

            Test.startTest();
            
            List<AggregateResult> results = dao.getOldCategoryInfoList(categories);
            System.assertEquals(results.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリ毎のカテゴリNo最大値取得
     * 値あり
     */
    static testMethod void getOldCategoryInfoListTest2() {
        
        System.runAs(testAdminUser) {

            Set<String> categories = new Set<String>{'PC'};
            // カテゴリ情報テストデータ
            String category = 'PC';
            CategoryInfo__c categoryInfo = CategoryInfoTriggerTester.createCategoryInfo(category, true);

            Test.startTest();
            
            List<AggregateResult> results = dao.getOldCategoryInfoList(categories);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
            System.assertEquals((String)results[0].get('Category__c'), category);
            System.assertEquals((Decimal)results[0].get('maxCategoryNo'), 1);
        }
    }
}