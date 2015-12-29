@isTest
private class CategoryInfoTriggerHelperTest {
  
    private static CategoryInfoTriggerHelper helper = new CategoryInfoTriggerHelper();
    private static CategoryInfoTriggerDao dao = new CategoryInfoTriggerDao();
    private static User testAdminUser = CategoryInfoTriggerTester.getLoginUser();

    /**
     * 対象カテゴリ取得
     * 値なし
     */
    static testMethod void getCategoriesTest1() {
        
        System.runAs(testAdminUser) {

            List<CategoryInfo__c> categoryNewList = new List<CategoryInfo__c>();

            Test.startTest();
            
            Set<String> results = helper.getCategories(categoryNewList);
            System.assertEquals(results.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * 対象カテゴリ取得
     * 値あり
     */
    static testMethod void getCategoriesTest2() {
        
        System.runAs(testAdminUser) {

            List<CategoryInfo__c> categoryNewList = new List<CategoryInfo__c>();
            categoryNewList.add(CategoryInfoTriggerTester.createCategoryInfo('PC', false));
            categoryNewList.add(CategoryInfoTriggerTester.createCategoryInfo('Phone', false));
            categoryNewList.add(CategoryInfoTriggerTester.createCategoryInfo('', false));

            Test.startTest();
            
            Set<String> results = helper.getCategories(categoryNewList);
            System.assertEquals(results.size(), 2);
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリ毎のカテゴリNo(最大値)を取得
     * 値なし
     */
    static testMethod void getCategoryMapTest1() {
        
        System.runAs(testAdminUser) {

            List<AggregateResult> oldCategoryInfoList = new List<AggregateResult>();

            Test.startTest();
            
            Map<String, Decimal> results = helper.getCategoryMap(oldCategoryInfoList);
            System.assertEquals(results.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリ毎のカテゴリNo(最大値)を取得
     * 値あり
     */
    static testMethod void getCategoryMapTest2() {
        
        System.runAs(testAdminUser) {

            Set<String> categories = new Set<String>{'PC'};
            String category = 'PC';
            CategoryInfo__c categoryInfo = CategoryInfoTriggerTester.createCategoryInfo(category, true);
            List<AggregateResult> oldCategoryInfoList = dao.getOldCategoryInfoList(categories);

            Test.startTest();
            
            Map<String, Decimal> resultMap = helper.getCategoryMap(oldCategoryInfoList);
            System.assertEquals(resultMap.get('PC'), 1);
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリNoのセット
     * 値なし
     */
    static testMethod void setCategoryNoTest1() {
        
        System.runAs(testAdminUser) {

            List<CategoryInfo__c> categoryNewList = new List<CategoryInfo__c>();
            Map<String, Decimal> categoryMap = new Map<String, Decimal>();

            Test.startTest();
            
            Map<String, Decimal> results = helper.setCategoryNo(categoryNewList, categoryMap);
            System.assertEquals(results.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリNoのセット
     * カテゴリあり
     * Mapなし
     */
    static testMethod void setCategoryNoTest2() {
        
        System.runAs(testAdminUser) {

            List<CategoryInfo__c> categoryNewList = new List<CategoryInfo__c>();
            categoryNewList.add(new CategoryInfo__c(Category__c = 'PC'));
            Map<String, Decimal> categoryMap = new Map<String, Decimal>();

            Test.startTest();
            
            Map<String, Decimal> resultMap = helper.setCategoryNo(categoryNewList, categoryMap);
            System.assertEquals(resultMap.get('PC'), 1);
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリNoのセット
     * カテゴリあり
     * Mapあり(キーあり、値なし)
     */
    static testMethod void setCategoryNoTest3() {
        
        System.runAs(testAdminUser) {

            List<CategoryInfo__c> categoryNewList = new List<CategoryInfo__c>();
            categoryNewList.add(new CategoryInfo__c(Category__c = 'PC'));
            Map<String, Decimal> categoryMap = new Map<String, Decimal>();
            categoryMap.put('PC', null);

            Test.startTest();
            
            Map<String, Decimal> resultMap = helper.setCategoryNo(categoryNewList, categoryMap);
            System.assertEquals(resultMap.get('PC'), 1);
            
            Test.stopTest();
        }
    }

    /**
     * カテゴリNoのセット
     * カテゴリあり
     * Mapあり(キーあり、値あり)
     */
    static testMethod void setCategoryNoTest4() {
        
        System.runAs(testAdminUser) {

            List<CategoryInfo__c> categoryNewList = new List<CategoryInfo__c>();
            categoryNewList.add(new CategoryInfo__c(Category__c = 'PC'));
            Map<String, Decimal> categoryMap = new Map<String, Decimal>();
            categoryMap.put('PC', 10);

            Test.startTest();
            
            Map<String, Decimal> resultMap = helper.setCategoryNo(categoryNewList, categoryMap);
            System.assertEquals(resultMap.get('PC'), 11);
            
            Test.stopTest();
        }
    }
}