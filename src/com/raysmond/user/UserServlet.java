package com.raysmond.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.User;
import com.raysmond.db.dao.UserDao;
import com.raysmond.db.impl.UserDaoImpl;
import com.raysmond.util.DateUtil;

public class UserServlet extends HttpServlet {

	private static final long serialVersionUID = -949966829714908681L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		request.setCharacterEncoding("GBK");
		doAuth(request,response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		request.setCharacterEncoding("GBK");
		doAuth(request,response);
	}
	
	public void doAuth(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action==null||action.equals("")){
			response.sendRedirect("login.jsp");
			return;
		}
		if(action.equalsIgnoreCase("login")){
			doLogin(request,response);
		}
		else if(action.equalsIgnoreCase("register")){
			doRegister(request,response);
		}
		else if(action.equalsIgnoreCase("logout")){
			doLogout(request,response);
		}
		else{
			response.sendRedirect("login.jsp");
		}
	}
	
	public void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(username==null||username.equalsIgnoreCase("")||
				password==null||password.equalsIgnoreCase("")){
			String des = "login.jsp?error=User name and password cannot be blank.";
			des = new String(des.getBytes("GBK"),"ISO-8859-1");
			response.sendRedirect(des);
			return;
		}
		UserDao dao = new UserDaoImpl();
		List<User> users = dao.find("name", username);
		if(users==null||users.size()==0){
			String des = "login.jsp?error=User not exists.";
			des = new String(des.getBytes("GBK"),"ISO-8859-1");
			response.sendRedirect(des);
			return;
		}
		User user = users.get(0);
		if(user.getPassword().equals(password)){ 
			//用户输入的密码和实际密码一致，登录成功
			HttpSession session = request.getSession(true);
			user.setLastLoginTime(DateUtil.getSystemTimestamp());
			dao.update(user);
			session.setAttribute("AUTH_USER", user);
			response.sendRedirect("album.jsp?uid="+user.getUid());
			return;
		}
		else{
			String des = "login.jsp?error=Password error!";
			des = new String(des.getBytes("GBK"),"ISO-8859-1");
			response.sendRedirect(des);
			return;
		}
	}
	
	public void doRegister(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("password_confirm");
		String email = request.getParameter("email");
		if(username==null||username.equalsIgnoreCase("")||
				password==null||password.equalsIgnoreCase("")||
				email==null||email.equals("")||
				passwordConfirm==null||passwordConfirm.equals("")){
			String des = "register.jsp?error=Username and password cannot be blank.";
			des = new String(des.getBytes("GBK"),"ISO-8859-1");
			response.sendRedirect(des);
			return;
		}
		if(!password.equals(passwordConfirm)){
			String des = "register.jsp?error=两次输入密码不一致！";
			des = new String(des.getBytes("GBK"),"ISO-8859-1");
			response.sendRedirect(des);
			return;
		}
		User user = new User();
		user.setName(username);
		user.setPassword(password);
		user.setMail(email);
		user.setPicture("images/default_picture.jpg"); //使用默认头像
		user.setStatus(1); //默认有效
		user.setRid(1);    //默认角色为普通用户
		Timestamp currentTime = DateUtil.getSystemTimestamp();
		user.setCreateTime(currentTime);
		user.setLastLoginTime(new Timestamp(0));
		UserDao dao = new UserDaoImpl();
		int userId = dao.insert(user);
		if(userId>0){  //注册成功，userId为注册成功后的用户id
			String des = "login.jsp?message=Register successfully.";
			des = new String(des.getBytes("GBK"),"ISO-8859-1");
			response.sendRedirect(des);
			return;
		}
		else{
			String des = "register.jsp?error=Register failed.";
			des = new String(des.getBytes("GBK"),"ISO-8859-1");
			response.sendRedirect(des);
			return;
		}
	}
	
	public void doLogout(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		session.removeAttribute("AUTH_USER");
		String des = "index.jsp?error=You have logout successfully. Thanks!";
		response.sendRedirect(new String(des.getBytes("GBK"),"ISO-8859-1"));
	}
}
