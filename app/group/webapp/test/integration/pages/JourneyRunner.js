sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/group/test/integration/pages/GroupsList",
	"ns/group/test/integration/pages/GroupsObjectPage"
], function (JourneyRunner, GroupsList, GroupsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/group') + '/test/flpSandbox.html#nsgroup-tile',
        pages: {
			onTheGroupsList: GroupsList,
			onTheGroupsObjectPage: GroupsObjectPage
        },
        async: true
    });

    return runner;
});

