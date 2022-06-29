<%@page import="com.dao.CartDao"%>
<%@page import="com.dao.WishlistDao"%>
<%@page import="com.dao.ProductDao"%>
<%@page import="com.bean.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
   <head>
      <!-- Basic -->
      <meta charset="utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <!-- Mobile Metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
      <!-- Site Metas -->
      <meta name="keywords" content="" />
      <meta name="description" content="" />
      <meta name="author" content="" />
      <link rel="shortcut icon" href="images/O'CLOCK-logos_black (2).png" type="">
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
   <%@ include file="header.jsp" %>
   <body class="sub_page">
   
      <div class="hero_area">
               </div>
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
                  Our <span>products</span>
               </h2>
            </div>
            <div class="row">
            <%
            User u=null;
		  	if(session.getAttribute("u")!=null)
		  	{
		  		u=(User)session.getAttribute("u");
		  	}
            	Product p=ProductDao.getProductByPid(Integer.parseInt(request.getParameter("pid")));
    		    boolean wishlist_flage=WishlistDao.checkWishlist(u.getId(),Integer.parseInt(request.getParameter("pid")));
    		    boolean cart_flage=CartDao.checkCart(u.getId(),Integer.parseInt(request.getParameter("pid")));
            %>
               <div class="col-sm-6 col-md-4 col-lg-3">
                  <div class="box">
                     <div class="option_container">
                     <% 
                     
                     if(u!=null) { %>
                     
                       <div class="options">
                     	  <% if(wishlist_flage==false){ %>   
                           <a href="add_to_wishlist.jsp?pid=<%=p.getPid()%>&uid=<%=u.getId()%>" class="option1">
                           Add To Wishlist
                           </a>
                          <%} else { %>
                           <a href="remove_from_wishlist.jsp?pid=<%=p.getPid()%>&uid=<%=u.getId()%>" class="option1">
                            Remove From Wishlist
                           </a>
                          <%} %>
                           <% if(cart_flage==false){ %>   
                           <a href="add_to_cart.jsp?pid=<%=p.getPid()%>&uid=<%=u.getId()%>" class="option1">
                           Add To Cart
                           </a>
                          <%} else { %>
                           <a href="remove_from_cart.jsp?pid=<%=p.getPid()%>&uid=<%=u.getId()%>" class="option1">
                            Remove From Cart 
                           </a>
                          <%} %>
                       </div>
                     <% } else { %>
                       <div class="options">
                           <a href="login.jsp?pid=<%=p.getPid()%>" class="option1">
                           Login
                           </a>
                           <a href="" class="option2">
                           Add To Cart
                           </a>
                        </div> 
                       <% } %>  
                     </div>
                     <div class="img-box">
                        <img src="product_images/<%=p.getProduct_image() %>" alt="">
                     </div>
                     <div class="detail-box">
                        <h5>
                          Category : <%=p.getProduct_category()%>
                        </h5>
                        <h6>
                          Price : <%=p.getProduct_price()%>
                        </h6>
                     </div>
                  </div>
               </div>
            </div>
            <div class="btn-box">
               <a href="">
               View All products
               </a>
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
                     <h4>
                        Reach at..
                     </h4>
                     <div class="contact_link_box">
                        <a href="">
                        <i class="fa fa-map-marker" aria-hidden="true"></i>
                        <span>
                        Location 23-Agrawal Tower,Bhuyangdev,Ahmedabad
                        </span>
                        </a>
                        <a href="">
                        <i class="fa fa-phone" aria-hidden="true"></i>
                        <span>
                        Call +91 6352428431
                        </span>
                        </a>
                        <a href="">
                        <i class="fa fa-envelope" aria-hidden="true"></i>
                        <span>
                        dhruman0507@gmail.com
                        </span>
                        </a>
                     </div>
                  </div>
               </div>
               <div class="col-md-4 footer-col">
                  <div class="footer_detail">
                     <a href="index.jsp" class="footer-logo">
                     O'CLOCK
                     </a>
                     <p>
                        FOLLOW ON :
                     </p>
                     <div class="footer_social">
                        <a href="">
                        <i class="fa fa-facebook" aria-hidden="true"></i>
                        </a>
                        <a href="">
                        <i class="fa fa-twitter" aria-hidden="true"></i>
                        </a>
                        <a href="">
                        <i class="fa fa-linkedin" aria-hidden="true"></i>
                        </a>
                        <a href="">
                        <i class="fa fa-instagram" aria-hidden="true"></i>
                        </a>
                        <a href="">
                        <i class="fa fa-pinterest" aria-hidden="true"></i>
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
                     &copy; <span id="displayYear"></span> All Rights Reserved By O'CLOCK WATCHES    
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