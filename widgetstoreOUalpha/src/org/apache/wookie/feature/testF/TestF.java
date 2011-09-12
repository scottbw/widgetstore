package org.apache.wookie.feature.testF;

import org.apache.wookie.feature.IFeature;

public class TestF implements IFeature{
	
	public String getName() {
		return "http://widgets.kmi.open.ac.uk/test/testF";
	}

	public String[] scripts() {
		return new String[]{"/wookie/shared/js/testfeature.js"};
	}

	public String[] stylesheets() {
		return null;
	}
}
