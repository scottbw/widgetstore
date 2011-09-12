package org.apache.wookie.beans;

import java.sql.Timestamp;

public interface IAccessLog extends IBean{
	int getWidgetId();

    void setWidgetId(int widgetId); 

    int getUserId();

    void setUserId(int userId); 

    Timestamp getAccessTime();

    void setAccessTime(Timestamp accessTime);
    
    int getApiKeyId();
    
    void setApiKeyId(int apikey);
    
    String getContainerUser();
    
    void setContainerUser(String user);
}
