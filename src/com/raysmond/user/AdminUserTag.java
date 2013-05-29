package com.raysmond.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Album;
import com.raysmond.bean.User;
import com.raysmond.db.dao.UserDao;
import com.raysmond.db.impl.UserDaoImpl;

public class AdminUserTag extends TagSupport{
	private static final long serialVersionUID = 2872986263247145725L;
	
	private String page;
	private String pageSize;
	
	private int _page;
	private int _pageSize;
	
	public boolean validateParam(){
		_page = _pageSize = 0;
		try{
			_page = Integer.parseInt(page);
			_pageSize = Integer.parseInt(pageSize);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		if(!validateParam()){
			try {
				out.print("<span style=\"\">请求的参数有误，未能获取用户列表！</span>");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return SKIP_BODY;
		}
		getUsers(out);
		return SKIP_BODY;
	}
	
	public void getUsers(JspWriter out){
		UserDao dao = new UserDaoImpl();
		List<User> users = dao.getUsers(_page-1, _pageSize);
		System.out.println("get users: page="+_page+ " | pageSize="+_pageSize+" | result size:" + users.size());
		try {
			if(users==null||users.size()==0){
				out.print("出错了！");
				
			}
			else{
				out.print("<div class=\"row space-bot \">");
				out.print("<table class=\"user_table\">");	
				int i=0,size = users.size();
				out.print("<tr>" 
						+"<td>用户名</td>"
						+"<td>邮箱</td>"
						+"<td>注册时间</td>"
						+"<td>最近登录时间</td>"
						+"<td>修改 | 删除</td>"
						+"</tr>");
				for(;i<size;++i){
					User user = users.get(i);
					out.print("<tr>" 
							+"<td>" + user.getName() + "</td>"
							+"<td>" + user.getMail() + "</td>"
							+"<td>" + user.getCreateTime() + "</td>"
							+"<td>" + user.getLastLoginTime() + "</td>"
							+"<td><a href=\"admin/admin_update_user.jsp?action=update_user&&uid="+user.getUid()+"\">修改</a> | "
							+"<a href=\"AdminUser?action=delete_user&&uid="+user.getUid()+"\">删除</a></td>"
							+"</tr>");
				}
				out.print("</table></div>");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getPageSize() {
		return pageSize;
	}
	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}
	
}
