({
	handleKeyUp: function (cmp, evt) {
        var isEnterKey = evt.keyCode === 13;
        if (isEnterKey) {
            var search = cmp.find('enter-search').get('v.value');
            
            var action = cmp.get("c.returnBusinesses");
            action.setParams({
                "search": search
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    
                    var aResponse =  JSON.stringify(response.getReturnValue());
                    var businesses = JSON.parse(aResponse);
                    var mapMarkers = [];
                    
                    for(var i=0; i<businesses.length; i++){
                        var business = businesses[i];
                        var marker = {
                            'location': {
                                Street: business.location.address1,
                                City: business.location.city,
                                State: business.location.state
                            },
                            'icon': 'custom:custom26',
                            'title':business.name
                        };
                        mapMarkers.push( marker );
                    }
                    cmp.set( 'v.mapMarkers', mapMarkers );
                }
            });
            $A.enqueueAction(action); 
        }
    },
    init: function (cmp, event, helper) {      
        cmp.set('v.mapMarkers', [
            {
                location: {
                    City: '',
                    Country: ''
                },

                icon: 'custom:custom26',
                title: 'Search'
            }
        ]);
    },
    updateContact: function(cmp, event, helper){
        var location = cmp.find('meeting-location').get('v.value');
        var time = cmp.find('meeting-time').get('v.value');
        
        var cnt = cmp.get("v.recordId");
        alert(cnt);
        
        /*
        var action = cmp.get("c.updateContact");
        action.setParams({
                "recordId": cmp.get("v.recordId")
            });
        action.setCallback(this, function(response){
            var state = response.getState();
                if (state === "SUCCESS") {
                    var cont = response.getReturnValue();
                    alert(cont);
                    
                }
        });
        $A.enqueueAction(action);
        */
    }
})