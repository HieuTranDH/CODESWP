<%@include file="header_user.jsp" %>
<style>
    .container {
        background-color: black;
        padding: 30px; /* Thêm kho?ng cách bên trong */
        border-radius: 10px; /* Bo góc cho container */
    }
    .container.container1 {
        max-width: 100%;
    }
    h2 {
        color: white; /* ??i màu ch? tiêu ?? */
    }
    .table {
        background-color: white; /* Màu n?n cho b?ng */
    }
    .table th {
        background-color: #007bff; /* Màu n?n cho tiêu ?? b?ng */
        color: white; /* Màu ch? cho tiêu ?? b?ng */
    }
    .table td {
        height: 60px;
    }
</style>

<section style="min-height: 500px; background-color: black">
    <div class="container container1">
        <h2 class="text-center mb-4">Booking History</h2>

        <div class="booking-history">
            <table class="table table-bordered table-striped">
                <thead class="thead-light">
                    <tr>
                        <th>Ticket Code</th>
                        <th>Movie Title</th>
                        <th>Cinema Name</th>
                        <th>Screening Room</th>
                        <th>Seat Number</th>
                        <th>Ticket Price</th>
                        <th>Showtime</th>
                        <th>Purchase Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ticket" items="${ticketDetails}">
                        <tr>
                            <td>${ticket.ticketId}</td>
                            <td>${ticket.movieTitle}</td>
                            <td>${ticket.cinemaName}</td>
                            <td>${ticket.screeningRoom}</td>
                            <td>
                                <c:if test="${not empty ticket.seatNames}">
                                    <c:forEach var="seat" items="${ticket.seatNames}">
                                        ${seat}<c:if test="${not empty seat}">, </c:if>
                                    </c:forEach>
                                </c:if>
                            </td>
                            <td>${ticket.price}</td>
                            <td>${ticket.showtimeStart}</td>
                            <td>${ticket.purchaseDate}</td>
                            <td>
                                <c:if test="${ticket.status != 'CheckedIn'}">
                                    ${ticket.status}
                                </c:if>
                                <c:if test="${ticket.status == 'CheckedIn'}">
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#rateModal${ticket.ticketId}">
                                        Rate
                                    </button>
                                </c:if>
                            </td>
                        </tr>

                        <!-- Modal for rating -->
                    <div class="modal fade" id="rateModal${ticket.ticketId}" tabindex="-1" role="dialog" aria-labelledby="rateModalLabel${ticket.ticketId}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="rateModalLabel${ticket.ticketId}">Rate Movie: ${ticket.movieTitle}</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="submitRating" method="POST">
                                        <!-- Ticket ID hidden input -->
                                        <input type="hidden" name="movieId" value="${ticket.movieId}">
                                        <!-- Rating input (1-9) -->
                                        <div class="form-group">
                                            <label for="rating${ticket.ticketId}">Rating (1-9):</label>
                                            <input type="number" class="form-control" id="rating${ticket.ticketId}" name="rating" min="1" max="9" required>
                                            <small id="ratingError${ticket.ticketId}" class="form-text text-danger" style="display: none;">Rating must be between 1 and 10</small>
                                        </div>
                                        <!-- Comment input -->
                                        <div class="form-group">
                                            <label for="comment${ticket.ticketId}">Comment:</label>
                                            <textarea class="form-control" id="comment${ticket.ticketId}" name="comment" rows="3" required></textarea>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>

<%@include file="../include/footer.jsp" %>
