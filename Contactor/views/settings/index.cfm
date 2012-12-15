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
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Info Box --->
	<div class="small_box expose">
		<div class="header">
			<img src="#prc.cbroot#/includes/images/info.png" alt="info" width="24" height="24" />Need Help?
		</div>
		<div class="body">
			<p>
				<strong>Contactor Plugin</strong> - A module to load and configure the Contactor Plugin Script 
			</p>
		</div>
	</div>
	<div class="small_box expose">
		<div class="header">
			<img src="#prc.cbroot#/includes/images/info.png" alt="info" width="24" height="24" />Other Contributions
		</div>
		<div class="body">
			<p>
				Here are by other contribution to Coldbox Community which can be downloaded from ForgeBox.
			</p>
			<ul>
				<li><a href="http://www.coldbox.org/forgebox/view/Aggregator">Aggregator Module</a></li>
				<li><a href="http://www.coldbox.org/forgebox/view/reCAPTCHA">reCaptch Plugin</a></li>
				<li><a href="http://www.coldbox.org/forgebox/view/Google-URL-Shortener">Google URL Shortner Plugin</a></li>
				<li><a href="http://www.coldbox.org/forgebox/view/QRCodeGenerator">QR Code generator Plugin</a></li>
				<li><a href="http://www.coldbox.org/forgebox/view/Maintenance-Mode">Maintenance Mode Interceptor</a></li>
			</ul>
		</div>
	</div>
</div>
<!--End sidebar-->
<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<!--- Body Header --->
		<div class="header">
			Contactor Plugin Settings
		</div>
		<!--- Body --->
		<div class="body" id="mainBody">
			#getPlugin("MessageBox").renderit()#
			#html.startForm(action=prc.xehSave,name="settingsForm")#

			<div class="body_vertical_nav clearfix">
				<div class="main_column">
				<!-- Content area that wil show the form and stuff -->
				<div class="panes_vertical">

				<!--- Settings --->
				<div>
				<fieldset>
				<legend><img src="#prc.cbRoot#/includes/images/settings_black.png" alt="modifiers"/> <strong>Settings</strong></legend>
					<p>From here you can change the settings for the Contactor Plugin</p>
					
					<label for="to">Email To</label>		
					<small>The email you want the form to go to</small><br/>
					#html.textField(name="to",value=prc.settings.to,size=40,class="textfield",required=true)#

					<label for="subject">Email Subject</label>		
					<small>Subject Line for Contactor Form</small><br/>
					#html.textField(name="subject",value=prc.settings.subject,size=40,class="textfield",required=true)#

					<label for="name">Name</label>		
					<small>Name field for user submitting form</small><br/>
					#html.textField(name="name",value=prc.settings.name,size=40,class="textfield",required=true)#

					<label for="name">Email</label>		
					<small>Email field for user submitting form</small><br/>
					#html.textField(name="email",value=prc.settings.email,size=40,class="textfield",required=true)#

					<label for="dropdownTitle">Dropdown Title</label>		
					<small>Dropdown Title field for user submitting form</small><br/>
					#html.textField(name="dropdownTitle",value=prc.settings.dropdownTitle,size=40,class="textfield",required=true)#

					<label for="message">Message</label>		
					<small>Message field for user submitting form</small><br/>
					#html.textField(name="message",value=prc.settings.message,size=40,class="textfield",required=true)#

					<label for="submit">Submit Button</label>		
					<small>Submit Button Name for user submitting form</small><br/>
					#html.textField(name="submit",value=prc.settings.submit,size=40,class="textfield",required=true)#

					<label for="recievedMsg">Received Message</label>		
					<small>Received Message on form submission</small><br/>
					#html.textField(name="recievedMsg",value=prc.settings.recievedMsg,size=40,class="textfield",required=true)#

					<label for="notRecievedMsg">Not Received Message</label>		
					<small>Not Received Message on form submission</small><br/>
					#html.textField(name="notRecievedMsg",value=prc.settings.notRecievedMsg,size=40,class="textfield",required=true)#

					<label for="disclaimer">Disclaimer Message</label>		
					<small>Disclaimer Message on form submission</small><br/>
					#html.textField(name="disclaimer",value=prc.settings.disclaimer,size=40,class="textfield",required=true)#
						
				</fieldset>
				</div>

				</div> <!--- end vertical panes --->
				</div> <!--- end main_column --->

			</div> <!--- End vertical nav --->

			<!--- Submit --->
			<div class="actionBar center">
				#html.submitButton(value="Save Settings",class="buttonred",title="Save the Contactor Plugin settings")#
			</div>

			#html.endForm()#

		</div>
	</div>
</div>
</cfoutput>