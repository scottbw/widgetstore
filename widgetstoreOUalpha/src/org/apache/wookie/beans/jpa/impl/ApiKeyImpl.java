/*
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package org.apache.wookie.beans.jpa.impl;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Version;

import org.apache.wookie.beans.IApiKey;

/**
 * ApiKeyImpl - JPA IApiKey implementation.
 * 
 * @author <a href="mailto:rwatler@apache.org">Randy Watler</a>
 * @version $Id$
 */
@Entity(name="ApiKey")
@Table(name="ApiKey")
public class ApiKeyImpl implements IApiKey
{
    @Id
    @GeneratedValue(strategy=GenerationType.AUTO)
    @Column(name="id", nullable=false)
    private int id;

    @Version
    @Column(name="jpa_version")
    @SuppressWarnings("unused")
    private int jpaVersion;

    @Basic(optional=false)
    @Column(name="value", nullable=false)
    private String value;

    @Basic(optional=false)
    @Column(name="email", nullable=false)
    private String email;
    
    @Basic(optional=true)
    @Column(name="userID")
    private int userID;

    /* (non-Javadoc)
     * @see org.apache.wookie.beans.IApiKey#getEmail()
     */
    public String getEmail()
    {
        return email;
    }

    /* (non-Javadoc)
     * @see org.apache.wookie.beans.IApiKey#setEmail(java.lang.String)
     */
    public void setEmail(String email)
    {
        this.email = email;
    }
    
    /* (non-Javadoc)
     * @see org.apache.wookie.beans.IBean#getId()
     */
    public Object getId()
    {
        return id;
    }

    /* (non-Javadoc)
     * @see org.apache.wookie.beans.IApiKey#getValue()
     */
    public String getValue()
    {
        return value;
    }

    /* (non-Javadoc)
     * @see org.apache.wookie.beans.IApiKey#setValue(java.lang.String)
     */
    public void setValue(String value)
    {
        this.value = value;
    }
    
    public int getUserId(){
    	return userID;
    }
    
    public void setUserId(int id) {
    	this.userID = id;
    }
}
