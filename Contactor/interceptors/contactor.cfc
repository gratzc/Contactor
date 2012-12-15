/********************************************************************************
A module to load a Contactor plugin  and let your guests send you a message
Copyright 2012 by William Giles http://www.xondesigns.com.com
********************************************************************************
Apache License, Version 2.0

Copyright Since [2012] [William Giles]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
********************************************************************************/

component extends="coldbox.system.Interceptor" {
	//------------------------------------------------------------------------------------------------
	property name="settingService" inject="settingService@cb";
	property name="cacheBox" inject="coldbox:cacheManager";
	//------------------------------------------------------------------------------------------------
	//Intercept at the end of the body
	public void function cbui_beforeBodyEnd(event, interceptData) {
	    var prc = event.getCollection(private = true);
		prc.ContactorSettings = {};
		
		//check if settings in coldbox cache
		if (getColdboxOCM().lookup('modules-Contactor-settings') eq false){
			var args = {name="Contactor"};
			var setting = settingService.findWhere(criteria=args);			
			if( !isNull(setting) ){
				prc.ContactorSettings = deserializeJson(setting.getValue());
			}else{
				prc.ContactorSettings = getModuleSettings("Contactor").settings;
			}
			//save to cachebox
			getColdboxOCM().set('modules-Contactor-settings',prc.ContactorSettings,0,0);
		}else{
			prc.ContactorSettings = getColdboxOCM().get('modules-Contactor-settings');
		}	
		if (not structisEmpty(prc.ContactorSettings)){
			//render the cached Contactor template for the settings for the plugin
			appendToBuffer( renderview(view='settings/template',module='Contactor') );		
		}
	}
}
