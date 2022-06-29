package com.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bean.Cart;
import com.dao.CartDao;


@WebServlet("/CartController")
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cid=Integer.parseInt(request.getParameter("cid"));
		int qty=Integer.parseInt(request.getParameter("qty"));
		Cart c=CartDao.getCartByCid(cid);
		int total_price=c.getProduct_price()*qty;
		CartDao.updateCart(cid, total_price, qty);
		response.sendRedirect("cart.jsp");	
	}

}
