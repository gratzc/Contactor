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


component{

	// DI
	property name="settingService" inject="settingService@cb";
	property name="cb" inject="cbHelper@cb";

	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	public function preHandler(event, action, eventArguments) {
		var rc 	= event.getCollection();
		var prc = event.getCollection(private = true);
	}

	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	public void function index(event,rc,prc){
		//Create a Contactor Settings page in the admin section
		prc.xehSave = cb.buildModuleLink("Contactor","settings.save"); // Exit handler
		prc.tabModules_letitsnow = true;
		var args = {name="Contactor"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			prc.settings = deserializeJson(setting.getValue());
		}	
		event.setView("settings/index");
	}

	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	public function save(event, rc, prc) {
		//Save the settings from the admin
		for(var count = 1; count <= listLen(rc.fieldnames); count++) {
			prc.settings[listGetAt(rc.fieldnames, count)] = rc[listGetAt(rc.fieldnames, count)];
		}
		// Save settings
		var args = {name="Contactor"};
		var setting = settingService.findWhere(criteria=args);
		setting.setValue( serializeJSON( prc.settings ) );
		settingService.save( setting );
		//save to cachebox
		getColdboxOCM().set('modules-Contactor-settings',event.getValue(name='settings',private=true,defaultValue={}),0,0);
		// Messagebox
		getPlugin("MessageBox").info("Settings Saved & Updated!");
		setNextEvent('cbadmin.module.Contactor.settings');
	}
}