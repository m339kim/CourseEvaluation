<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>

<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");

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

	// evaluation post fields:
	String courseCode = null;
	String courseName = null;
	String instructor = null;
	String yearDivide = null;
	String term = null;
	String courseDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String easy = null;
	String useful = null;

	// init	
	if (request.getParameter("courseCode") != null) {
		courseCode = request.getParameter("courseCode");
	}
	if (request.getParameter("courseName") != null) {
		courseName = request.getParameter("courseName");
	}
	if (request.getParameter("instructor") != null) {
		instructor = request.getParameter("instructor");
	}
	if (request.getParameter("yearDivide") != null) {
		yearDivide = request.getParameter("yearDivide");
	}
	if (request.getParameter("term") != null) {
		term = request.getParameter("term");
	}
	if (request.getParameter("courseDivide") != null) {
		courseDivide = request.getParameter("courseDivide");
	}
	if (request.getParameter("evaluationTitle") != null) {
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	if (request.getParameter("evaluationContent") != null) {
		evaluationContent = request.getParameter("evaluationContent");
	}
	if (request.getParameter("easy") != null) {
		easy = request.getParameter("easy");
	}
	if (request.getParameter("useful") != null) {
		useful = request.getParameter("useful");
	}
	if (courseCode == null         || courseName == null           || instructor == null   ||
		yearDivide == null         || term == null                 || courseDivide == null ||
		evaluationTitle == null    || evaluationContent == null    ||
		evaluationTitle.equals("") || evaluationContent.equals("") ||
		easy == null               || useful == null) {
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Invalid fields.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	// create eval using constructor
	int result = evaluationDAO.write(new EvaluationDTO(0, userID, courseCode, courseName, instructor, yearDivide, term, courseDivide, evaluationTitle, evaluationContent, easy, useful, 0));
	
	// handle eval creation outputs
	if (result == -1) { // failed to create eval
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Failed to add course evaluation.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else { // successfully created user
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'"); // verify email page
		script.println("</script>");
		script.close();
		return;
	}
%>