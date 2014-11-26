package jar

import org.apache.wicket.protocol.http.WebApplication

/**
 * Application object for your web application. If you want to run this application without deploying, run the Start class.
 * 
 * @see jar.Start#main(String[])
 */
class WicketApplication extends WebApplication {
	
	override getHomePage() {
		return HomePage
	}
	
}