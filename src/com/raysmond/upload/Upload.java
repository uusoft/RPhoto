package com.raysmond.upload;

import java.io.File;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;

public class Upload {
    private FileItem file;
    //�ļ���
    private String fileName;
    //�ļ���չ��
    private String extName;
    //����·��
    private String saveDir;
    //�ļ���С
    private long size;
    //�ļ�����
    private String type;
    
    public Upload(){
    	
    }
    public Upload(FileItem item,String saveDir){
    	this.file = item;
    	this.saveDir = saveDir;
    }
    public Upload(FileItem item,String saveDir,String fileName){
    	this.file = item;
    	this.saveDir = saveDir;
    	this.fileName = fileName;
    }
    
    public boolean upload(){
    	if (!file.isFormField()) {
            fileName = file.getName();
            long size = file.getSize();
            String type = file.getContentType();
            setType(type);
            setSize(size);
            if (fileName == null || fileName.trim().equals("")) {
            	System.out.println("�ļ�������");
            	return false;
            }
            //��չ����ʽ�� 
            if (fileName.lastIndexOf(".") >= 0) {
                extName = fileName.substring(fileName.lastIndexOf("."));
                setExtName(extName);
            }
            File file = null;
            do {
                //�����ļ�����
                fileName = UUID.randomUUID().toString();
               // setFileName(fileName);
                file = new File(saveDir + fileName + extName);
            } while (file.exists());
            File saveFile = new File(saveDir + fileName + extName);
            try {
                ((FileItem) file).write(saveFile);
            } catch (Exception e) {
            	 e.printStackTrace();
            	return false;
            }
            return true;
        }
    	System.out.println("not a form field");
    	return false;
    }
    
    //getters and setters
	public FileItem getFile() {
		return file;
	}
	public void setFile(FileItem file) {
		this.file = file;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getExtName() {
		return extName;
	}
	private void setExtName(String extName) {
		this.extName = extName;
	}
	public String getSaveDir() {
		return saveDir;
	}
	public void setSaveDir(String saveDir) {
		this.saveDir = saveDir;
	}
	public long getSize() {
		return size;
	}
	private void setSize(long size) {
		this.size = size;
	}
	public String getType() {
		return type;
	}
	private void setType(String type) {
		this.type = type;
	}
    
	
}
