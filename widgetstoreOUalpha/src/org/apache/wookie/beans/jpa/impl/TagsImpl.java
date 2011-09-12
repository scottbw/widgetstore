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

import org.apache.wookie.beans.ITags;

@Entity
@Table(name = "tags")
@NamedQueries({
    @NamedQuery(name = "TagsImpl.findAll", query = "SELECT t FROM TagsImpl t"),
    @NamedQuery(name = "TagsImpl.findById", query = "SELECT t FROM TagsImpl t WHERE t.id = :id"),
    @NamedQuery(name = "TagsImpl.findByTagtext", query = "SELECT t FROM TagsImpl t WHERE t.tagtext = :tagtext"),
    @NamedQuery(name = "TagsImpl.findLike", query = "SELECT t FROM TagsImpl t WHERE t.tagtext LIKE :tagtext ESCAPE :esc")})    
public class TagsImpl implements ITags {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "tagtext")
    private String tagtext;

    public TagsImpl() {
    }

    public TagsImpl(Integer id) {
        this.id = id;
    }

    public TagsImpl(Integer id, String tagtext) {
        this.id = id;
        this.tagtext = tagtext;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTagtext() {
        return tagtext;
    }

    public void setTagText(String tagtext) {
        this.tagtext = tagtext;
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
        if (!(object instanceof TagsImpl)) {
            return false;
        }
        TagsImpl other = (TagsImpl) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

}