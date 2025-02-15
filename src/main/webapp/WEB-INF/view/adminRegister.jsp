<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Register</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
</head>
<body>
	<jsp:include page="adminHeader.jsp"></jsp:include>
	<jsp:include page="adminSidebar.jsp"></jsp:include>

	<div id="layoutSidenav_content">
		<form:form modelAttribute="accObj" action="adminRegister"
			method="post" class="needs-validation">
			<div class="mb-3">
				<label class="form-label">Name</label>
				<form:input path="name" class="form-control" />
				<form:errors path="name" class="text-danger" />
			</div>

			<div class="mb-3">
				<label class="form-label">Email</label>
				<form:input path="email" class="form-control" />
				<form:errors path="email" class="text-danger" />
			</div>

			<div class="mb-3">
				<label class="form-label">Password</label>
				<form:password path="password" class="form-control" />
				<form:errors path="password" class="text-danger" />
			</div>

			<div class="mb-3">
				<label class="form-label">Role</label>
				<form:select path="roleId" class="form-select" id="roleId"
					onchange="toggleCinemaField()">
					<form:options items="${roleList}" itemValue="id" itemLabel="name" />
				</form:select>
			</div>

			<div class="mb-3" id="cinemaField" style="display: none;">
				<label class="form-label">Assigned Cinema ID</label>
				<form:input path="assignedCinemaId" class="form-control" />
			</div>

			<button type="submit" class="btn btn-primary">Register</button>
		</form:form>
	</div>

	<script>
		function toggleCinemaField() {
			var role = document.getElementById("roleId").value;
			var cinemaField = document.getElementById("cinemaField");
			if (role == "2") {
				cinemaField.style.display = "block";
			} else {
				cinemaField.style.display = "none";
			}
		}
	</script>
</body>
</html>