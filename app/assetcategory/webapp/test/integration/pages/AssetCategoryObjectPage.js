sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ns.assetcategory',
            componentId: 'AssetCategoryObjectPage',
            contextPath: '/AssetCategory'
        },
        CustomPageDefinitions
    );
});