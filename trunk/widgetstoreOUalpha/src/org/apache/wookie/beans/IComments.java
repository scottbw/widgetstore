package org.apache.wookie.beans;

import java.sql.Timestamp;

public interface IComments extends IBean{

	Integer getId();

	void setId(Integer id);

	int getWidid();

	void setWidid(int widid);

	int getUserid();

	void setUserid(int userid);

	String getCommentext();

	void setCommentext(String commentext);
	
	Timestamp getCreationDate();
	
	void setCreationDate(Timestamp creationDate);	
	
}
