package org.apache.wookie.beans.jpa.impl;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.wookie.beans.IApikeyWidget;

@Entity(name="ApiKeyWidget")
@Table(name="apikeywidgets")
public class ApikeyWidgetImpl implements IApikeyWidget{
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name="id", nullable=false)	
    private Integer id;
	
	@Column(name="ApiKey", nullable=false)
    private int apiKey;
	
	@Column(name="widgetId", nullable=false)
    private int widgetid;
	
	public ApikeyWidgetImpl(){}
	
	public ApikeyWidgetImpl(int api,int wid){
		this.apiKey = api;
		this.widgetid = wid;
	}
	public Integer getId(){
		return id;
	}
	
	public int getAPIkeyID(){
		return apiKey;
	}
	
	public int getWidgetId(){
		return widgetid;
	}
	
	public void setAPIkeyID(int APIkey){
		this.apiKey = APIkey;
	}
	
	public void setWidgetId(int widgetID){
		this.widgetid = widgetID;
	}
	@Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ApikeyWidgetImpl)) {
            return false;
        }
        ApikeyWidgetImpl other = (ApikeyWidgetImpl) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.apache.wookie.beans.jpa.impl.ApikeyWidgetImpl";//[id=" + id + "]";
    }
	
}
