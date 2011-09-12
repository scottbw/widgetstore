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

import org.apache.wookie.beans.ITagsWidgets;

/**
 *
 * @author la4227
 */
@Entity
@Table(name = "tagswidgets")
@NamedQueries({
    @NamedQuery(name = "TagsWidgetsImpl.findAll", query = "SELECT t FROM TagsWidgetsImpl t"),
    @NamedQuery(name = "TagsWidgetsImpl.findById", query = "SELECT t FROM TagsWidgetsImpl t WHERE t.id = :id"),
    @NamedQuery(name = "TagsWidgetsImpl.findByTagid", query = "SELECT t FROM TagsWidgetsImpl t WHERE t.tagid = :tagid"),
    @NamedQuery(name = "TagsWidgetsImpl.findByWidid", query = "SELECT t FROM TagsWidgetsImpl t WHERE t.widid = :widid")})
public class TagsWidgetsImpl implements ITagsWidgets {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "tagid")
    private int tagid;
    @Basic(optional = false)
    @Column(name = "widid")
    private int widid;

    public TagsWidgetsImpl() {
    }

    public TagsWidgetsImpl(Integer id) {
        this.id = id;
    }

    public TagsWidgetsImpl(Integer id, int tagid, int widid) {
        this.id = id;
        this.tagid = tagid;
        this.widid = widid;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getTagid() {
        return tagid;
    }

    public void setTagid(int tagid) {
        this.tagid = tagid;
    }

    public int getWidid() {
        return widid;
    }

    public void setWidid(int widid) {
        this.widid = widid;
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
        if (!(object instanceof TagsWidgetsImpl)) {
            return false;
        }
        TagsWidgetsImpl other = (TagsWidgetsImpl) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "org.apache.wookie.beans.jpa.impl.TagsWidgetsImpl";//[id=" + id + "]";
    }

}
