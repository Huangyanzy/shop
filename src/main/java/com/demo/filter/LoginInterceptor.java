package com.demo.filter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final String[] IGNORE_URI={"/login.jsp","/resources"};
	
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object handler) throws Exception {
		boolean flag=false;
		String url=request.getRequestURI().toString();
		//System.out.println(">>>:"+url);
		for(String s : IGNORE_URI) {
			//System.out.println(s);
			if(url.contains(s)) {
				flag=true;
				break;
			}
		}
		if(!flag) {
			HttpSession httpSession=request.getSession();
			Object obj=httpSession.getAttribute("user");
			System.out.println(obj);
			if(obj!=null) {
				//System.out.println("ok");
				flag=true;
			}else {
				//System.out.println("session为空，未登录，跳转至错误界面");
				response.sendRedirect("/MyMVCDemo/error.jsp");
			}
		}
		return flag;
	}
	
	@Override
	public void postHandle(HttpServletRequest request,HttpServletResponse response,Object handler,ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}

/*public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		//获取url地址
		String reqUrl=request.getRequestURI().replace(request.getContextPath(), "");
		System.out.println(request.getRequestURI()+" "+request.getContextPath());
		if(reqUrl.contains("/login.jsp")) {
			return false;
		}else {
			HttpSession session=request.getSession();
			Object object=session.getAttribute("user");
			if(object==null||"".equals(object.toString())) {
				System.out.println("未登陆，session为空，转向错误界面");				
				response.sendRedirect("error.jsp");
			}
		}
		return false;
	}
}*/
