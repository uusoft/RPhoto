package com.raysmond.user;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.User;
import com.raysmond.db.dao.UserDao;
import com.raysmond.db.impl.UserDaoImpl;

/**
 * Servlet Filter implementation class AdminLoginFilter
 */
@WebFilter("/AdminLoginFilter")
public class AdminLoginFilter implements Filter {
	UserDao dao = new UserDaoImpl();
	
    /**
     * Default constructor. 
     */
    public AdminLoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        res.setCharacterEncoding("GBK");
        response.setContentType("text/html;charset=GBK");
        HttpSession session = req.getSession(true);
        User user = (User) session.getAttribute("AUTH_USER");
       // System.out.println(user);
        if(user==null){
        	String msg = new String("对不起，请先登录！".getBytes(),"ISO-8859-1");
        	res.sendRedirect(req.getContextPath() + "/login.jsp?error="+msg);
        }
        else if(user.getRid()!=1){ //not admin
        	String msg = new String("对不起，你请求的页面需要管理员权限！".getBytes(),"ISO-8859-1");
        	res.sendRedirect(req.getContextPath() + "/index.jsp?error="+msg);
        }
        else{
        	// pass the request along the filter chain
    		chain.doFilter(request, response);
        }
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}

