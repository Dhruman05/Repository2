package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.bean.Product;
import com.util.UserUtil;

public class ProductDao {

	public static void addProduct(Product p)
	{
		try {
			Connection conn=UserUtil.createConnection();
			String sql="insert into product (gender,product_category,product_price,product_image,product_seller) value(?,?,?,?,?)";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setString(1,p.getGender());
			pst.setString(2,p.getProduct_category());
			pst.setInt(3,p.getProduct_price());
			pst.setString(4,p.getProduct_image());
			pst.setInt(5,p.getProduct_seller());
			pst.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	public static List<Product> getAllProductBySeller(int product_seller)
	{
		List<Product> list=new ArrayList<Product>();
		try {
		Connection conn=UserUtil.createConnection();
		String sql="select * from product where product_seller=?";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1,product_seller);
		ResultSet rs=pst.executeQuery();
		while(rs.next())
		{
			Product p =new Product();
			p.setPid(rs.getInt("pid"));
			p.setProduct_category(rs.getString("product_category"));
			p.setGender(rs.getString("gender"));
			p.setProduct_price(rs.getInt("product_price"));
			p.setProduct_image(rs.getString("product_image"));
			p.setProduct_seller(rs.getInt("product_seller"));
			list.add(p);
			
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public static Product getProductByPid(int pid)
	{
		Product p=null;
		try {
		Connection conn=UserUtil.createConnection();
		String sql="select * from product where pid=?";
		PreparedStatement pst = conn.prepareStatement(sql);
		pst.setInt(1,pid);
		ResultSet rs=pst.executeQuery();
		if(rs.next())
		{
			p =new Product();
			p.setPid(rs.getInt("pid"));
			p.setProduct_category(rs.getString("product_category"));
			p.setGender(rs.getString("gender"));
			p.setProduct_price(rs.getInt("product_price"));
			p.setProduct_image(rs.getString("product_image"));
			p.setProduct_seller(rs.getInt("product_seller"));
			
			
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return p;
	}
	public static void editProduct(Product p)
	{
		try {
			Connection conn=UserUtil.createConnection();
			String sql="update product set product_price=? where pid=?";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1,p.getProduct_price());
			pst.setInt(2,p.getPid());		
			pst.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	public static void deleteProduct(int pid)
	{
		try {
			Connection conn=UserUtil.createConnection();
			String sql="delete from  product where pid=?";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1, pid);
			pst.executeUpdate();
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	public static List<Product> getAllProduct()
	{
		List<Product> list=new ArrayList<Product>();
		try {
		Connection conn=UserUtil.createConnection();
		String sql="select * from product";
		PreparedStatement pst = conn.prepareStatement(sql);
		ResultSet rs=pst.executeQuery();
		while(rs.next())
		{
			Product p =new Product();
			p.setPid(rs.getInt("pid"));
			p.setProduct_category(rs.getString("product_category"));
			p.setGender(rs.getString("gender"));
			p.setProduct_price(rs.getInt("product_price"));
			p.setProduct_image(rs.getString("product_image"));
			p.setProduct_seller(rs.getInt("product_seller"));
			list.add(p);
			
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
