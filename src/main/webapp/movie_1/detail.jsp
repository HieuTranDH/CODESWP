<%@include file="header_movie.jsp" %>

<section>
    <style>.comments-section {
            background-color: #333; /* Màu n?n */
            color: white;           /* Màu ch? */
        }

        .comment-item {
            background-color: #444; /* Màu n?n cho t?ng bình lu?n */
            border-radius: 5px;     /* Bo tròn các góc */
            margin-bottom: 15px;    /* Kho?ng cách gi?a các bình lu?n */
        }

        .comment-item strong {
            color: #ffc107;         /* Màu ch? cho tên ng??i dùng */
        }</style>

    <!----filter-search-box---->
    <div class="movie-card-section">
        <div class="card">
            <!-- Nhúng video YouTube -->
            <iframe width="100%" height="315" src="https://www.youtube.com/embed/xWgd2czwMG0" 
                    frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
            </iframe>

            <div class="card-content">
                <p class="movie-name" style="color:black">
                    ${movie.title} TRAILER
                </p>

            </div>
        </div>
    </div>
    <div class="comments-section">
        <h4>Comments:</h4>
        <ul class="list-group">
            <c:forEach var="rating" items="${movie.ratings}">
                <li class="list-group-item comment-item">
                    <div class="d-flex justify-content-between align-items-center">
                        <strong>${rating.customerName}</strong>
                        <span class="text-muted">${rating.ratingDate}</span>
                    </div>
                    <p class="mb-1">${rating.comment}</p>
                    <small class="text-secondary">Rating: ${rating.rating}</small>
                </li>
            </c:forEach>
        </ul>
    </div>


</section>
<%@include file="/include/footer.jsp" %>
