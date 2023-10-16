package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	/* Log in */
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setString(1, userID); // 1= first `?`
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					return 1; // login successful
							  // correct userID, correct userPassword
				} else {
					return 0; // correct userID, incorrect userPassword
				}
			}
			return -1; // userID does not exist
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -2; // database error
	}
	
	
	/* Sign up */
	public int join(UserDTO user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, false)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setString(1, user.getUserID()); // 1= first `?`
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			return pstmt.executeUpdate(); // successful sign up for 1 user, so return 1
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // database error, sign up fail
	}
	
	
	/* Get userEmail as String */
	public String getUserEmail(String userID) {
		String SQL = "SELECT userEmail FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setString(1, userID); // 1= first `?`
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				return rs.getString(1); // return userEmail
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return null; // database error
	}
	
	
	/* Verify if userID has verified its email addr */
	public boolean getUserEmailChecked(String userID) {
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setString(1, userID); // 1= first `?`
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				return rs.getBoolean(1); // 1 = valueOf userEmailChecked
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return false; // database error
	}
	
	
	/* Record that userID has verified their email */
	public boolean setUserEmailChecked(String userID) {
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setString(1, userID); // 1= first `?`
			pstmt.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return false; // database error
	}
}
