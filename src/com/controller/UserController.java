package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bean.User;
import com.dao.UserDao;
import com.service.Services;


@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		
		if(action.equalsIgnoreCase("sign up"))
		{
			User u=new User();
			if(request.getParameter("password").equals(request.getParameter("cpassword")))
			{	
				u.setUsertype(request.getParameter("usertype"));
				u.setFname(request.getParameter("fname"));
				u.setLname(request.getParameter("lname"));
				u.setEmail(request.getParameter("email"));
				u.setAddress(request.getParameter("address"));
				u.setMobile(request.getParameter("mobile"));
				u.setPassword(request.getParameter("password"));
				u.setCpassword(request.getParameter("cpassword"));
				UserDao.signupUser(u);
				response.sendRedirect("login.jsp");
			}
			else
			{
				request.setAttribute("msg","Password and Confirm Password Is Not Matching");
				request.getRequestDispatcher("signup.jsp").forward(request, response);
				
			}
		}
		else if(action.equalsIgnoreCase("login"))
		{
			User u=UserDao.checkLogin(request.getParameter("email"),request.getParameter("password"));
			if(u==null)
			{
				request.setAttribute("msg", "Email or Password is Incorrect");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			else if(u.getUsertype().equalsIgnoreCase("user"))
			{
				HttpSession session=request.getSession();
				session.setAttribute("u",u);
				request.getRequestDispatcher("index.jsp").forward(request,response);
			}
			else if(u.getUsertype().equalsIgnoreCase("seller"))
			{
				HttpSession session=request.getSession();
				session.setAttribute("u",u);
				request.getRequestDispatcher("seller_index.jsp").forward(request,response);
			}
			
		}
		else if(action.equalsIgnoreCase("change password"))
		{
			HttpSession session=request.getSession();
			User u = (User) session.getAttribute("u");
			if(u.getPassword().equalsIgnoreCase(request.getParameter("old_password")))
			{
				if(request.getParameter("new_password").equals(request.getParameter("cnew_password")))
						{
							UserDao.change_password(u.getEmail(), request.getParameter("new_password"));
							response.sendRedirect("logout.jsp");
						}
				else{
					request.setAttribute("msg","New Password & Confirm New Password Does Not Matched!");
					request.getRequestDispatcher("change_password.jsp").forward(request, response);
				    }					
			}
			else 
			{
				request.setAttribute("msg","Old Password Is Incorrect");
				request.getRequestDispatcher("change_password.jsp").forward(request, response);
			}
		}
		else if(action.equalsIgnoreCase("send otp")) 
		{
			String email=request.getParameter("email");
			boolean flage=UserDao.checkEmail(email);
			if(flage==true)
			{
				int val =((int)(Math.random()*9000)+1000);
				System.out.println(val);
				Services.sendMail(email, val);
				request.setAttribute("otp", val);
				request.setAttribute("email",email);
				request.getRequestDispatcher("otp.jsp").forward(request, response);
			}
			else
			{
				request.setAttribute("msg", "email does not exist");
				request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
			}
		}
		else if(action.equalsIgnoreCase("verify otp"))
		{
			String email=request.getParameter("email");
			int otp=Integer.parseInt(request.getParameter("otp"));
			int uotp=Integer.parseInt(request.getParameter("uotp"));
			if(otp==uotp)
			{
				request.setAttribute("email",email);
				request.getRequestDispatcher("new_password.jsp").forward(request, response);
			}
			else
			{
				request.setAttribute("otp", otp);
				request.setAttribute("email",email );
				request.setAttribute("msg","Invalid OTP");
				request.getRequestDispatcher("otp.jsp").forward(request, response);
			}
		}
		else if(action.equalsIgnoreCase("update password"))
		{
			String email=request.getParameter("email");
			String new_password=request.getParameter("new_password");
			String cnew_password=request.getParameter("cnew_password");
			
			if(new_password.equals(cnew_password))
			{
				UserDao.change_password(email, new_password);
				request.setAttribute("msg","password updated successfully");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			else
			{
				request.setAttribute("msg", "new and confirm new password does not matched");
				request.setAttribute("email",email);
				request.getRequestDispatcher("new_password.jsp").forward(request, response);
			}
		}
	}
}

