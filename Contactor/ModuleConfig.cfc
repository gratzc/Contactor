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


component hint="Contactor Plugin"{

	// Module Properties
	this.title				= "Contactor Plugin";
	this.author 				= "William Giles";
	this.webURL 			= "http://www.xondesigns.com";
	this.description 		= "A module to load a Contactor plugin  and let your guests send you a message.";
	this.version				= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "Contactor";


	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	function configure() {

		// parent settings
		parentSettings = {};

		// module settings - stored in modules.name.settings
		settings = {
			to = 'ChangeMe@example.com',
			subject = 'Someone has Contactored you through ContentBox',
			name = 'Name',
			email = 'Email',
			dropdownTitle = 'Issue',
			message = 'Message',
			submit = 'SEND',
			recievedMsg = 'Thank you for your message',
			notRecievedMsg = 'Sorry but your message could not be sent, try again later',
			disclaimer = 'Please feel free to get in touch, we value your feedback'
		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// datasources
		datasources = {};

		// web services
		webservices = {};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Custom Declared Points
		interceptorSettings = {
		};

		// Custom Declared Interceptors
		interceptors = [
			{class="#moduleMapping#.interceptors.Contactor", name="Contactor@plugin"}
		];
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is registered and activated.
	//------------------------------------------------------------------------------------------------
	function onLoad() {
			// ContentBox unloading
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) ){
			// Let's add ourselves to the main menu in the Modules section
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			// Add Menu Contribution
			menuService.addSubMenu(topMenu = menuService.MODULES, name = "Contactor", label = "Contactor Plugin", href = "#menuService.buildModuleLink('Contactor','settings')#");	
		}
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is activated by ContentBox
	//------------------------------------------------------------------------------------------------
	function onActivate() {
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		// store default settings
		var args = {name="Contactor", value=serializeJSON( settings )};
		var ContactorSettings = settingService.new(properties=args);
		settingService.save( ContactorSettings );		
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is unregistered and unloaded
	//------------------------------------------------------------------------------------------------
	function onUnload() {
		// ContentBox unloading
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) ){
			// Let's remove ourselves to the main menu in the Modules section
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			// Remove Menu Contribution
			menuService.removeSubMenu(topMenu=menuService.MODULES,name="Contactor");
		}
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is deactivated by ContentBox
	//------------------------------------------------------------------------------------------------
	function onDeactivate() {
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var args = {name="Contactor"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			settingService.delete( setting );
		}
	}

}
