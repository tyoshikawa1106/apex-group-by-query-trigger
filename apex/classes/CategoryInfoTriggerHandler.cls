public with sharing class CategoryInfoTriggerHandler {

    private CategoryInfoTriggerHelper helper = new CategoryInfoTriggerHelper();
    private CategoryInfoTriggerDao dao = new CategoryInfoTriggerDao();

    /**
     * コンストラクタ
     */
    public CategoryInfoTriggerHandler() {
        
    }

    /**
     * カテゴリNoのセット
     */
    public void doSetCategoryNo(List<CategoryInfo__c> categoryNewList) {
        // 対象のカテゴリ値取得
        Set<String> categories = this.helper.getCategories(categoryNewList);
        // カテゴリ情報取得
        List<AggregateResult> oldCategoryInfoList = this.dao.getOldCategoryInfoList(categories);
        // カテゴリ毎のカテゴリNo(最大値)を取得
        Map<String, Decimal> categoryMap = this.helper.getCategoryMap(oldCategoryInfoList);
        // カテゴリNoのセット
        Map<String, Decimal> resultCategoryMap = this.helper.setCategoryNo(categoryNewList, categoryMap);
    }
}