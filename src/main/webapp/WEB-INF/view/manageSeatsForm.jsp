<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Seats</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .seat {
            width: 40px; /* Width of the seat */
            height: 40px; /* Height of the seat */
            border-radius: 12px; /* Rounded corners */
            background-color: #f0f0f0; /* Light gray background */
            border: 1px solid #ccc; /* Border for better visibility */
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            font-size: 16px;
        }

        .seat:hover {
            background-color: #d3e4f1; /* Light blue on hover */
        }

        .seat .bi-person-fill {
            font-size: 18px;
            color: #007bff; /* Icon color */
        }

        .seat-row {
            display: flex;
            justify-content: center;
            margin-bottom: 7px; /* Walking space between rows */
        }

        .seat-row .seat {
            margin-right: 4px; /* Default margin between seats in the same row */
        }

        .seat-row .seat:last-child {
            margin-right: 0; /* No margin on the last seat */
        }

        /* Add margin for every 3 columns */
        .seat-row .seat:nth-child(3n) {
            margin-right: 30px; /* Add space after every 3rd seat */
        }

        /* Add margin for every 3 rows */
        .seat-row:nth-child(3n) {
            margin-bottom: 40px; /* Add space after every 3rd row */
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <h3 class="text-center mb-4">Manage Cinema Seating</h3>

    <!-- Seating Form -->
    <div class="mb-4">
        <label for="rowCount" class="form-label">Number of Rows</label>
        <div class="d-flex align-items-center">
            <input type="number" id="rowCount" class="form-control me-2" value="1" min="1" readonly>
            <button id="addRow" class="btn btn-success"><i class="bi bi-plus-lg"></i> Add Row</button>
        </div>
    </div>

    <!-- Seating Rows Container -->
    <div id="seatingContainer">
        <!-- Rows will be appended here -->
        <div class="seat-row" id="row1">
            <div class="seat">
                <i class="bi bi-person-fill"></i>
            </div>
        </div>
    </div>

    <div class="mb-4">
        <label for="colCount" class="form-label">Number of Columns</label>
        <div class="d-flex align-items-center">
            <input type="number" id="colCount" class="form-control me-2" value="1" min="1" readonly>
            <button id="addColumn" class="btn btn-primary"><i class="bi bi-plus-lg"></i> Add Column</button>
        </div>
    </div>

    <div class="text-center mt-4">
        <button class="btn btn-primary">Save Seating Layout</button>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initial seat count
    let rowCount = 1;
    let colCount = 1;

    // Add Row Functionality
    document.getElementById("addRow").addEventListener("click", function() {
        rowCount++;
        document.getElementById("rowCount").value = rowCount;

        // Create new row
        const newRow = document.createElement("div");
        newRow.classList.add("seat-row");
        newRow.id = `row${rowCount}`;

        // Add seats to the new row based on current column count
        for (let i = 1; i <= colCount; i++) {
            const newSeat = document.createElement("div");
            newSeat.classList.add("seat");
            newSeat.innerHTML = '<i class="bi bi-person-fill"></i>';
            newRow.appendChild(newSeat);
        }

        // Append the new row to the seating container
        document.getElementById("seatingContainer").appendChild(newRow);
    });

    // Add Column Functionality
    document.getElementById("addColumn").addEventListener("click", function() {
        colCount++;
        document.getElementById("colCount").value = colCount;

        // Add a new seat to each existing row
        const rows = document.getElementsByClassName("seat-row");
        for (let i = 0; i < rows.length; i++) {
            const newSeat = document.createElement("div");
            newSeat.classList.add("seat");
            newSeat.innerHTML = '<i class="bi bi-person-fill"></i>';
            rows[i].appendChild(newSeat);
        }
    });
</script>

</body>
</html>