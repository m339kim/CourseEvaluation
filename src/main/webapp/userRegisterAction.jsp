<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");

	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Already logged in.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}

	String userPassword = null;
	String userEmail = null;
	if (request.getParameter("userID") != null) {
		userID = request.getParameter("userID");
	}
	if (request.getParameter("userPassword") != null) {
		userPassword = request.getParameter("userPassword");
	}
	if (request.getParameter("userEmail") != null) {
		userEmail = request.getParameter("userEmail");
	}
	if (userID == null || userPassword == null || userEmail == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Invalid fields.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, SHA256.getSHA256(userEmail), false));
	if (result == -1) { // failed to create user
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ID already exists.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else { // successfully created user
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendAction.jsp'"); // verify email page
		script.println("</script>");
		script.close();
		return;
	}
%>