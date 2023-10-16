<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="liked.LikedDTO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Please log in.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;

	if (request.getParameter("evaluationID") != null) {
		evaluationID = request.getParameter("evaluationID");
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	if (userID.equals(evaluationDAO.getUserID(evaluationID))){
		int result = new EvaluationDAO().delete(evaluationID);
		if (result == 1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Evaluation successfully deleted.');");
			script.println("location.href='index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error occurred.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Only the author can delete an evaluation.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} 
%>