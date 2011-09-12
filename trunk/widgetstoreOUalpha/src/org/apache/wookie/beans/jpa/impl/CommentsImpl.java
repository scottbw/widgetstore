package org.apache.wookie.beans.jpa.impl;

import java.sql.Timestamp;
import java.util.Date;

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

import org.apache.wookie.beans.IComments;

/**
 *
 * @author la4227
 */
@Entity
@Table(name = "comments")
@NamedQueries({
    @NamedQuery(name = "CommentsImpl.findAll", query = "SELECT c FROM CommentsImpl c"),
    @NamedQuery(name = "CommentsImpl.findById", query = "SELECT c FROM CommentsImpl c WHERE c.id = :id"),
    @NamedQuery(name = "CommentsImpl.findByWidid", query = "SELECT c FROM CommentsImpl c WHERE c.widid = :widid"),
    @NamedQuery(name = "CommentsImpl.findByUserid", query = "SELECT c FROM CommentsImpl c WHERE c.userid = :userid"),
    @NamedQuery(name = "CommentsImpl.findByCommentext", query = "SELECT c FROM CommentsImpl c WHERE c.commentext = :commentext")})
public class CommentsImpl implements IComments {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "widid")
    private int widid;
    @Basic(optional = false)
    @Column(name = "userid")
    private int userid;
    @Basic(optional = false)
    @Column(name = "commentext")
    private String commentext;
    @Basic(optional = false)
    @Column(name = "creationDate")
    private Timestamp creationDate;   
    

    public CommentsImpl() {
    }

    public CommentsImpl(Integer id) {
        this.id = id;
    }

    public CommentsImpl(int widid, int userid, String commentext) {
        this.widid = widid;
        this.userid = userid;
        this.commentext = commentext;
        this.creationDate = new Timestamp(System.currentTimeMillis());
    }
    
    public CommentsImpl(Integer id, int widid, int userid, String commentext) {
        this.id = id;
        this.widid = widid;
        this.userid = userid;
        this.commentext = commentext;
        this.creationDate = new Timestamp(System.currentTimeMillis());
    }
    
    public CommentsImpl(Integer id, int widid, int userid, String commentext, Timestamp creationDate) {
        this.id = id;
        this.widid = widid;
        this.userid = userid;
        this.commentext = commentext;
        this.creationDate = creationDate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getWidid() {
        return widid;
    }

    public void setWidid(int widid) {
        this.widid = widid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getCommentext() {
        return commentext;
    }

    public void setCommentext(String commentext) {
        this.commentext = commentext;
    }

    public Timestamp getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Timestamp creationDate) {
        this.creationDate = creationDate;
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
        if (!(object instanceof CommentsImpl)) {
            return false;
        }
        CommentsImpl other = (CommentsImpl) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.apache.wookie.beans.jpa.impl.CommentsImpl";//[id=" + id + "]";
    }

}
