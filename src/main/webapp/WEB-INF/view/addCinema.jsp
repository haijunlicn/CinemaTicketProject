<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Cinema Form</title>

</head>
<body>
	<jsp:include page="adminHeader.jsp"></jsp:include>

	<div id="layoutSidenav">
		<jsp:include page="adminSidebar.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<div class="container mt-2 px-3">
				<h2 class="mb-3">Add Cinema</h2>
				<ol class="breadcrumb mb-4">
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/admin/adminDashboard">Dashboard</a></li>
					<li class="breadcrumb-item"><a
						href="${pageContext.request.contextPath}/cinema/cinemaList">CinemaList</a></li>
					<li class="breadcrumb-item active">AddCinemaForm</li>
				</ol>

				<form:form
					action="${pageContext.request.contextPath}/cinema/addCinema"
					modelAttribute="cinemaObj" method="post">
					<div class="row">
						<!-- Select State -->
						<div class="col mb-3">
							<label for="state" class="form-label">State</label>
							<form:select class="form-select" path="stateId" id="state">
								<form:option value="" label="Select a State" />
								<form:options items="${stateList}" itemValue="id"
									itemLabel="name" />
							</form:select>
							<form:errors path="stateId" class="text-danger" />
						</div>

						<!-- Select Township -->
						<div class="col mb-3">
							<label for="township" class="form-label">Township</label>
							<form:select class="form-select" path="townshipId" id="township"
								disabled="true">
								<form:option value="" label="Select a Township" />
							</form:select>
							<form:errors path="townshipId" class="text-danger" />
						</div>
					</div>

					<!-- Cinema Name -->
					<div class="mb-3">
						<label for="name" class="form-label">Cinema Name</label>
						<form:input class="form-control" path="name" />
						<form:errors path="name" class="text-danger" />
					</div>

					<!-- Rows and Columns -->
					<div class="row">
						<!-- Total Seats -->
						<div class="col-md-4 mb-3">
							<label for="totalSeats" class="form-label">Total Seats</label>
							<form:input type="number" class="form-control" path="totalSeats" />
						</div>
						<div class="col-md-4 mb-3">
							<label for="rowCount" class="form-label">Number of Rows</label>
							<form:input type="number" value="5" class="form-control"
								path="rowCount" />
						</div>
						<div class="col-md-4 mb-3">
							<label for="colCount" class="form-label">Number of
								Columns</label>
							<form:input type="number" value="10" class="form-control"
								path="colCount" />
						</div>
					</div>

					<!-- Latitude & Longitude -->
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="lat" class="form-label">Latitude</label>
							<form:input type="text" class="form-control" path="lat" />
						</div>
						<div class="col-md-6 mb-3">
							<label for="lon" class="form-label">Longitude</label>
							<form:input type="text" class="form-control" path="lon" />
						</div>
					</div>

					<!-- showtime -->
					<div class="mb-3">
						<label class="form-label">Showtimes</label>
						<div class="d-flex flex-wrap gap-2">
							<c:forEach var="showtime" items="${showtimeList}"
								varStatus="status">
								<c:if test="${showtime.status == 1}">
									<label>
										<div class="showtime-container">
											<form:checkbox path="selectedShowtimeList"
												id="showtime_${showtime.id}" value="${showtime.id}"
												class="hidden-checkbox"
												onchange="console.log('Showtime ${showtime.id} checked:', this.checked)" />
											<div class="showtime-card">${showtime.getFormattedShowtime()}</div>
										</div>
									</label>
								</c:if>
							</c:forEach>



						</div>
					</div>

					<!-- Status -->
					<div class="mb-3">
						<label for="status" class="form-label">Status</label>
						<form:select class="form-select" path="status">
							<form:option value="1">Active</form:option>
							<form:option value="0">Inactive</form:option>
						</form:select>
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