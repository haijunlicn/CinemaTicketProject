function confirmShowtimeDelete(button) {
    const showtimeId = button.getAttribute("data-id");

    // SweetAlert confirmation
    Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!',
    }).then((result) => {
        if (result.isConfirmed) {
            // Perform the delete action, e.g., make an AJAX request or redirect to a delete endpoint
            window.location.href = "/deleteShowtime/" + showtimeId;  // Replace with your delete URL
        }
    });
}
