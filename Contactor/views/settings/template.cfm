<!---
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
--->
<cfoutput>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<link rel="stylesheet" href="#event.getModuleRoot('Contactor')#/includes/css/contactor.css" type="text/css" />
	<div id="ContactorPlugin"><!-- contactor html placeholder --></div>
	<script type="text/javascript" src="#event.getModuleRoot('Contactor')#/includes/js/jquery.contactor.js"></script>
	<script type="text/javascript">
	jQuery(function(){
		jQuery('##ContactorPlugin').contactor(
		{
			to: '#prc.ContactorSettings.To#',
			subject: '#prc.ContactorSettings.Subject#',
			name: '#prc.ContactorSettings.Name#',
			email: '#prc.ContactorSettings.Email#',
			dropdownTitle: '#prc.ContactorSettings.dropdownTitle#',
			message : '#prc.ContactorSettings.message#',
			submit : '#prc.ContactorSettings.submit#',
			recievedMsg : '#prc.ContactorSettings.recievedMsg#',
			notRecievedMsg : '#prc.ContactorSettings.notRecievedMsg#',
			disclaimer: '#prc.ContactorSettings.disclaimer#'
		});
	});
	</script>
</cfoutput>