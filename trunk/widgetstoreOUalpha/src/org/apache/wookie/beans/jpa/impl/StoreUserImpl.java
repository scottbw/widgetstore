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

import org.apache.wookie.beans.IStoreUser;

/**
 *
 * @author la4227
 */
@Entity
@Table(name = "storeusers")
@NamedQueries({
    @NamedQuery(name = "StoreUserImpl.findAll", query = "SELECT s FROM StoreUserImpl s"),
    @NamedQuery(name = "StoreUserImpl.findById", query = "SELECT s FROM StoreUserImpl s WHERE s.id = :id"),
    @NamedQuery(name = "StoreUserImpl.findByFullname", query = "SELECT s FROM StoreUserImpl s WHERE s.fullname = :fullname"),
    @NamedQuery(name = "StoreUserImpl.findByUsername", query = "SELECT s FROM StoreUserImpl s WHERE s.username = :username"),
    @NamedQuery(name = "StoreUserImpl.findByPassword", query = "SELECT s FROM StoreUserImpl s WHERE s.password = :password"),
    @NamedQuery(name = "StoreUserImpl.findBySalt", query = "SELECT s FROM StoreUserImpl s WHERE s.salt = :salt"),
    @NamedQuery(name = "StoreUserImpl.findByEmail", query = "SELECT s FROM StoreUserImpl s WHERE s.email = :email"),
    @NamedQuery(name = "StoreUserImpl.findByHashedUserNameWS", query = "SELECT s FROM StoreUserImpl s WHERE s.hashedUserNameWS = :hashedUserNameWS")})

    public class StoreUserImpl implements IStoreUser {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "fullname")
    private String fullname;
    @Basic(optional = false)
    @Column(name = "username")
    private String username;
    @Basic(optional = false)
    @Column(name = "password")
    private String password;
    @Basic(optional = false)
    @Column(name = "salt")
    private String salt;
    @Basic(optional = false)
    @Column(name = "email")
    private String email;
    @Basic(optional = false)
    @Column(name = "hashedUserNameWS")
    private String hashedUserNameWS;

    public StoreUserImpl() {
    }

    public StoreUserImpl(Integer id) {
        this.id = id;
    }

    public StoreUserImpl(Integer id, String fullname, String username, String password, String salt, String email, String hashedUserNameWS) {
        this.id = id;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.salt = salt;
        this.email = email;
        this.hashedUserNameWS = hashedUserNameWS;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHashedUserNameWS() {
        return hashedUserNameWS;
    }

    public void setHashedUserNameWS(String hashedUserNameWS) {
        this.hashedUserNameWS = hashedUserNameWS;
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
        if (!(object instanceof StoreUserImpl)) {
            return false;
        }
        StoreUserImpl other = (StoreUserImpl) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.apache.wookie.beans.jpa.impl.StoreUserImpl[id=" + id + "]";
    }

}
