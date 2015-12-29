@isTest
private class CategoryInfoTriggerHandlerTest {

    private static User testAdminUser = CategoryInfoTriggerTester.getLoginUser();

    /**
     * 対象カテゴリ取得
     * 1件登録
     */
    static testMethod void CategoryInfoTriggerHandlerTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            String category = 'PC';
            CategoryInfo__c categoryInfo = CategoryInfoTriggerTester.createCategoryInfo(category, true);
            
            Test.stopTest();

            CategoryInfo__c result = [SELECT Id,Category__c,CategoryNo__c FROM CategoryInfo__c WHERE Id =: categoryInfo.Id LIMIT 1];
            System.assertEquals(result.Category__c, 'PC');
            System.assertEquals(result.CategoryNo__c, 1);
        }
    }

    /**
     * 対象カテゴリ取得
     * 201件登録
     */
    static testMethod void CategoryInfoTriggerHandlerTest2() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            String category = 'PC';
            List<CategoryInfo__c> categoryList = new List<CategoryInfo__c>();
            for (Integer i = 0; i < 201; i++) {
                categoryList.add(CategoryInfoTriggerTester.createCategoryInfo(category, false));
            }
            insert categoryList;
            System.assertEquals(categoryList.size(), 201);
            
            Test.stopTest();

            List<AggregateResult> results = [SELECT Category__c,Max(CategoryNo__c) maxCategoryNo FROM CategoryInfo__c
                                                                            WHERE Category__c = 'PC' GROUP BY Category__c];
            System.assertEquals(results.size(), 1);
            System.assertEquals((String)results[0].get('Category__c'), category);
            System.assertEquals((Decimal)results[0].get('maxCategoryNo'), 201);
        }
    }

    /**
     * 対象カテゴリ取得
     * 複数カテゴリの登録
     */
    static testMethod void CategoryInfoTriggerHandlerTest3() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            List<CategoryInfo__c> categoryList = new List<CategoryInfo__c>();
            categoryList.add(CategoryInfoTriggerTester.createCategoryInfo('PC', false));
            categoryList.add(CategoryInfoTriggerTester.createCategoryInfo('PC', false));
            categoryList.add(CategoryInfoTriggerTester.createCategoryInfo('PC', false));
            categoryList.add(CategoryInfoTriggerTester.createCategoryInfo('Phone', false));
            categoryList.add(CategoryInfoTriggerTester.createCategoryInfo('Phone', false));
            categoryList.add(CategoryInfoTriggerTester.createCategoryInfo('Tablet', false));
            categoryList.add(CategoryInfoTriggerTester.createCategoryInfo('Watch', false));
            insert categoryList;
            System.assertEquals(categoryList.size(), 7);
            
            Test.stopTest();

            List<AggregateResult> results = [SELECT Category__c, Max(CategoryNo__c) maxCategoryNo FROM CategoryInfo__c GROUP BY Category__c];
            System.assertEquals(results.size(), 4);

            Map<String, Decimal> categoryMap = new Map<String, Decimal>();
            for (AggregateResult ar : results) {
                String category = (String)ar.get('Category__c');
                Decimal maxCategoryNo = (Decimal)ar.get('maxCategoryNo');
                // Add Map
                categoryMap.put(category, maxCategoryNo);
            }

            System.assertEquals(categoryMap.get('PC'), 3);
            System.assertEquals(categoryMap.get('Phone'), 2);
            System.assertEquals(categoryMap.get('Tablet'), 1);
            System.assertEquals(categoryMap.get('Watch'), 1);
        }
    }
}