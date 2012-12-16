/*
 * Based on the contactable plugin here: https://github.com/philipbeel/contactable/
 * 
 * ORGINAL AUTHOR OF THE CONTACTABLE AUTHOR
 * Copyright (c) 2009 Philip Beel (http://www.theodin.co.uk/) 
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php) 
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 */
 
(function(jQuery){

	// Define the new for the plugin ans how to call it	
	jQuery.fn.contactor = function(options) {
		// Set default options  
		var defaults = {
			url: '/modules/contentbox/modules/Contactor/handlers/mailer.cfc',
			to: '',
			subject : 'Someone has Contactored you through ContentBox',
			name: 'Name',
			email: 'Email',
			dropdownTitle: '',
			dropdownOptions: ['General', 'Website bug', 'Feature request'],
			message : 'Message',
			submit : 'SEND',
			recievedMsg : 'Thank you for your message',
			notRecievedMsg : 'Sorry but your message could not be sent, try again later',
			disclaimer: 'Please feel free to get in touch, we value your feedback',
			hideOnSubmit: true
		};

		var options = jQuery.extend(defaults, options);
		
		return this.each(function() {

			// Create the form and inject it into the DOM
			var dropdown = ''
			,	filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
			,	dropdownLen = options.dropdownOptions.length
			,	i;

			// Add select option if applicable
			if(options.dropdownTitle) {
				dropdown += '<p><label for="contactor-dropdown">'+options.dropdownTitle+' </label><br /><select name="dropdown" id="contactor-dropdown" class="contactor-dropdown">';

				for(i=0; i < dropdownLen; i++) {
					dropdown += '<option value="'+options.dropdownOptions[i]+'">'+options.dropdownOptions[i]+'</option>';
				}			
				
				dropdown += '</select></p>';
			}
			// Form layout
			/*	
			*	<div id="contactor-inner"></div>
			*	<form id="contactor-ContactorForm" method="" action="">
			*  		<div id="contactor-loading"></div>
			*		<div id="contactor-callback"></div>
			* 		<div class="contactor-holder">
			* 			<p>
			*				<label for="contactor-name">Name<span class="contactor-green"> * </span></label><br />
			*				<input id="contactor-name" class="contactor-Contactor contactor-validate" name="name" />
			*			</p>
			*			<p>
			*				<label for="contactor-email"> Email address <span class="contactor-green"> * </span></label><br />
			* 				<input id="contactor-email" class="contactor-Contactor contactor-validate" name="email" />
			*			</p>
			* 			<p>
			*				<label for="contactor-message"> Message <span class="contactor-green"> * </span></label><br />
			* 				<textarea id="contactor-message" name="message" class="contactor-message contactor-validate" rows="4" cols="30" ></textarea>
			*			</p>
			*			<p>
			*				<input class="contactor-submit" type="submit" value="Submit"/>
			*			</p>
			*			<p class="contactor-disclaimer">Disclaimer</p>
			*		</div>
			*	</form>
			*/

			jQuery(this).html('<div id="contactor-inner"></div><form id="contactor-ContactorForm" method="" action=""><div id="contactor-loading"></div><div id="contactor-callback"></div><div class="contactor-holder"><p><label for="contactor-name">'+options.name+'<span class="contactor-green"> * </span></label><br /><input id="contactor-name" class="contactor-Contactor contactor-validate" name="name" /></p><p><label for="contactor-email">'+options.email+' <span class="contactor-green"> * </span></label><br /><input id="contactor-email" class="contactor-Contactor contactor-validate" name="email" /></p>'+dropdown+'<p><label for="contactor-message">'+options.message+' <span class="contactor-green"> * </span></label><br /><textarea id="contactor-message" name="message" class="contactor-message contactor-validate" rows="4" cols="30" ></textarea></p><p><input class="contactor-submit" type="submit" value="'+options.submit+'"/></p><p class="contactor-disclaimer">'+options.disclaimer+'</p></div></form>');
			
			// Toggle the form visibility
			jQuery('#contactor-inner').toggle(function() {
				jQuery('#contactor-overlay').css({display: 'block'});
				jQuery(this).animate({"marginLeft": "-=5px"}, "2000"); 
				jQuery('#contactor-ContactorForm').animate({"marginLeft": "-=0px"}, "2000");
				jQuery(this).animate({"marginLeft": "+=387px"}, "4000"); 
				jQuery('#contactor-ContactorForm').animate({"marginLeft": "+=390px"}, "4000"); 
			}, 
			function() {
				jQuery('#contactor-ContactorForm').animate({"marginLeft": "-=390px"}, "4000");
				jQuery(this).animate({"marginLeft": "-=387px"}, "4000").animate({"marginLeft": "+=5px"}, "2000"); 
				jQuery('#contactor-overlay').css({display: 'none'});
			});
			
			// Submit the form
			jQuery("#contactor-ContactorForm").submit(function() {
				
				// Validate the entries
				var valid = true
				,	params;

				//Remove any previous errors
				jQuery("#contactor-ContactorForm .contactor-validate").each(function() {
					jQuery(this).removeClass('contactor-invalid');
				});

				// Loop through requigreen field
				jQuery("#contactor-ContactorForm .contactor-validate").each(function() {
					
					// Check the min length
					if(jQuery(this).val().length < 2) {
						jQuery(this).addClass("contactor-invalid");
						valid = false;
					}

					//Check email is valid
					if (!filter.test(jQuery("#contactor-ContactorForm #contactor-email").val())) {
						jQuery("#contactor-ContactorForm #contactor-email").addClass("contactor-invalid");
						valid = false;
					}						
				});

				if(valid === true) {
					submitForm();
				}
				return false;
			});

			function submitForm() {
				// Display loading animation
				jQuery('.contactor-holder').hide();
				jQuery('#contactor-loading').show();
				
				// Trigger form submission if form is valid
				jQuery.ajax({
					type: 'GET',
					url: options.url,
					data: {
						method: "index",
						subject:options.subject,
						to:options.to,
						name:jQuery('#contactor-name').val(), 
						email:jQuery('#contactor-email').val(), 
						issue:jQuery('#contactor-dropdown').val(), 
						message:jQuery('#contactor-message').val()
					},
					success: function(data) {
						// Hide loading animation
						jQuery('#contactor-loading').css({display:'none'}); 

						// Check for a valid server side response
						if( data ) {
							jQuery('#contactor-callback').show().append(options.recievedMsg);
							if(options.hideOnSubmit === true) {
								//hide the tab after successful submition if requested
								jQuery('#contactor-ContactorForm').animate({dummy:1}, 2000).animate({"marginLeft": "-=450px"}, "slow");
								jQuery('#contactor-inner').animate({dummy:1}, 2000).animate({"marginLeft": "-=447px"}, "slow").animate({"marginLeft": "+=5px"}, "fast"); 
								jQuery('#contactor-overlay').css({display: 'none'});	
							}
						} else {
							jQuery('#contactor-callback').show().append(options.notRecievedMsg);
							setTimeout(function(){
								jQuery('.contactor-holder').show();
								jQuery('#contactor-callback').hide().html('');
							},2000);
						}
					},
					error:function(e){
						jQuery('#contactor-loading').css({display:'none'}); 
						jQuery('#contactor-callback').show().append(options.notRecievedMsg);
					}
				});		
			}
		});
	};
 
})(jQuery);