
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <c:forEach var="ticket" items="${ticketList}">
            <div class="col-md-4 mb-3">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="card-title">Mã vé: ${ticket.ticketId}</h5>

                        <p class="card-text">
                            <strong>Tên khách hàng:</strong> ${ticket.customerName}<br>
                            <strong>Phim:</strong> ${ticket.movieTitle}<br>
                            <strong>Phòng chiếu:</strong> ${ticket.screeningRoom}<br>
                            <strong>Số ghế:</strong> 
                            <c:forEach var="seat" items="${ticket.seatNames}" varStatus="status">
                                ${seat}<c:if test="${!status.last}">, </c:if>
                            </c:forEach><br>

                            <strong>Giá vé:</strong> ${ticket.price} VND<br>
                            <strong>Giờ chiếu:</strong> ${ticket.showtimeStart}<br>
                            <strong>Trạng thái:</strong> ${ticket.status}
                        </p>

                        <c:choose>
                            <c:when test="${ticket.status == 'CheckedIn'}">
                                <button class="btn btn-secondary btn-block" disabled>Đã Check-in</button>
                            </c:when>
                            <c:otherwise>
                                <form method="post" action="${pageContext.request.contextPath}/staff/ticketManagement">
                                    <input type="hidden" name="ticketId" value="${ticket.ticketId}">
                                    <button type="submit" class="btn btn-success btn-block">Check-in</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
