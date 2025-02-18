<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Seats</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.seat {
	width: 5rem;
	height: 8rem;
	border-radius: 5px;
	text-align: center;
	line-height: 2rem;
	font-weight: bold;
}

.available {
	background-color: #0d6efd;
	color: white;
}

.empty {
	background-color: #ccc;
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="text-center my-4">Cinema Seat Layout</h2>

		<div class="container">
			<div class="row justify-content-center">

				<c:forEach var="row" begin="1" end="${maxRow}">
					<div class="col-12 d-flex align-items-center mb-2">
						<!-- Row Label -->
						<span class="me-2 fw-bold text-nowrap">Row ${row}</span>

						<div class="seat-row d-flex justify-content-between w-100">
							<c:forEach var="seat" items="${seatList}">
								<c:if test="${seat.row == row}">
									<div class="seat available text-center me-2"
										${seat.seatTypeId == 2 ? 'style="width: 10rem;"' : ''}>
										${seat.seatNum}</div>
								</c:if>
							</c:forEach>
						</div>

						<!-- Add Seat Button -->
						<button class="btn btn-sm btn-primary ms-3">+</button>
					</div>
				</c:forEach>

				<!-- Add Row Button -->
				<button id="addRowBtn" class="btn btn-primary w-100 mt-3">Add
					Row</button>
			</div>
		</div>

	</div>

	<script>
    // Get the "Add Row" button
    const addRowBtn = document.getElementById("addRowBtn");

    // Add an event listener to the button
    addRowBtn.addEventListener("click", function() {
        // Get the container where rows will be added
        const container = document.querySelector('.row.justify-content-center');

        // Get the current row count to add a new row with the correct label
        const currentRowCount = document.querySelectorAll('.seat-row').length;

        // Create a new row container
        const newRow = document.createElement("div");
        newRow.classList.add("col-12", "d-flex", "align-items-center", "mb-2");

        // Add the row label (Row number)
        const rowLabel = document.createElement("span");
        rowLabel.classList.add("me-2", "fw-bold", "text-nowrap");
        rowLabel.textContent = `Row ${currentRowCount + 1}`;
        newRow.appendChild(rowLabel);

        // Create the seat-row div to contain the seats in this row
        const seatRow = document.createElement("div");
        seatRow.classList.add("seat-row", "d-flex", "justify-content-between", "w-100");

        // Add seats dynamically (assuming the cinemaObj.colCount is available)
        for (let col = 1; col <= ${cinemaObj.colCount};) {
            const seat = document.createElement("div");
            seat.classList.add("seat", "available", "text-center", "me-2");
            seat.style.width = "5rem";  // Fixed width for seats
            seat.style.height = "8rem"; // Fixed height for seats
            seat.textContent = `${currentRowCount + 1}${col}`; // Seat label: row+col
            seatRow.appendChild(seat);
        }

        // Add the seat-row div to the new row container
        newRow.appendChild(seatRow);

        // Add the row to the container
        container.appendChild(newRow);
    });
</script>


</body>
</html>
