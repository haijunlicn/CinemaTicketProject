<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Showtime List</title>
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
					<h1 class="mt-2">Showtime List</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath}/admin/adminDashboard">Dashboard</a></li>
						<li class="breadcrumb-item active">ShowtimeList</li>
						<li>${testError}</li>
					</ol>

					<div class="card mb-4 col-md-8">
						<div class="card-header d-flex justify-content-between">
							<div>
								<i class="fas fa-table me-1"></i> <span>Showtime List</span>
							</div>
							<!-- Bootstrap 5 Button with Plus Icon -->
							<a href="${pageContext.request.contextPath}/showtime/addShowtime"
								class="btn btn-primary ms-auto"> <i class="bi bi-plus-lg"></i>
								Add Showtime
							</a>

						</div>
						<div class="card-body">
							<table id="datatablesSimple">
								<thead>
									<tr>
										<th>No.</th>
										<th>Start Hour</th>
										<th>End Hour</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<th>No.</th>
										<th>Start Hour</th>
										<th>End Hour</th>
										<th>Status</th>
										<th>Action</th>
									</tr>
								</tfoot>
								<tbody>
									<c:forEach var="showtime" items="${showtimeList}"
										varStatus="status">
										<tr>
											<td>${status.count}.</td>
											<td>${showtime.startHour}</td>
											<td>${showtime.endHour}</td>
											<td><span
												class="${showtime.status == 1 ? 'text-success' : 'text-danger'}">
													${showtime.status == 1 ? 'Active' : 'Inactive'} </span></td>
											<td class="d-flex"><a href="editShowtime/${showtime.id}"
												class="btn btn-primary btn-sm">Edit</a> <a
												class="btn btn-danger btn-sm" id="deleteShowtimeBtn"
												data-id="${showtime.id}" onclick="confirmDelete(this)">Delete</a>
											</td>

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