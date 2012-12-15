component singleton{
	//This is the mailing function for the Contactor Plugin
	public function index(to="", email="", message="") access="remote"{
		if(arguments.to != "" && arguments.email != "" && arguments.message != ""){
			local.message = "<div>
				<h2>Contactor Submission <small>on Content Box</small></h2>
				<p>Someone has submitted your Contactor form on Content Box<br><br></p>
				<p>
					<strong>Name:</strong> #arguments.name# <br />
					<strong>E-mail:</strong> #arguments.email# <br />
					<strong>Issue:</strong> #arguments.issue# 
				</p>

				<p><strong>Message:</strong> #arguments.message# </p>

				</div>";
			mailerService = new mail(); 
			mailerService.setTo(arguments.to); 
			mailerService.setFrom(URLDecode(arguments.email)); 
			mailerService.setSubject(arguments.subject); 
			mailerService.setType("html"); 
			mailerService.setBody(local.message);
			mailerService.send(); 
			return true;
		}else{
			return false;
		}
	}
}