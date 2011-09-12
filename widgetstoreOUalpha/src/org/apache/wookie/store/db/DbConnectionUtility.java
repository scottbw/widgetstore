package org.apache.wookie.store.db;

import java.util.ArrayList;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbConnectionUtility {

	private Connection conn = null;

	public DbConnectionUtility() {
		conn = null;
		try {
			String userName = "java";
			String password = "java";
			String url = "jdbc:mysql://localhost:3306/widgetdb";
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection(url, userName, password);
		} catch (Exception e) {
			System.err.println("Cannot connect to database server");
			e.printStackTrace();
		}
	}

	public void terminateConnection() {
		try {
			conn.close();
		} catch (SQLException sqle) {
			System.err.println("Cannot close connection");
			sqle.printStackTrace();
		}
	}

	/**
	 * Returns user rating for the given widget returns 0 if no rating for the
	 * given widget
	 * 
	 * @param userID
	 * @param widgetid
	 * @return
	 */
	public int getUserRating(int userID, int widgetid) {
		int rating = 0;
		try {
			String psSql = "SELECT * FROM RATING WHERE userid=? AND widid=?";
			PreparedStatement ps = conn.prepareStatement(psSql);
			ps.setInt(1, userID);
			ps.setInt(2, widgetid);
			ps.execute();
			ResultSet rs = ps.getResultSet();
			if (rs.next()) {
				rating = rs.getInt("rate");
			}
			rs.close();
			ps.close();
		} catch (SQLException sqle) {
			System.err.println("SQL error on getUserRating()");
			sqle.printStackTrace();
		}
		return rating;
	}

	/**
	 * Returns user rating for the given widget returns 0 if no rating for the
	 * given widget
	 * 
	 * @param username
	 * @param widgetid
	 * @return
	 */
	public int getUserRating(String username, int widgetid) {
		int userid = getUserIdByUsername(username);
		return getUserRating(userid, widgetid);
	}

	public ArrayList getWidgetComments(int widgetid) {
		ArrayList<HashMap> commentList = new ArrayList<HashMap>();
		try {
			String psSql = "SELECT c.widid, c.userid, c.commentext, r.rate, su.fullname, su.username "
					+ "FROM comments c "
					+ "INNER JOIN rating r "
					+ "INNER JOIN storeusers su "
					+ "WHERE c.userid = r.userid "
					+ "AND c.widid = r.widid "
					+ "AND su.id = c.userid "
					+ "AND c.widid=?";
			PreparedStatement ps = conn.prepareStatement(psSql);
			ps.setInt(1, widgetid);
			ps.execute();
			ResultSet rs = ps.getResultSet();
			while (rs.next()) {
				int userid = rs.getInt("userid");
				String commentText = rs.getString("commentext");
				int rate = rs.getInt("rate");
				String userFullName = rs.getString("fullname");
				String userName = rs.getString("username");
				HashMap<String,String> comment = new HashMap<String,String>();
				comment.put("userid",""+userid);
				comment.put("comment",commentText);
				comment.put("rate",""+rate);
				comment.put("userFullName",userFullName);
				comment.put("userName",userName);
				
				commentList.add(comment);				
			}
			rs.close();
			ps.close();

		} catch (SQLException sqle) {
			System.err.println("SQL error on getWidgetComments()");
			sqle.printStackTrace();
		}
		return commentList;
	}
	
	public ArrayList<String> getWidgetTags(int widgetid){
		ArrayList<String> tags = new ArrayList<String>();
		try {
			String psSql = "SELECT tagtext FROM tagswidgets tw,tags t where tw.tagid=t.id AND tw.widid=?";
			PreparedStatement ps = conn.prepareStatement(psSql);
			ps.setInt(1, widgetid);
			ps.execute();
			ResultSet rs = ps.getResultSet();
			while (rs.next()) {
				String tagtext = rs.getString("tagtext");
				tags.add(tagtext);
			}
			rs.close();
			ps.close();

		} catch (SQLException sqle) {
			System.err.println("SQL error on getWidgetTags()");
			sqle.printStackTrace();
		}
		return tags;
	}

	private int getUserIdByUsername(String username) {
		int userid = 0;
		try {
			String psSql = "SELECT id FROM STOREUSERS WHERE username=?";
			PreparedStatement ps = conn.prepareStatement(psSql);
			ps.setString(1, username);
			ps.execute();
			ResultSet rs = ps.getResultSet();
			if (rs.next()) {
				userid = rs.getInt("id");
			}
			rs.close();
			ps.close();

		} catch (SQLException sqle) {
			System.err.println("SQL error on getUserID()");
			sqle.printStackTrace();
		}
		return userid;
	}
	
	private int getUserIdByHashedusername(String hashedUsername) {
		int userid = 0;
		try {
			String psSql = "SELECT id FROM STOREUSERS WHERE hashedUserName=?";
			PreparedStatement ps = conn.prepareStatement(psSql);
			ps.setString(1, hashedUsername);
			ps.execute();
			ResultSet rs = ps.getResultSet();
			if (rs.next()) {
				userid = rs.getInt("id");
			}
			rs.close();
			ps.close();

		} catch (SQLException sqle) {
			System.err.println("SQL error on getUserID()");
			sqle.printStackTrace();
		}
		return userid;
	}
	
	public int insertComment(int widgetid,String hashedUsername,String commentText){
		int userid = getUserIdByHashedusername(hashedUsername);
		return insertComment(widgetid, userid, commentText);
	}
	
	public int insertComment(int widgetid,int userid,String commentText){
		int rowid=0;
		try {
			String sql="INSERT INTO COMMENTS VALUES(?,?,?)";
            PreparedStatement s = conn.prepareStatement(sql);
            s.setInt(1,widgetid);
            s.setInt(2,userid);
            rowid = s.executeUpdate();            
            s.close ();
		} catch (SQLException sqle) {
			System.err.println("SQL error on getUserID()");
			sqle.printStackTrace();
		}
		return rowid;
	}
	
	
}
