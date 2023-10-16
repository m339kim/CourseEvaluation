package liked;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DatabaseUtil;

public class LikedDAO {
	public int like(String userID, String evaluationID, String userIP) {
		String SQL = "INSERT INTO LIKED VALUES (?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setString(1, userID); // 1= first `?`
			pstmt.setString(2, evaluationID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate(); // successful sign up for 1 user, so return 1
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // duplicate like action
	}
}
