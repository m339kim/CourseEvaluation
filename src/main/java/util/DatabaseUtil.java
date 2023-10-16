package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	// static, to let other libraries to use getConnection()
	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/CourseEvaluation";
			String dbID = "root";
			String dbPassword = "82465Mj*";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
