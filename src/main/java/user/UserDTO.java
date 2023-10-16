package user;

/**
 * mysql> desc user;
+------------------+-------------+------+-----+---------+-------+
| Field            | Type        | Null | Key | Default | Extra |
+------------------+-------------+------+-----+---------+-------+
| userID           | varchar(20) | NO   | PRI | NULL    |       |
| userPassword     | varchar(64) | YES  |     | NULL    |       |
| userEmail        | varchar(50) | YES  |     | NULL    |       |
| userEmailHash    | varchar(64) | YES  |     | NULL    |       |
| userEmailChecked | tinyint(1)  | YES  |     | NULL    |       |
+------------------+-------------+------+-----+---------+-------+
 */

public class UserDTO {
	private String userID;
	private String userPassword;
	private String userEmail;
	private String userEmailHash;
	private boolean userEmailChecked;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserEmailHash() {
		return userEmailHash;
	}
	public void setUserEmailHash(String userEmailHash) {
		this.userEmailHash = userEmailHash;
	}
	public boolean isUserEmailChecked() {
		return userEmailChecked;
	}
	public void setUserEmailChecked(boolean userEmailChecked) {
		this.userEmailChecked = userEmailChecked;
	}
	
	// constructor
	public UserDTO() {}
	
	// constructor
	public UserDTO(String userID, String userPassword, String userEmail, String userEmailHash,
			boolean userEmailChecked) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
		this.userEmail = userEmail;
		this.userEmailHash = userEmailHash;
		this.userEmailChecked = userEmailChecked;
	}
	
}
