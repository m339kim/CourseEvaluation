package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

// direct access validator to database table EVALUATION
public class EvaluationDAO {
	/* Write an evaluation */
	public int write(EvaluationDTO evaluationDTO) {
		String SQL = "INSERT INTO EVALUATION VALUES (NULL, ?,?,?,?,?,?,?,?,?,?,?, 0)"; // 11 fields
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			// + prevent XSS
			pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>")); // 1= first `?`
			pstmt.setString(2, evaluationDTO.getCourseCode().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(3, evaluationDTO.getCourseName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(4, evaluationDTO.getInstructor().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(5, evaluationDTO.getYearDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(6, evaluationDTO.getTerm().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(7, evaluationDTO.getCourseDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(8, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(9, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(10, evaluationDTO.getEasy().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			pstmt.setString(11, evaluationDTO.getUseful().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n","<br>"));
			return pstmt.executeUpdate(); // returns 1 because 1 evaluation has been added
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // database error
	}
	
	
	public ArrayList<EvaluationDTO> getList(String courseDivide, String searchType, String search) {
		if (courseDivide.equals("All")) {
			courseDivide = "";
		}
		
		ArrayList<EvaluationDTO> evaluationList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if (searchType.equals("Most recent")) {
				SQL = "SELECT * FROM EVALUATION WHERE courseDivide LIKE ? AND CONCAT(courseCode, courseName, instructor, evaluationTitle, evaluationContent) " +
						"LIKE ? ORDER BY evaluationID DESC";
			} else  if (searchType.equals("Most likes")) {
				SQL = "SELECT * FROM EVALUATION WHERE courseDivide LIKE ? AND CONCAT(courseCode, courseName, instructor, evaluationTitle, evaluationContent) " +
						"LIKE ? ORDER BY likeCount DESC";
			}
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setString(1, "%" + courseDivide + "%"); // 1= first `?`
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while (rs.next()) {
				EvaluationDTO evaluation = new EvaluationDTO(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11),
					rs.getString(12),
					rs.getInt(13)
				);
				evaluationList.add(evaluation);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if (pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if (rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		System.out.println(evaluationList);
		return evaluationList;
		
	}
	
	public int like(String evaluationID) {
		String SQL = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setInt(1, Integer.parseInt(evaluationID)); // 1= first `?`
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return -1; // database error
	}
	public int delete(String evaluationID) {
		String SQL = "DELETE FROM EVALUATION WHERE evaluationID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setInt(1, Integer.parseInt(evaluationID)); // 1= first `?`
			return pstmt.executeUpdate();
		} catch (Exception e) { 
			e.printStackTrace();
		} finally { // close connections
			try {if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
			try {if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
		}
		return -1; // database error
	}
	public String getUserID(String evaluationID) {
		String SQL = "SELECT userID FROM EVALUATION WHERE evaluationID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection(); // connected connection stored in 'conn'
			pstmt = conn.prepareStatement(SQL); // get connection ready to execute SQL cmd
			pstmt.setInt(1, Integer.parseInt(evaluationID)); // 1= first `?`
			rs = pstmt.executeQuery(); 
			while (rs.next()) {
				return rs.getString(1); // 1 = valueOf userEmailChecked
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
}
