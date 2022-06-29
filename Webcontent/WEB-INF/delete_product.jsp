<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.bean.Product"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	ProductDao.deleteProduct(Integer.parseInt(request.getParameter("pid")));
	response.sendRedirect("view_product.jsp");
%>
</body>
</html>