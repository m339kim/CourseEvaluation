package evaluation;

/**
 * mysql> desc evaluation;
+-------------------+---------------+------+-----+---------+----------------+
| Field             | Type          | Null | Key | Default | Extra          |
+-------------------+---------------+------+-----+---------+----------------+
| evaluationID      | int           | NO   | PRI | NULL    | auto_increment |
| userID            | varchar(20)   | YES  |     | NULL    |                |
| courseCode        | varchar(50)   | YES  |     | NULL    |                |
| courseName        | varchar(50)   | YES  |     | NULL    |                |
| instructor        | varchar(20)   | YES  |     | NULL    |                |
| yearDivide        | varchat(20)   | YES  |     | NULL    |                |
| term              | varchar(20)   | YES  |     | NULL    |                |
| courseDivide      | varchar(10)   | YES  |     | NULL    |                |
| evaluationTitle   | varchar(50)   | YES  |     | NULL    |                |
| evaluationContent | varchar(2048) | YES  |     | NULL    |                |
| easy              | varchar(3)    | YES  |     | NULL    |                |
| useful            | varchar(3)    | YES  |     | NULL    |                |
| likeCount         | int           | YES  |     | NULL    |                |
+-------------------+---------------+------+-----+---------+----------------+
 */
public class EvaluationDTO {
	int evaluationID;
	String userID;
	
	String courseCode;
	String courseName;
	String instructor;
	String yearDivide;
	String term;
	String courseDivide;
	
	String evaluationTitle;
	String evaluationContent;
	
	String easy;
	String useful;
	
	int likeCount;

	public int getEvaluationID() {
		return evaluationID;
	}

	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getInstructor() {
		return instructor;
	}

	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}

	public String getYearDivide() {
		return yearDivide;
	}

	public void setYearDivide(String yearDivide) {
		this.yearDivide = yearDivide;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getCourseDivide() {
		return courseDivide;
	}

	public void setCourseDivide(String courseDivide) {
		this.courseDivide = courseDivide;
	}

	public String getEvaluationTitle() {
		return evaluationTitle;
	}

	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}

	public String getEvaluationContent() {
		return evaluationContent;
	}

	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}

	public String getEasy() {
		return easy;
	}

	public void setEasy(String easy) {
		this.easy = easy;
	}

	public String getUseful() {
		return useful;
	}

	public void setUseful(String useful) {
		this.useful = useful;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public EvaluationDTO() {}
	
	public EvaluationDTO(int evaluationID, String userID, String courseCode, String courseName, String instructor,
			String yearDivide, String term, String courseDivide, String evaluationTitle, String evaluationContent,
			String easy, String useful, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.courseCode = courseCode;
		this.courseName = courseName;
		this.instructor = instructor;
		this.yearDivide = yearDivide;
		this.term = term;
		this.courseDivide = courseDivide;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.easy = easy;
		this.useful = useful;
		this.likeCount = likeCount;
	}
	
	
}
