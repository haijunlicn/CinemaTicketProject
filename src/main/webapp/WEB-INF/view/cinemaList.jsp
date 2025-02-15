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
	<jsp:include page="adminHeader.jsp"></jsp:include>

	<div id="layoutSidenav">
		<jsp:include page="adminSidebar.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-2">Cinema List</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath}/admin/adminDashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">CinemaList</li>
						<li>${testError}</li>
					</ol>

					<div class="card mb-4">
						<div class="card-header d-flex justify-content-between">
							<div>
								<i class="fas fa-table me-1"></i> <span>Cinema List</span>
							</div>
							<!-- Bootstrap 5 Button with Plus Icon -->
							<a href="${pageContext.request.contextPath}/cinema/addCinema" class="btn btn-primary ms-auto"> <i
								class="bi bi-plus-lg"></i> Add Cinema
							</a>

						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>No.</th>
										<th>Name</th>
										<th>Rows</th>
										<th>Columns</th>
										<th>Township</th>
										<th>State</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>No.</th>
										<th>Name</th>
										<th>Rows</th>
										<th>Columns</th>
										<th>Township</th>
										<th>State</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="cinema" items="${cinemaList}"
										varStatus="status">
										<tr>
											<td>${status.count}.</td>
											<td>${cinema.name}</td>
											<td>${cinema.rowCount}</td>
											<td>${cinema.colCount}</td>
											<td>${cinema.townshipName}</td>
											<td>${cinema.stateName}</td>
											<td><span
												class="${cinema.status == 1 ? 'text-success' : 'text-danger'}">
													${cinema.status == 1 ? 'Active' : 'Inactive'} </span></td>
											<td><a href="cinemaDetail/${cinema.id}"
												class="btn btn-primary btn-sm">View</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</main>
			<jsp:include page="adminFooter.jsp"></jsp:include>
		</div>
	</div>

</body>
</html>