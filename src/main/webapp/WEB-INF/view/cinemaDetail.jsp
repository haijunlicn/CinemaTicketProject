<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cinema Detail</title>

<link href="/TicketProject/resources/css/style.css" rel="stylesheet">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">

</head>
<body>
	<jsp:include page="adminHeader.jsp"></jsp:include>

	<div id="layoutSidenav">
		<jsp:include page="adminSidebar.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-2">Cinema Detail</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath}/admin/adminDashboard">Dashboard</a></li>
						<li class="breadcrumb-item"><a
							href="${pageContext.request.contextPath}/cinema/cinemaList">CinemaList</a></li>
						<li class="breadcrumb-item active">${cinemaObj.name}</li>
					</ol>

					<div class="d-flex">

						<!-- Left Column: Cinema Information -->
						<div class="card mb-4 me-4 col-md-6">
							<div class="card-header">
								<i class="fas fa-table me-1"></i> Cinema Infomation
							</div>


							<div
								class="card-body mb-4 d-flex flex-column justify-content-between">
								<div>
									<div class="mb-3 row">
										<label class="col-md-4 font-weight-bold">Name:</label>
										<div class="col-md-8 text-muted">${cinemaObj.name}</div>
									</div>
									<div class="mb-3 row">
										<label class="col-md-4 font-weight-bold">Address:</label>
										<div class="col-md-8 text-muted">${cinemaObj.townshipName},
											${cinemaObj.stateName}</div>
									</div>
									<div class="mb-3 row">
										<label class="col-md-4 font-weight-bold">Location
											(Lat, Lon):</label>
										<div class="col-md-8 text-muted">${cinemaObj.lat},
											${cinemaObj.lon}</div>
									</div>
									<div class="mb-3 row">
										<label class="col-md-4 font-weight-bold">Showtimes:</label>
										<div class="col-md-8">
											<c:forEach var="showtime" items="${showtimeList}"
												varStatus="status">
												<label><div class="showtime-container">
														<div class="showtime-card">
															${showtime.getFormattedShowtime()}</div>
													</div> </label>
											</c:forEach>
										</div>
									</div>

									<div class="mb-3 row">
										<label class="col-md-4 font-weight-bold">Status:</label>
										<div class="col-md-8">
											<span
												class="badge rounded-pill ${cinemaObj.status == 1 ? 'bg-success' : 'bg-danger'}">
												${cinemaObj.status == 1 ? 'Active' : 'Inactive'} </span>
										</div>
									</div>
								</div>

								<!-- Action Button -->
								<div class="text-center mt-3">
									<a
										href="${pageContext.request.contextPath}/cinema/editCinemaInfo/${cinemaObj.id}"
										class="btn btn-primary btn-lg w-100">Edit Cinema Info</a>
								</div>
							</div>
						</div>

						<!-- right side -->
						<div class="card mb-4 col-md-6">
							<div class="card-header">
								<i class="fas fa-table me-1"></i> Seating Layout
							</div>


							<div class="card-body mb-4">
								<!-- Left Column: Cinema Information -->
								<div
									class="card-body d-flex flex-column justify-content-between">
									<div>
										<!-- Centering the Rows and Columns Count -->
										<div class="text-center">
											<h6>Rows: ${cinemaObj.rowCount} | Columns:
												${cinemaObj.colCount}</h6>
										</div>

										<!-- Seating Chart -->
										<div class="seating-chart my-2 flex-grow-1">
											<c:forEach var="row" begin="1" end="${cinemaObj.rowCount}"
												varStatus="rowStatus">
												<div class="seat-row d-flex justify-content-center mb-2">
													<c:forEach var="col" begin="1" end="${cinemaObj.colCount}"
														varStatus="colStatus">
														<div
															class="seat m-1 text-center d-flex justify-content-center align-items-center rounded">
															<i class="bi bi-person-fill"></i>
														</div>
													</c:forEach>
												</div>
											</c:forEach>

										</div>
									</div>

									<!-- Manage Seats Button -->
									<div class="text-center mt-3">
										<a href="/TicketProject/seats/manageSeats/${cinemaObj.id}"
											class="btn btn-primary btn-lg w-100">Manage Seat</a>
									</div>
								</div>
							</div>
						</div>

					</div>

					<!-- Hard Delete Button -->
					<div class="text-center mt-4">
						<a class="btn btn-danger btn-lg w-100" id="deleteCinemaBtn">Delete
							Cinema</a>
					</div>

				</div>
			</main>
			<jsp:include page="adminFooter.jsp"></jsp:include>
		</div>
	</div>

	<script type="text/javascript"
		src="/TicketProject/resources/js/main.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

	<script>
    document.getElementById('deleteCinemaBtn').addEventListener('click', function(e) {
        e.preventDefault(); // Prevent default action (navigation)

        // Show SweetAlert confirmation dialog
        Swal.fire({
            title: 'Are you sure?',
            text: 'This action cannot be undone!',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel'
        }).then((result) => {
            if (result.isConfirmed) {
                // If confirmed, navigate to the delete URL
                window.location.href = "${pageContext.request.contextPath}/cinema/hardDeleteCinema/${cinemaObj.id}";
            }
        });
    });
</script>

</body>
</html>