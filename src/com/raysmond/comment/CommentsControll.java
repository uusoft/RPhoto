package com.raysmond.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.Comment;
import com.raysmond.bean.User;
import com.raysmond.db.dao.CommentDao;
import com.raysmond.db.impl.CommentDaoImpl;
import com.raysmond.util.DateUtil;

public class CommentsControll extends HttpServlet {

	private static final long serialVersionUID = -6276922068487599520L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		controll(request, response);
	}

	public void controll(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//important
		request.setCharacterEncoding("UTF-8"); 
		response.setContentType("text/html;charset=GBK");
		String action = request.getParameter("action");
		if (action == null || action.equals("")) {
			return;
		}
		if (action.equals("get_photo_comments")) {
			doGetPhotoComments(request, response);
		}
		else if(action.equals("add_photo_comment")){
			doAddComment(request,response);
		}
	}

	public void doAddComment(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		if (!isLogin(request)){
			out.print("只有登录用户才能发表评论！");
			return;
		}
		String content = request.getParameter("comment_content");
		String _photoId = request.getParameter("comment_photo_id");

		if (content == null || content.equals("") || _photoId == null
				|| _photoId.equals("")) {
			return;
		}
		System.out.println(_photoId+":"+content);
		content = content.trim();
		Comment comment = new Comment();
		comment.setContent(content);
		comment.setTitle("none");
		comment.setUid(getLoginUserId(request));
		comment.setCreateTime(DateUtil.getSystemTimestamp());
		comment.setPid(Integer.parseInt(_photoId));
		CommentDao dao = new CommentDaoImpl();
		int id = dao.insert(comment);
		
		if (id > 0) {
			//out.print("insert comment successfully.");
		}
		else{
			//out.print("insert comment failed.");
		}
	}

	public void doGetPhotoComments(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String photoId = request.getParameter("comment_photo_id");
		response.setCharacterEncoding("GBK");
		if (photoId == null || photoId.equals("")) {
			out.print("error");
			out.flush();
			out.close();
			return;
		}
		CommentDao dao = new CommentDaoImpl();
		List<Comment> comments = dao.getCommentsOfPhoto(Integer
				.parseInt(photoId));
		if (comments == null || comments.size() == 0) {
			out.print("还没有评论哦！");
		} else {
			out.print("<ul id=\"\" style=\"list-style:none;height:280px;overflow:auto;\">");
			int i = 0, size = comments.size();
			for (; i < size; ++i) {
				Comment comment = comments.get(i);
				out.print("<li class=\"list_item\" style=\"font-size:12px;clear:both;border-bottom:1px #ccc dashed;float:left;padding:5px 0;\">");
				out.print("<img style=\"border-radius:5px;width:38px;height:38px;float:left;\" src=\"images/picture.jpg\" />");
				out.print("<div class=\"comment\" style=\"width:200px;margin-left:10px;float:left;\">");
				out.print("<a class=\"username\" href=\"#\">Raysmond</a>");
				out.print(" ：" + comment.getContent()
						+ "<br/><span class=\"comment_time\">"
						+ comment.getCreateTime() + "</span>");
				out.print("");
				out.print("</div>");
				out.print("</li>");
			}
			out.print("</ul><div style=\"clear:both;\"></div>");
		}
	}

	public boolean isLogin(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		if (user == null)
			return false;
		return true;
	}

	public int getLoginUserId(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		if (user == null)
			return 0;
		return user.getUid();
	}
}
