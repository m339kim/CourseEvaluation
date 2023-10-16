<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLEncoder"%>
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
	<% 
		request.setCharacterEncoding("UTF-8");
	
		// init page search results
		String courseDivide = "All";
		String searchType = "Most recent";
		String search = "";
		if(request.getParameter("courseDivide") != null) {
			courseDivide = request.getParameter("courseDivide");
		}
		if(request.getParameter("searchType") != null) {
			searchType = request.getParameter("searchType");
		}
		if(request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		
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
		boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
		if (emailChecked == false) { // has not verified email
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'emailSendConfirm.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
	%>

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
	
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="courseDivide" class="form-control mx-1 mt-2">
				<option value="All">All</option>
				<option value="Core" <% if (courseDivide.equals("Core")) out.println("selected"); %>>Core</option>
				<option value="Elective" <% if (courseDivide.equals("Elective")) out.println("selected"); %>>Elective</option>
				<option value="Other" <% if (courseDivide.equals("Other")) out.println("selected"); %>>Other</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="Most Recent">Most Recent</option>
				<option value="Most Likes" <% if (searchType.equals("Most Likes")) out.println("selected"); %>>Most Likes</option>
			</select>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">Add</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">Report</a>
		</form>
		
<% 
		ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
		evaluationList = new EvaluationDAO().getList(courseDivide, searchType, search);
		if (evaluationList != null) {
			for (int i = 0; i < evaluationList.size(); i++) {
				EvaluationDTO evaluation = evaluationList.get(i);
%>				<div class="card bg-light mt-3">
					<div class="card-header bg-light">
						<div class="row">
							<div class="col-8 text-left"><%=evaluation.getCourseCode()%>, <%= evaluation.getCourseName()%>&nbsp;<small><%= evaluation.getInstructor() %></small></div>
						</div>
					</div>
					<div class="card-body">
						<h5 class="card-title">
							<%=evaluation.getEvaluationTitle() %>&nbsp;<small><%=evaluation.getTerm()%> <%=evaluation.getYearDivide() %></small>
						</h5>
						<p class="card-text"><%=evaluation.getEvaluationContent() %></p>
						<div class="row">
							<div class="col-9 text-left">
								Easy <span style="color: red;"><%=evaluation.getEasy()%>%</span>
								Useful <span style="color:red;"><%=evaluation.getUseful()%>%</span>
								<span style="color:green">(Liked: <%=evaluation.getLikeCount()%>)</span>
							</div>
							<div class="col-3 text-right">
								<a onclick="return confirm('Like this review?')" href="./likeAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">Like</a>
								<a onclick="return confirm('Delete this review?')" href="./deleteAction.jsp?evaluationID=<%=evaluation.getEvaluationID()%>">Delete</a>
		
							</div>
						</div>
					</div>
				</div>		
<% 
			}
		}
%>
	</section>
	
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">Add Review</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>Course Code</label>
								<input type="text" name="courseCode" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-4">
								<label>Course Name</label>
								<input type="text" name="courseName" class="form-control" maxlength="20">
							</div>
							<div class="form-group col-sm-4">
								<label>Instructor</label>
								<input type="text" name="instructor" class="form-control" maxlength="20">
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>Year Taken</label>
								<select name="yearDivide" class="form-control">
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023" selected>2023</option>
									<option value="2024">2024</option>
									<option value="2025">2025</option>
									<option value="2026">2026</option>
									<option value="2027">2027</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>Term Taken</label>
								<select name="term" class="form-control">
									<option value="Fall" selected>Fall</option>
									<option value="Winter">Winter</option>
									<option value="Spring">Spring</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>Category</label>
								<select name="courseDivide" class="form-control">
									<option value="Core" selected>Core</option>
									<option value="Elective">Elective</option>
									<option value="Other">Other</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>Body</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>Easy</label>
								<select name="easy" class="form-control">
									<option value="100">100</option>
									<option value="90">90</option>
									<option value="80">80</option>
									<option value="70">70</option>
									<option value="60">60</option>
									<option value="50">50</option>
									<option value="40">40</option>
									<option value="30">30</option>
									<option value="20">20</option>
									<option value="10">10</option>
									<option value="0">0</option>
								</select>
							</div>
							<div class="form-group col-sm-6">
								<label>Useful</label>
								<select name="useful" class="form-control">
									<option value="100">100</option>
									<option value="90">90</option>
									<option value="80">80</option>
									<option value="70">70</option>
									<option value="60">60</option>
									<option value="50">50</option>
									<option value="40">40</option>
									<option value="30">30</option>
									<option value="20">20</option>
									<option value="10">10</option>
									<option value="0">0</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">Report a review</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>Title</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>Content</label>
							<textarea name="reportContent" class="form-control" maxlength="2048"></textarea>
						</div>
						
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
							<button type="submit" class="btn btn-danger">Submit</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
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