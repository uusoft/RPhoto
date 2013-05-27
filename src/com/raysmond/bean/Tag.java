package com.raysmond.bean;

public class Tag {
	private int tid;
	private String name;
	private PhotoHasTag photoHasTag;
	
	public PhotoHasTag getPhotoHasTag() {
		return photoHasTag;
	}

	public void setPhotoHasTag(PhotoHasTag photoHasTag) {
		this.photoHasTag = photoHasTag;
	}

	public Tag(){
		
	}

	public int getTid() {
		return tid;
	}

	public void setTid(int tid) {
		this.tid = tid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
