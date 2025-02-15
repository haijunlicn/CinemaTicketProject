<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<style type="text/css">
p {
	color: red;
}
</style>

</head>
<body>

	<div class="container">
		<form:form modelAttribute="accObj"
			class="bg-dark bg-opacity-10 rounded-3 col-lg-5 mx-auto mt-4 px-5 pt-2 pb-4"
			action="login" method="post">

			<div class="mb-3 mt-3">
				<label for="email" class="form-label">Email:</label>
				<form:input path="email" name="email" id="email"
					class="form-control formInput" placeholder="Enter email" />
			</div>

			<div class="mb-3 mt-3">
				<label for="password" class="form-label">Password:</label>
				<form:password path="password" name="password" id="password"
					class="form-control formInput" placeholder="Enter password" />
			</div>

			<p class="text-danger">${error}</p>

			<button type="submit" class="btn btn-outline-dark w-100 mt-4 mb-2">Login</button>
		</form:form>
	</div>
</body>
</html>