package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.bean.Cart;
import com.util.UserUtil;

public class CartDao {
		
	public static void addToCart(Cart c)
	{
		try {
			Connection conn=UserUtil.createConnection();
			String sql = "insert into cart(uid,pid,product_price,qty,total_price) values(?,?,?,?,?)";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1, c.getUid());
			pst.setInt(2, c.getPid());
			pst.setInt(3, c.getProduct_price());
			pst.setInt(4, c.getQty());
			pst.setInt(5, c.getTotal_price());
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static List<Cart> getCartByUser(int uid)
	{
		List<Cart> list= new ArrayList<Cart>();
		try {
			Connection conn=UserUtil.createConnection();
			String sql="select * from cart where uid=?";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1, uid);
			ResultSet rs = pst.executeQuery();
			while(rs.next())
			{
				Cart c = new Cart();
				c.setCid(rs.getInt("cid"));
				c.setUid(rs.getInt("uid"));
				c.setPid(rs.getInt("pid"));
				c.setProduct_price(rs.getInt("product_price"));
				c.setQty(rs.getInt("qty"));
				c.setTotal_price(rs.getInt("total_price"));
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public static void removeFromCart(int uid,int pid)
	{
		try {
			Connection conn=UserUtil.createConnection();
			String sql = "delete from cart where uid=? and pid=?";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1, uid);
			pst.setInt(2, pid);
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static boolean checkCart(int uid,int pid)
	{
		boolean cart_flage=false;
		try {
			Connection conn=UserUtil.createConnection();
			String sql ="select * from cart where uid=? and pid=?";
			PreparedStatement pst=conn.prepareStatement(sql);
			pst.setInt(1, uid);
			pst.setInt(2, pid);
			ResultSet rs=pst.executeQuery();
			if(rs.next())
			{
				cart_flage=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cart_flage;
		
	}
	public static Cart getCartByCid(int cid)
	{
		
		Cart c = null;
		try {
			Connection conn=UserUtil.createConnection();
			String sql="select * from cart where cid=?";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1, cid);
			ResultSet rs = pst.executeQuery();
			while(rs.next())
			{
				c = new Cart();
				c.setCid(rs.getInt("cid"));
				c.setUid(rs.getInt("uid"));
				c.setPid(rs.getInt("pid"));
				c.setProduct_price(rs.getInt("product_price"));
				c.setQty(rs.getInt("qty"));
				c.setTotal_price(rs.getInt("total_price"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return c;
	}
	public static void updateCart(int cid,int total_price,int qty)
	{
		try {
			Connection conn=UserUtil.createConnection();
			String sql = "update cart set qty=?,total_price=? where cid=?";
			PreparedStatement pst = conn.prepareStatement(sql);
			pst.setInt(1, qty);
			pst.setInt(2, total_price);
			pst.setInt(3,cid);
			pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
