({
    init: function (component, event, helper) {

        var response = component.get("c.getClassThatImplements");

        response.setCallback(this, function (returnValue) {
            if (component.isValid() && returnValue.getState() === 'SUCCESS') {
                var returnedData = returnValue.getReturnValue();

                //This will show that the name property has been set after assignemnt to the attribute
                console.log(JSON.stringify(returnedData));

                component.set("v.returnedObject", returnedData);


            } else if (component.isValid() && returnValue.getState() === 'ERROR') {
                alert(returnValue.getError()[0].message);
            }

        });
        $A.enqueueAction(response);

    },
    callController: function(component, event, helper){
        var doIt = component.get("c.consumeClassThatImplements");

        doIt.setParams({
            "objectJSON": JSON.stringify(component.get("v.returnedObject"))
        });

        //Do the initial update to the profile to ready for Chargent Use
        doIt.setCallback(this, function (rtn) {
            if (component.isValid() && rtn.getState() === 'SUCCESS') {
                component.set("v.result",rtn.getReturnValue());
            } else if (component.isValid() && rtn.getState() === 'ERROR') {
                alert(rtn.getError()[0].message);
            }

        });
        $A.enqueueAction(doIt);

    },

})