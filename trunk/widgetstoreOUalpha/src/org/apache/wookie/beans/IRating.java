package org.apache.wookie.beans;

public interface IRating extends IBean{

	Integer getId();

	void setId(Integer id);

	int getUserid();

	void setUserid(int userid);

	int getWidid();

	void setWidid(int widid);

	double getRate();

	void setRate(double rate);

}
