package org.apache.wookie.beans.jpa.impl;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import org.apache.wookie.beans.IRating;
/**
 *
 * @author la4227
 */
@Entity
@Table(name = "rating")
@NamedQueries({
    @NamedQuery(name = "RatingImpl.findAll", query = "SELECT r FROM RatingImpl r"),
    @NamedQuery(name = "RatingImpl.findById", query = "SELECT r FROM RatingImpl r WHERE r.id = :id"),
    @NamedQuery(name = "RatingImpl.findByUserid", query = "SELECT r FROM RatingImpl r WHERE r.userid = :userid"),
    @NamedQuery(name = "RatingImpl.findByWidid", query = "SELECT r FROM RatingImpl r WHERE r.widid = :widid"),
    @NamedQuery(name = "RatingImpl.findByRate", query = "SELECT r FROM RatingImpl r WHERE r.rate = :rate")})
public class RatingImpl implements IRating {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "userid")
    private int userid;
    @Basic(optional = false)
    @Column(name = "widid")
    private int widid;
    @Basic(optional = false)
    @Column(name = "rate")
    private double rate;

    public RatingImpl() {
    }

    public RatingImpl(Integer id) {
        this.id = id;
    }

    public RatingImpl(Integer id, int userid, int widid, double rate) {
        this.id = id;
        this.userid = userid;
        this.widid = widid;
        this.rate = rate;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getWidid() {
        return widid;
    }

    public void setWidid(int widid) {
        this.widid = widid;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
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
        if (!(object instanceof RatingImpl)) {
            return false;
        }
        RatingImpl other = (RatingImpl) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.apache.wookie.beans.jpa.impl.RatingImpl[id=" + id + "]";
    }

}
