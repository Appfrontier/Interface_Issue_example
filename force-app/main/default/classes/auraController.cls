public class auraController {

    /**
     * This will return a class that implements the interface.
     * It is meant to determine which class to instantiate as there would be several classes that implement the interface
     * Which one is determined by the record type of an object that would be passed into this method
     *
     * @return Object A generic Object that can be return to Aura.
     */
    @AuraEnabled public static Object getClassThatImplements() {
        try {
            return (theInterface)New classThatImplements();
        }catch(Exception e){
            AuraHandledException aex = New AuraHandledException(e.getMessage());
            aex.setMessage(e.getMessage());
            throw aex;
        }

    }

    /**
     * Takes the JSON representation of the implemented Interface Class
     *
     * @param objectJSON
     *
     * @return
     */
    @AuraEnabled public static String consumeClassThatImplements(String objectJSON) {
        try {
            //Since we cannot use an interface for the Apex Type need to figure out the class name and deserialze casting to interface type
            theInterface controller = (theInterface) json.deserialize(objectJSON, Type.forName(getClassName(objectJSON)));
            controller.anImplementedMethod();
            return 'Look ma no errors';
        }catch(Exception e){
//            We Don't expect any aura errors for this demo
//            AuraHandledException aex = New AuraHandledException(e.getMessage());
//            aex.setMessage(e.getMessage());
//            throw aex;
            throw new auraController_Exception(e.getMessage()); //So we actually get a message in the apex demo
        }
    }

    /**
     * Gets the Name property from a class
     *
     * @param objectJSON
     *
     * @return
     */
    @TestVisible private static String getClassName(String objectJSON){
        Map<String,Object> tmp = (Map<String, Object>) JSON.deserializeUntyped(objectJSON);
        //Just for debugging purposes
        for(String key : tmp.keySet()){
            System.debug('Key: ' + key + ' - Value: ' + tmp.get(key));
        }

        String typeName = (String) ( (Map<String, Object>) JSON.deserializeUntyped(objectJSON) ).get('name');

        System.debug('Type Name:' + typeName);

        if(String.isBlank(typeName)){
            throw new auraController_Exception('Well, this did not work as the name property was blank');
        }

        return typeName;


    }

    public class auraController_Exception extends Exception{}

}