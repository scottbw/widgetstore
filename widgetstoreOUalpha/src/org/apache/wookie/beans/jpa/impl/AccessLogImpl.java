package org.apache.wookie.beans.jpa.impl;

import java.io.Serializable;
import java.sql.Timestamp;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.wookie.beans.IAccessLog;

/**
 *
 * @author la4227
 */
@Entity
@Table(name = "accesslog")
@NamedQueries({
    @NamedQuery(name = "AccessLogImpl.findAll", query = "SELECT a FROM AccessLogImpl a"),
    @NamedQuery(name = "AccessLogImpl.findById", query = "SELECT a FROM AccessLogImpl a WHERE a.id = :id"),
    @NamedQuery(name = "AccessLogImpl.findByWidgetId", query = "SELECT a FROM AccessLogImpl a WHERE a.widgetId = :widgetId"),
    @NamedQuery(name = "AccessLogImpl.findByUserId", query = "SELECT a FROM AccessLogImpl a WHERE a.userId = :userId"),
    @NamedQuery(name = "AccessLogImpl.findByAccessTime", query = "SELECT a FROM AccessLogImpl a WHERE a.accessTime = :accessTime")})
public class AccessLogImpl implements IAccessLog {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "widgetId")
    private int widgetId;
    @Basic(optional = false)
    @Column(name = "userId")
    private int userId;
    
    @Basic(optional = false)
    @Column(name = "containerUser")
    private String containerUser;
    
    @Basic(optional = false)
    @Column(name = "ApiKeyId")
    private int ApiKeyId;
    
    @Basic(optional = false)
    @Column(name = "accessTime")
    @Temporal(TemporalType.TIMESTAMP)
    private Timestamp accessTime;

    public AccessLogImpl() {
    }

    public AccessLogImpl(Integer id) {
        this.id = id;
    }

    public AccessLogImpl(int widgetId, int userId , int ApiKeyId , String user) {
        this.widgetId = widgetId;
        this.userId = userId;
        this.ApiKeyId = ApiKeyId;
        this.containerUser = user;
        this.accessTime = new Timestamp(System.currentTimeMillis());
    }
    
    public AccessLogImpl(Integer id, int widgetId, int userId , int ApiKeyId , String user) {
        this.id = id;
        this.widgetId = widgetId;
        this.userId = userId;
        this.ApiKeyId = ApiKeyId;
        this.containerUser = user;
        this.accessTime = new Timestamp(System.currentTimeMillis());
    }
    
    public AccessLogImpl(Integer id, int widgetId, int userId, int ApiKeyId , String user , Timestamp accessTime) {
        this.id = id;
        this.widgetId = widgetId;
        this.userId = userId;
        this.ApiKeyId = ApiKeyId;
        this.containerUser = user;
        this.accessTime = accessTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getWidgetId() {
        return widgetId;
    }

    public void setWidgetId(int widgetId) {
        this.widgetId = widgetId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getAccessTime() {
        return accessTime;
    }

    public void setAccessTime(Timestamp accessTime) {
        this.accessTime = accessTime;
    }
    
    public String getContainerUser(){
    	return containerUser;
    }
    
    public void setContainerUser(String user){
    	this.containerUser = user;
    }

    public int getApiKeyId(){
    	return ApiKeyId;
    }
    
    public void setApiKeyId(int Apikey){
    	this.ApiKeyId = Apikey;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AccessLogImpl)) {
            return false;
        }
        AccessLogImpl other = (AccessLogImpl) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.apache.wookie.beans.jpa.impl.AccessLogImpl";//[id=" + id + "]";
    }

}
