public with sharing class CategoryInfoTriggerHelper {

    /**
     * コンストラクタ
     */
    public CategoryInfoTriggerHelper() {
        
    }

    /**
     * 対象カテゴリ取得
     */
    public Set<String> getCategories(List<CategoryInfo__c> categoryNewList) {
        Set<String> categories = new Set<String>();
        for (CategoryInfo__c c : categoryNewList) {
            if (String.isNotEmpty(c.Category__c)) {
                categories.add(c.Category__c);
            }
        }

        return categories;
    }

    /**
     * カテゴリ毎のカテゴリNo(最大値)を取得
     */
    public Map<String, Decimal> getCategoryMap(List<AggregateResult> oldCategoryInfoList) {
        Map<String, Decimal> categoryMap = new Map<String, Decimal>();
        for (AggregateResult ar : oldCategoryInfoList) {
            String category = (String)ar.get('Category__c');
            Decimal maxCategoryNo = (Decimal)ar.get('maxCategoryNo');
            // Add Map
            categoryMap.put(category, maxCategoryNo);
        }

        return categoryMap;
    }

    /**
     * カテゴリNoのセット
     */
    public Map<String, Decimal> setCategoryNo(List<CategoryInfo__c> categoryNewList, Map<String, Decimal> categoryMap) {
        for (CategoryInfo__c c : categoryNewList) {
            // カテゴリに値が存在するかチェック
            if (String.isNotEmpty(c.Category__c)) {
                // Mapにセット済みかチェック
                if (categoryMap.containsKey(c.Category__c)) {
                    // CategoryNoの最大値取得
                    Decimal maxNo = categoryMap.get(c.Category__c);
                    // +1を加算
                    if (maxNo != null) {
                        maxNo++;
                    } else {
                        maxNo = 1;
                    }
                    // 値をセット
                    c.CategoryNo__c = maxNo;
                } else {
                    c.CategoryNo__c = 1;
                }
                // Mapに追加
                categoryMap.put(c.Category__c, c.CategoryNo__c);
            }
        }

        return categoryMap;
    }
}