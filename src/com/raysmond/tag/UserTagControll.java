package com.raysmond.tag;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.Album;
import com.raysmond.bean.Photo;
import com.raysmond.bean.PhotoHasTag;
import com.raysmond.bean.Tag;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.dao.PhotoHasTagDao;
import com.raysmond.db.dao.TagDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.db.impl.PhotoDaoImpl;
import com.raysmond.db.impl.PhotoHasTagDaoImpl;
import com.raysmond.db.impl.TagDaoImpl;

public class UserTagControll extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		controll(request, response);
	}

	public void controll(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=GBK");
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		if (action == null || action.equals("")) {
			out.print("no action.");
			out.flush();
			out.close();
			return;
		}
		if (action.equals("add_tag")) {
			doAddTag(request, response);
		} else if (action.equals("get_photo_tag_list")) {
			doGetTagList(request, response);
		} else if (action.equals("get_tag_cloud")) {
			doGetTagCloud(request, response);
		}
	}

	public void doGetTagCloud(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String count = request.getParameter("count");
		if (count == null || count.equals("")) {
			out.print("null");
			out.flush();
			out.close();
			return;
		}
		TagDao dao = new TagDaoImpl();
		List<Tag> tags = dao.getAllTags(Integer.parseInt(count),true);
		if (tags == null || tags.size() == 0) {
			out.print("还没有标签哦！");
			out.flush();
			out.close();
			return;
		}
		String[] classes = { "red", "blue", "green", "default", "" };
		Iterator<Tag> iter = tags.iterator();
		while (iter.hasNext()) {
			Tag tag = iter.next();
			out.println("<a class=\"tag-item "
					+ (classes[(int) (Math.random() * 4)]) + "\" href=\""
					+ request.getContextPath() + "/tag.jsp?tag="
					+ tag.getName() + "\" >" + tag.getName() + "</a>");
		}
		out.flush();
		out.close();
	}

	public void doGetTagList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String path = request.getContextPath();
		String photoId = request.getParameter("photo_id");
		System.out.println("get tag list of photo: " + photoId);
		if (photoId == null || photoId.equals("")) {
			out.print("null");
			out.flush();
			out.close();
			return;
		}
		TagDao dao = new TagDaoImpl();
		List<Tag> tags = dao.getTagsByPhotoId(Integer.parseInt(photoId));
		if (tags == null || tags.size() == 0) {
			out.print("还没有标签哦！");
			out.flush();
			out.close();
			return;
		}
		Iterator<Tag> iter = tags.iterator();
		while (iter.hasNext()) {
			Tag tag = iter.next();
			out.print("<a class=\"tag-item\" href=\"" + path + "/tag.jsp?tag="
					+ tag.getName() + "\">" + tag.getName() + "</a>");
		}
		out.flush();
		out.close();
	}

	public boolean isPhotoBelongToLoginUser(HttpServletRequest request,
			int photoId) {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		if (user == null)
			return false;

		PhotoDao dao = new PhotoDaoImpl();
		Photo photo = dao.getPhotoById(photoId);
		if (photo == null || photo.getPid() <= 0)
			return false;

		int albumId = photo.getAid();
		AlbumDao adao = new AlbumDaoImpl();
		Album album = adao.getAlbumById(albumId);
		if (album.getUid() == user.getUid())
			return true;
		return false;
	}

	public void doAddTag(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		String name = request.getParameter("tag_name");
		String photoId = request.getParameter("photo_id");
		System.out.println(name + ":" + photoId);
		if (name == null || name.equals("") || photoId == null
				|| photoId.equals("")) {
			out.print("Add tag failed.");
			out.flush();
			out.close();
			return;
		}
		if (!isPhotoBelongToLoginUser(request, Integer.parseInt(photoId))) {
			// 照片不属于登录用户，不能进行添加标签
			out.print("Add tag failed.");
			out.flush();
			out.close();
			return;
		}
		TagDao tagDao = new TagDaoImpl();
		PhotoHasTagDao phtDao = new PhotoHasTagDaoImpl();
		Tag tag = tagDao.getTagByName(name);
		if (tag.getTid() > 0) {
			// tag already exists
			System.out.println("tag \"" + name + "\" already exists");
			if (phtDao.checkPhotoHasTag(name,Integer.parseInt(photoId))) {
				// the photo already had the tag
				System.out.println("the photo already had the tag: " + name);
				out.print("该照片已经有这个标签了！");
				out.flush();
				out.close();
				return;
			}
		} else {
			tag.setName(name);
			tagDao.insert(tag);
		}

		if (tag.getTid() > 0) {
			// add tag entry successfully.
			PhotoHasTag pht = new PhotoHasTag();
			pht.setPid(Integer.parseInt(photoId));
			pht.setTid(tag.getTid());
			int result = phtDao.insert(pht);
			if (result > 0) {
				// add tag to photo successfully.
				out.print("add tag \"" + name + "\" to photo successfully.");
			} else {
				out.print("add tag \"" + name + "\" to photo failed.");
			}
		} else {
			out.print("add tag \"" + name + "\" failed.");
		}
		out.flush();
		out.close();
	}

}
