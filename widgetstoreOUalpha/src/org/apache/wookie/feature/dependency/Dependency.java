package org.apache.wookie.feature.dependency;

import org.apache.wookie.feature.IFeature;
import org.apache.wookie.feature.IFeature;

/**
 * Polling Support - turned on by using a 
 * <feature name="http://www.getwookie.org/usefeature/polling"> tag in the manifest file
 *   
 * @author Paul Sharples
 * @version $Id: WookiePollingImpl.java,v 1.2 2009-07-28 16:05:23 scottwilson Exp $ 
 */
public class Dependency implements IFeature{
	
	public String getName() {
		return "http://widgets.kmi.open.ac.uk/wookie/dependency";
	}

	public String[] scripts() {
		return new String[]{"/wookie/shared/js/dependency.js"};
	}

	public String[] stylesheets() {
		return new String[]{"/wookie/shared/css/dependency.css"};
	}
}