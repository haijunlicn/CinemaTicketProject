<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Showtime Form</title>

</head>
<body>
	<jsp:include page="adminHeader.jsp"></jsp:include>

	<div id="layoutSidenav">
		<jsp:include page="adminSidebar.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<div class="container mt-2 px-3">
				<h2 class="mb-3">Edit Showtime</h2>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/admin/adminDashboard">Dashboard</a></li>
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/showtime/showtimeList">ShowtimeList</a></li>
					<li class="breadcrumb-item active">EditShowtimeForm</li>
				</ol>

				<form:form
					action="${pageContext.request.contextPath}/showtime/editShowtime"
					modelAttribute="showtimeObj" method="post"
					class="p-4 border rounded shadow bg-white">

					<h4 class="text-center mb-4">Edit Showtime Form</h4>
					
					<form:hidden path="id"/>

					<!-- Status -->
					<div class="mb-3">
						<label for="status" class="form-label fw-semibold">Status</label>
						<form:select class="form-select" path="status">
							<form:option value="1">Active</form:option>
							<form:option value="0">Inactive</form:option>
						</form:select>
					</div>

					<div class="row">
						<!-- Start Hour -->
						<div class="col-md-6 mb-3">
							<label for="localStartHour" class="form-label fw-semibold">Start
								Hour</label>
							<form:input type="time" class="form-control" path="localStartHour" />
							<form:errors path="localStartHour" class="text-danger" />
						</div>

						<!-- End Hour -->
						<div class="col-md-6 mb-3">
							<label for="localEndHour" class="form-label fw-semibold">End
								Hour</label>
							<form:input type="time" class="form-control" path="localEndHour" />
							<form:errors path="localEndHour" class="text-danger" />
						</div>
					</div>

					<!-- Submit Button -->
					<button type="submit" class="btn btn-success w-100">
						<i class="bi bi-plus-lg"></i> Submit
					</button>

				</form:form>

			</div>

			<jsp:include page="adminFooter.jsp"></jsp:include>
		</div>
	</div>

	<!-- dynamic township filter -->
	<div id="townshipData" data-townships='${townshipJson}'></div>
	<div id="selectedTownshipId" data-townships='${cinemaObj.townshipId}'></div>
	<script src="/TicketProject/resources/js/townshipFilter.js"></script>

	<script type="text/javascript">
		
	</script>

</body>
</html>