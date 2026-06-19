sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ns.resourcehierarchies',
            componentId: 'ResourceHierarchiesObjectPage',
            contextPath: '/ResourceHierarchies'
        },
        CustomPageDefinitions
    );
});