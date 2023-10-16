<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.Address"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Authenticator"%>

<%@ page import="java.util.Properties"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="util.Gmail"%>
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
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if (emailChecked == true) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('This email has already been verified.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host = "http://localhost:8080/Course_Evaluation/";
	String from = "<admin-email@gmail.com>";
	String to = userDAO.getUserEmail(userID);
	String subject = "Verify your email for Course Evaluation.";
	String content = "Visit this link to proceed." 
		+ "<a href = '" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to)
		+ "'>Verify Email</a>";
			
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.gmail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.starttls.required", "true");
	p.put("mail.smtp.ssl.protocols", "TLSv1.2");
	p.put("mail.smtp.auth", "true");
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");
	
	// send email
	try {
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p, auth);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF-8");
		Transport.send(msg);
		
	} catch (Exception e) {
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Error occurred.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
	}
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>Course Evaluation Website</title>
		<!-- Add Bootstrap CSS -->
		<link rel="stylesheet" href="./css/bootstrap.min.css">
		<!-- Add Custom CSS -->
		<link rel="stylesheet" href="./css/custom.css">
	</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">Course Evaluation Website</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"> </span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">Home</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">Account</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
						if (userID == null) {
%>
						<a class="dropdown-item" href="userLogin.jsp">Log in</a>
						<a class="dropdown-item" href="userJoin.jsp">Sign up</a>
<%
						} else {
%>						
						<a class="dropdown-item" href="userLogout.jsp">Log out</a>
<%
						}
%>
					</div>
				</li>
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" placeholder="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>
		</div>
	</nav>
	
	<section class="container mt-3" style="max-width:560px;">
		<div class="alert alert-success mt-4" role="alert">
			Verification email sent. Please verify your entered email address.
		</div>	
		
	</section>
	
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; All Rights Reserved.
	</footer>
	
	<!-- Add jQuery JS -->
	<script src="./js/jquery.min.js"></script>
	<!-- Add Popper JS -->
	<script src="./js/popper.js"></script>
	<!-- Add Bootstrap JS -->
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>