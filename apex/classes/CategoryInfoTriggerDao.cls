public with sharing class CategoryInfoTriggerDao {

    /**
     * コンストラクタ
     */
    public CategoryInfoTriggerDao() {
        
    }

    /**
     * カテゴリ毎のカテゴリNo最大値取得
     */
    public List<AggregateResult> getOldCategoryInfoList(Set<String> categories) {
        return [
            SELECT
                 Category__c
                ,Max(CategoryNo__c) maxCategoryNo
            FROM
                CategoryInfo__c
            WHERE
                Category__c IN: categories
            GROUP BY Category__c
        ];
    }
}