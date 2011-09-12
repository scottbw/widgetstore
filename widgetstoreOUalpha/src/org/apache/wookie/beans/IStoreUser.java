package org.apache.wookie.beans;

public interface IStoreUser extends IBean{
	Integer getId();
	String getFullname();
	void setFullname(String fullname);
	String getUsername();
    void setUsername(String username);
    String getPassword();
    void setPassword(String password); 
    String getSalt();
    void setSalt(String salt); 
    String getEmail();
    void setEmail(String email); 
    String getHashedUserNameWS();
    void setHashedUserNameWS(String hashedUserNameWS);
}