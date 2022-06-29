
<%@page import="java.util.Random"%>
<%@page import="com.bean.Cart"%>
<%@page import="com.dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.bean.Product"%>
<%@page import="com.dao.UserDao"%>
<%@page import="java.util.List"%>
<%
 	Random randomGenerator = new Random();
	int randomInt = randomGenerator.nextInt(1000000);
 %>
<html>
<head>
<!-- Basic -->
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<!-- Mobile Metas -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<!-- Site Metas -->
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="author" content="" />
<link rel="shortcut icon" href="images/O'CLOCK-logos_black (2).png"
	type="">
<title>O'CLOCK WATCHES</title>
<!-- bootstrap core css -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<!-- font awesome style -->
<link href="css/font-awesome.min.css" rel="stylesheet" />
<!-- Custom styles for this template -->
<link href="css/style.css" rel="stylesheet" />
<!-- responsive style -->
<link href="css/responsive.css" rel="stylesheet" />
</head>
<body class="sub_page">
	<div class="hero_area"></div>
	<!-- inner page section -->
	<section class="inner_page_head">
		<div class="container_fuild">
			<div class="row">
				<div class="col-md-12">
					<div class="full">
						<h3>Product Grid</h3>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- end inner page section -->
	<!-- product section -->
	<section class="product_section layout_padding">
		<div class="container">
			<div class="heading_container heading_center">
				<h2>
					Cart <span>Products</span>
				</h2>
			</div>
			<div class="row">
				<%
            User u=null;
		  	if(session.getAttribute("u")!=null)
		  	{
		  		u=(User)session.getAttribute("u");
		  	}
		  	int net_price = 0;
            	List<Cart> list=CartDao.getCartByUser(u.getId());
    		  	if(list.size()!=0)
    		  	{
    		  	for(Cart c :list)
    		  	{
    		  		net_price = net_price+c.getTotal_price();
    		  		Product p=ProductDao.getProductByPid(c.getPid());
            %>
				<div class="col-sm-6 col-md-4 col-lg-3">
					<div class="box">
						<div class="option_container">
							<div class="options">
								<a href="user_product_detail.jsp?pid=<%=c.getPid()%>"
									class="option1"> Product Details </a>
							</div>
						</div>
						<div class="img-box">
							<img src="product_images/<%=p.getProduct_image() %>" alt="">
						</div>
						<div class="detail-box">
							<h5>
								Category :
								<%=p.getProduct_category()%>
							</h5>
						</div>
						<div class="detail-box">
							<h6>
								Price :
								<%=p.getProduct_price()%>
							</h6>
						</div>
						<div class="detail-box">

							<form name="change_qty" method="post" action="CartController">
								<input type="hidden" name="cid" value="<%=c.getCid() %>">
								Quantity : <input type="number" name="qty"
									value="<%=c.getQty()%>" min="1" max="10"
									onchange="this.form.submit()">

							</form>

						</div>
						<div class="detail-box">
							<h5>
								Total Price :
								<%=c.getProduct_price()%>
							</h5>
						</div>
					</div>
				</div>
				<%
    		  		} 
    		  	%>
				<div class="col-sm-6 col-md-6 col-lg-6">
					<div class="box">

						<div class="img-box">
							<a href="" class="option1"> <img src="" alt="">
							</a>
						</div>
						<div class="detail-box">
							<h5></h5>
						</div>
						<div class="detail-box">
							<h6></h6>
						</div>
						<div class="detail-box">
							<h5>
								Net Price =
								<%=net_price %>
							</h5>
						</div>
						<div class="detail-box">

							<%-- <form name="change_qty" method="post" action="pgRedirect.jsp">
								<input type="text" name="TXN_AMOUNT" value="<%=net_price%>">
								<input id="ORDER_ID" name="ORDER_ID" autocomplete="off" value="ORDS_<%= randomInt %>">
								<input id="CUST_ID" tabindex="2" maxlength="30" size="12" name="CUST_ID" autocomplete="off" value="CUST001">
								<input id="INDUSTRY_TYPE_ID" tabindex="4" maxlength="12" size="12" name="INDUSTRY_TYPE_ID" autocomplete="off" value="Retail">
								<input id="CHANNEL_ID" tabindex="4" maxlength="12" size="12" name="CHANNEL_ID" autocomplete="off" value="WEB">
								<input type="submit" name="action" value="CheckOut">
							</form> --%>
						

							<form method="post" action="pgRedirect.jsp">
								<table border="1">
									<tbody>
										<tr>
											<th>S.No</th>
											<th>Label</th>
											<th>Value</th>
										</tr>
										<tr>
											<td>1</td>
											<td><label>ORDER_ID::*</label></td>
											<td><input id="ORDER_ID" tabindex="1" maxlength="20"
												size="20" name="ORDER_ID" autocomplete="off"
												value="ORDS_<%= randomInt %>"></td>
										</tr>
										<tr>
											<td>2</td>
											<td><label>CUSTID ::*</label></td>
											<td><input id="CUST_ID" tabindex="2" maxlength="30"
												size="12" name="CUST_ID" autocomplete="off" value="CUST001"></td>
										</tr>
										<tr>
											<td>3</td>
											<td><label>INDUSTRY_TYPE_ID ::*</label></td>
											<td><input id="INDUSTRY_TYPE_ID" tabindex="4"
												maxlength="12" size="12" name="INDUSTRY_TYPE_ID"
												autocomplete="off" value="Retail"></td>
										</tr>
										<tr>
											<td>4</td>
											<td><label>Channel ::*</label></td>
											<td><input id="CHANNEL_ID" tabindex="4" maxlength="12"
												size="12" name="CHANNEL_ID" autocomplete="off" value="WEB">
											</td>
										</tr>
										<tr>
											<td>5</td>
											<td><label>txnAmount*</label></td>
											<td><input title="TXN_AMOUNT" tabindex="10" type="text"
												name="TXN_AMOUNT" value="<%=net_price%>"></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td><input value="CheckOut" type="submit" onclick=""></td>
										</tr>
									</tbody>
								</table>
								* - Mandatory Fields
							</form>
						</div>
					</div>
				</div>
				<%
    		  	}
    		  	else
    		  	{
               %>
				<h3 style="text-align: center;">Cart Is Empty</h3>
				<%} %>
			</div>
			<div class="btn-box">
				<a href=""> View All products </a>
			</div>
		</div>
	</section>
	<!-- end product section -->
	<!-- footer section -->
	<footer class="footer_section">
		<div class="container">
			<div class="row">
				<div class="col-md-4 footer-col">
					<div class="footer_contact">
						<h4>Reach at..</h4>
						<div class="contact_link_box">
							<a href=""> <i class="fa fa-map-marker" aria-hidden="true"></i>
								<span> Location 23-Agrawal Tower,Bhuyangdev,Ahmedabad </span>
							</a> <a href=""> <i class="fa fa-phone" aria-hidden="true"></i> <span>
									Call +91 6352428431 </span>
							</a> <a href=""> <i class="fa fa-envelope" aria-hidden="true"></i>
								<span> dhruman0507@gmail.com </span>
							</a>
						</div>
					</div>
				</div>
				<div class="col-md-4 footer-col">
					<div class="footer_detail">
						<a href="index.jsp" class="footer-logo"> O'CLOCK </a>
						<p>FOLLOW ON :</p>
						<div class="footer_social">
							<a href=""> <i class="fa fa-facebook" aria-hidden="true"></i>
							</a> <a href=""> <i class="fa fa-twitter" aria-hidden="true"></i>
							</a> <a href=""> <i class="fa fa-linkedin" aria-hidden="true"></i>
							</a> <a href=""> <i class="fa fa-instagram" aria-hidden="true"></i>
							</a> <a href=""> <i class="fa fa-pinterest" aria-hidden="true"></i>
							</a>
						</div>
					</div>
				</div>
				<div class="col-md-4 footer-col">
					<div class="map_container">
						<div class="map">
							<div id="googleMap"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="footer-info">
				<div class="col-lg-7 mx-auto px-0">
					<p>
						&copy; <span id="displayYear"></span> All Rights Reserved By
						O'CLOCK WATCHES
					</p>
				</div>
			</div>
		</div>
	</footer>
	<!-- footer section -->
	<!-- jQery -->
	<script src="js/jquery-3.4.1.min.js"></script>
	<!-- popper js -->
	<script src="js/popper.min.js"></script>
	<!-- bootstrap js -->
	<script src="js/bootstrap.js"></script>
	<!-- custom js -->
	<script src="js/custom.js"></script>
</body>
</html>