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
</style>
</head>
<body>
	<div class="container">
		<h2 class="text-center my-4">Cinema Seat Layout</h2>
		<table id="seatTable" class="table table-bordered text-center">
			<thead>
				<tr>
					<th></th>
					<!-- Empty top-left corner -->
					<c:forEach var="col" begin="1" end="${maxCol}">
						<th>Col ${col}</th>
					</c:forEach>
					<th></th>
					<!-- Empty space for alignment -->
				</tr>
			</thead>

			<tbody id="seatTableBody">
				<c:forEach var="row" begin="1" end="${maxRow}">
					<tr>
						<th>Row ${row}</th>

						<c:forEach var="col" begin="1" end="${maxCol}">
							<c:set var="seatExists" value="false" />
							<c:set var="seatMerged" value="false" />

							<c:forEach var="seat" items="${seatList}">
								<c:if test="${seat.row == row && seat.col == col}">
									<td class="seat available"
										${seat.seatType == 2 ? 'colspan="2"' : ''}>${seat.seatNum}
									</td>
									<c:set var="seatMerged" value="true" />
									<c:set var="seatExists" value="true" />
								</c:if>
							</c:forEach>

							<c:if test="${!seatExists}">
								<td></td>
							</c:if>

							<c:if test="${seatMerged}">
								<c:set var="col" value="${col + 1}" />
							</c:if>
						</c:forEach>

						<th><button class="btn btn-primary">+</button></th>
					</tr>
				</c:forEach>

				<tr>
					<td colspan="${maxCol + 2}">
						<button id="addRowBtn" class="btn btn-primary w-100">Add
							Row</button>
					</td>
				</tr>
			</tbody>


			<%-- <tbody id="seatTableBody">
				<c:forEach var="row" begin="1" end="${maxRow}">
					<tr>
						<th>Row ${row}</th>

						<!-- Loop through all columns for this row -->
						<c:forEach var="col" begin="1" end="${maxCol}">
							<c:set var="seatExists" value="false" />
							<c:set var="seatMerged" value="false" />

							<c:forEach var="seat" items="${seatList}">

								<!-- Check if this seat belongs to the current row and column -->
								<c:if test="${seat.row == row && seat.col == col}">
									<!-- Render the seat if it exists for this row and column -->
									<c:if test="${seat.seatType == 2}">
										<td class="seat available" colspan="2">${seat.seatNum}</td>
										<c:set var="seatMerged" value="true" />
									</c:if>
									<c:if test="${seat.seatType != 2}">
										<td class="seat available">${seat.seatNum}</td>
										<c:set var="seatMerged" value="false" />
									</c:if>

									<c:set var="seatExists" value="true" />
								</c:if>

							</c:forEach>

							<!-- If no seat exists for this row and col, render an empty td -->
							<c:if test="${seatExists == false}">
								<td><button class="btn btn-primary">+</button></td>
							</c:if>

						</c:forEach>

						<!-- Plus sign button at the end of each row -->
						<th>
							<button class="btn btn-primary">+</button>
						</th>
					</tr>
				</c:forEach>

				<!-- Button to add a new row (this appears after the last row) -->
				<tr>
					<td colspan="${maxCol + 2}">
						<button id="addRowBtn" class="btn btn-primary w-100">Add
							Row</button>
					</td>
				</tr>
			</tbody> --%>

		</table>

	</div>
	<script>
    // Get the "Add Row" button
    const addRowBtn = document.getElementById("addRowBtn");

    // Add an event listener to the button
    addRowBtn.addEventListener("click", function() {
        // Get the table body where rows will be added
        const tbody = document.getElementById("seatTableBody");

        // Get the current row count to add a new row with the correct label
        const currentRowCount = tbody.rows.length - 1; // Subtract 1 to ignore the button row

        // Create a new row
        const newRow = document.createElement("tr");

        // Add the row header with the row number
        const rowHeader = document.createElement("th");
        rowHeader.textContent = `Row ${currentRowCount + 1}`;
        newRow.appendChild(rowHeader);

        // Add the seat columns dynamically based on the colCount
        for (let col = 1; col <= ${cinemaObj.colCount}; col++) {
            const newCell = document.createElement("td");
            newCell.classList.add("seat", "available");
            newCell.textContent = `${currentRowCount + 1}${col}`;  // Seat label: row+col
            newRow.appendChild(newCell);
        }

        // Add the plus sign button to the end of the row
        const plusSignCell = document.createElement("th");
        const plusSignBtn = document.createElement("button");
        plusSignBtn.classList.add("btn", "btn-primary");
        plusSignBtn.textContent = "+";
        plusSignCell.appendChild(plusSignBtn);
        newRow.appendChild(plusSignCell);

        // Insert the new row above the button row (before the last row)
        tbody.insertBefore(newRow, tbody.lastElementChild);
    })
</script>
</body>
</html>
