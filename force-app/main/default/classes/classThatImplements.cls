public with sharing class classThatImplements implements theInterface{
    @AuraEnabled public static string getName(){
        return 'classThatImplements';
    }

    @AuraEnabled public String somethingPreset {get { return 'preset'; }set;}

    public static void anImplementedMethod(){
        System.debug('I am doing something');
    }

}