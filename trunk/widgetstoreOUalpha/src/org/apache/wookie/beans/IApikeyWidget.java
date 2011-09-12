package org.apache.wookie.beans;

public interface IApikeyWidget extends IBean{
	Integer getId();
	int getAPIkeyID();
	int getWidgetId();
	void setAPIkeyID(int api);
	void setWidgetId(int wid);	
}
