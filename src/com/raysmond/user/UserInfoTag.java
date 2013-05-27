package com.raysmond.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.User;
import com.raysmond.db.dao.UserDao;
import com.raysmond.db.impl.UserDaoImpl;

public class UserInfoTag extends TagSupport{

	private static final long serialVersionUID = -8060259001023585283L;
	private UserDao dao = new UserDaoImpl();
	private String userId = "null";
	public String getUserId(){
		return userId;
	}
	
	public void setUserId(String userId){
		this.userId = userId;
	}
	
	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		getUserInfo(out);
		return SKIP_BODY;
	}
	
	public void getUserInfo(JspWriter out){
		if(!isLogin()){
			outputLoginRegisterHtml();
			return;
		}
		List<User> users = dao.find("uid", userId);
		if(users==null||users.size()==0){
			return;
		}
		User user = users.get(0);
		try {
			StringBuffer buffer = new StringBuffer(1024);
			buffer.append("<div class=\"user_info_wrapper\">");
			buffer.append("<img src=\""+user.getPicture() +"\"  />");
			buffer.append("<div class=\"username\">"
					+ user.getName()
					+ "<a class=\"link\" href=\"userAuth?action=logout\">ÍË³ö</a>"
					+ "</div>");
			buffer.append("</div>");
			out.print(buffer.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void outputLoginRegisterHtml(){
		StringBuffer html = new StringBuffer(256);
		html.append("<div class=\"user_info_wrapper\" style=\"margin-top:20px;\">");
		html.append("<a class=\"link\"  href=\"login.jsp\">µÇÂ¼</a>");
		html.append("<a class=\"link\"  href=\"register.jsp\">×¢²á</a>");
		html.append("</div>");
		try {
			pageContext.getOut().print(html.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public boolean isLogin(){
		User user = (User) pageContext.getSession().getAttribute("AUTH_USER");
		if(user==null) return false;
		return true;
	}
}
