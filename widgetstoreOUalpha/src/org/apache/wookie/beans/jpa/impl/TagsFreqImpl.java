package org.apache.wookie.beans.jpa.impl;

public class TagsFreqImpl {
	private int tagid;
	private String tagText;
	private int freq;
	
	public TagsFreqImpl(){}
	
	public TagsFreqImpl(Integer id , String text , int freq) {
		this.tagid = id;
		this.tagText = text;
		this.freq = freq;
	}
	
	public int getTagid() {
		return tagid;
	}
	public void setTagid(int tagid) {
		this.tagid = tagid;
	}
	public String getTagText() {
		return tagText;
	}
	public void setTagText(String tagText) {
		this.tagText = tagText;
	}
	public int getFreq() {
		return freq;
	}
	public void setFreq(int freq) {
		this.freq = freq;
	}
	
	
}
