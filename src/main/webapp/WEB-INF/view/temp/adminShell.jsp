<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cinema List</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="../adminHeader.jsp"></jsp:include>

	<div id="layoutSidenav">
		<jsp:include page="../adminSidebar.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">Cinema List</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath}/admin/adminDashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">Cinema List</li>
					</ol>

					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table me-1"></i> Cinema List
						</div>
						<div class="card-body">
							hello
						</div>
					</div>
				</div>
			</main>
			<jsp:include page="../adminFooter.jsp"></jsp:include>
		</div>
	</div>

</body>
</html>