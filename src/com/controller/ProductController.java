package com.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bean.Product;
import com.dao.ProductDao;


@WebServlet("/ProductController")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 512, //512MB
maxFileSize = 1024 * 1024 * 512, //512MB
maxRequestSize = 1024 * 1024 * 512) //512MB
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String extractfilename(Part file) {
	    String cd = file.getHeader("content-disposition");
	    System.out.println(cd);
	    String[] items = cd.split(";");
	    for (String string : items) {
	        if (string.trim().startsWith("filename")) {
	            return string.substring(string.indexOf("=") + 2, string.length()-1);
	        }
	    }
	    return "";
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
			
		String savePath = "C:\\Users\\dhrum\\eclipse-workspace\\O'CLOCK\\WebContent\\product_images";
        File fileSaveDir=new File(savePath);
        if(!fileSaveDir.exists()){
            fileSaveDir.mkdir();
            
	}
        String action=request.getParameter("action");
        if(action.equalsIgnoreCase("add product"))
        {
        		
        Part file = request.getPart("product_image");
	 	String fileName=extractfilename(file);
	    file.write(savePath + File.separator + fileName);
	    String filePath= savePath + File.separator + fileName ;
	    
	   
	    Product p=new Product();
	    p.setGender(request.getParameter("gender"));
	    p.setProduct_category(request.getParameter("product_category"));
	    p.setProduct_price(Integer.parseInt(request.getParameter("product_price")));
	    p.setProduct_image(fileName);
	    p.setProduct_seller(Integer.parseInt(request.getParameter("product_seller")));
	    ProductDao.addProduct(p);
	    response.sendRedirect("add_product.jsp");
        }
        else if(action.equalsIgnoreCase("edit product"))
        {
        	Product p=new Product();
    	    p.setProduct_price(Integer.parseInt(request.getParameter("product_price")));
    	    p.setPid(Integer.parseInt(request.getParameter("pid")));
    	    ProductDao.editProduct(p);
    	    response.sendRedirect("view_product.jsp");
        }
	}
}