<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.util.List"%>
<%@page import="model.Seat"%>
<%@include file="cinema/header_cinema.jsp" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đặt Ghế Rạp Chiếu Phim</title>

        <link rel="stylesheet" href="manhinh.css">
        <style>
            .theater {
                width: 80%;
                margin: 20px auto;
            }
            .screen {
                background-color: #ccc;
                width: 100%;
                text-align: center;
                padding: 10px;
                margin-bottom: 20px;
            }
            .seat-row {
                display: flex;
                justify-content: center;
                margin-bottom: 10px;
            }
            .seat {
                margin: 5px;
                cursor: pointer;
                text-align: center;
            }
            .seat.standard {
                background-color: #8B4513; /* Màu nâu cho ghế thường */
            }
            .seat.vip {
                background-color: #FFD700; /* Màu vàng cho ghế VIP */
            }
            .seat.couple {
                background-color: #FF69B4; /* Màu hồng cho ghế đôi */
                width: 60px;
            }
            .seat.selected {
                background-color: #90EE90; /* Màu xanh lá cây cho ghế đang chọn */
            }
            .seat.booked {
                background-color: #808080; /* Màu xám cho ghế đã đặt */
                pointer-events: none;
            }
            .legend {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }
            .legend-item {
                display: flex;
                align-items: center;
                margin: 0 10px;
            }
            .legend-color {
                width: 20px;
                height: 20px;
                margin-right: 5px;
            }
            .standard-color {
                background-color: #8B4513;
            }
            .vip-color {
                background-color: #FFD700;
            }
            .couple-color {
                background-color: #FF69B4;
            }
            .booked-color {
                background-color: #808080;
            }
            .info-panel {
                display: flex;
                margin-top: 20px;
                padding: 10px;
                border: 1px solid #ccc;
                justify-content: space-around;
            }
        </style>
    </head>
    <body>
        <h1>Đặt Ghế Rạp Chiếu Phim </h1>
        <!-- Thẻ thông báo lỗi -->
        <c:if test="${not empty errorMessage}">
            <div id="error-message" style="color: red;">
                ${errorMessage}
            </div>
        </c:if>
        <div class="container" style="height: 60%">
            <div class="theater">
                <div class="screen">Màn Hình</div>
                <div id="seat-map">
                    <c:if test="${not empty seats}">
                        <c:set var="currentRow" value="" />
                        <c:forEach items="${seats}" var="seat"> 
                            <c:set var="row" value="${seat.seatNumber.charAt(0)}" />
                            <c:if test="${not row.equals(currentRow)}">
                                <c:if test="${not empty currentRow}">
                                </div> <!-- Kết thúc hàng ghế trước -->
                            </c:if>
                            <div class="seat-row">
                                <c:set var="currentRow" value="${row}" />
                            </c:if>
                            <div class="seat ${seat.seatType.toLowerCase()} ${seat.seatStatus.toLowerCase()}" title="${seat.seatNumber}" data-price="${seat.seatPrice}" data-seat-id="${seat.seatId}">
                                ${seat.seatNumber}
                            </div>
                        </c:forEach>
                    </div> <!-- Kết thúc hàng ghế cuối cùng -->
                </c:if>
                <c:if test="${empty seats}">
                    <p>Không có ghế nào để hiển thị.</p>
                </c:if>
            </div>
        </div>
    </div>
    <div class="legend">
        <div class="legend-item">
            <div class="legend-color standard-color"></div>
            Ghế Thường
        </div>
        <div class="legend-item">
            <div class="legend-color vip-color"></div>
            Ghế VIP
        </div>
        <div class="legend-item">
            <div class="legend-color couple-color"></div>
            Ghế Đôi
        </div>
        <div class="legend-item">
            <div class="legend-color booked-color"></div>
            Ghế Đã Đặt
        </div>
    </div>
    <div class="info-panel">
        <div class="showtime-info">
            <h2>Thông Tin Buổi Chiếu</h2>
            <c:if test="${not empty seats}">
                <p><strong>Tên Phim:</strong> ${seats[0].movieTitle}</p>
                <p><strong>Rạp:</strong> ${seats[0].cinemaName}</p>
                <p><strong>Địa Chỉ:</strong> ${seats[0].cinemaAddress}</p>
                <p><strong>Thời Gian Bắt Đầu:</strong> ${seats[0].startTime}</p>
                <p><strong>Thời Gian Kết Thúc:</strong> ${seats[0].endTime}</p>
            </c:if>
        </div>
        <div class="booking-info">
            <h2>Bảng Thông Tin</h2>
            <p><strong>Tên Người Đặt: ${USER.name}</strong></p>
            <p><strong>Các ghế đã chọn:</strong> <span id="selected-seats"></span></p>
            <p><strong>Tổng Giá Vé:</strong> <span id="total-price">0.00 VNĐ</span></p>
            <button id="confirm-btn" style="height: 40px;width: 200px" disabled>Xác nhận đặt vé</button>
        </div>
    </div>

    <!-- Form để gửi dữ liệu -->
    <form id="booking-form" action="buyticket" method="POST">
        <input type="hidden" id="showtimeId" name="showtimeId" value="${showtimeId}">
        <input type="hidden" id="customerId" name="customerId" value="${USER.customerId}">
        <input type="hidden" id="promotionId" name="promotionId" value="1">
        <input type="hidden" id="comboId" name="comboId" value="1">
        <input type="hidden" id="totalPrice" name="totalPrice" value="">
        <input type="hidden" id="selectedSeats" name="selectedSeats" value="">
    </form>

    <script>
        // Khởi tạo biến để lưu ghế đã chọn và tổng giá vé
        let selectedSeats = []; // Mảng chứa các đối tượng ghế
        let totalPrice = 0;

        // Gắn sự kiện click cho các ghế
        document.addEventListener('DOMContentLoaded', () => {
            const seatElements = document.querySelectorAll('.seat');
            seatElements.forEach(seat => {
                seat.addEventListener('click', () => handleSeatClick(seat));
            });

            // Thêm sự kiện cho nút xác nhận
            document.getElementById('confirm-btn').addEventListener('click', confirmBooking);
        });

        // Hàm để cập nhật thông tin ghế đã chọn
        function updateSelectedSeats() {
            const selectedSeatsElement = document.getElementById('selected-seats');
            const seatNumbers = selectedSeats.map(seat => seat.seatNumber); // Lấy số ghế từ các đối tượng trong mảng
            selectedSeatsElement.textContent = seatNumbers.join(', '); // Hiển thị số ghế

            // Cập nhật giá vé
            const totalPriceElement = document.getElementById('total-price');
            totalPriceElement.textContent = totalPrice.toFixed(2) + ' VNĐ';

            // Kích hoạt hoặc hủy kích hoạt nút xác nhận
            const confirmBtn = document.getElementById('confirm-btn');
            confirmBtn.disabled = selectedSeats.length === 0;

            console.log("Ghế đã chọn:", seatNumbers);
            console.log("Giá tổng:", totalPrice.toFixed(2) + ' VNĐ');
        }

        // Hàm xử lý sự kiện khi nhấp vào ghế
        function handleSeatClick(seat) {
            const seatId = seat.getAttribute('data-seat-id'); // Lấy seatId từ thuộc tính data-seat-id
            const seatNumber = seat.getAttribute('title');
            const seatPrice = parseFloat(seat.dataset.price); // Lấy giá ghế từ thuộc tính data-price

            console.log(`Nhấp vào ghế: ${seatNumber}, ID: ${seatId}, Giá: ${seatPrice} VNĐ`);

            // Nếu ghế đã đặt, không làm gì cả
            if (seat.classList.contains('booked')) {
                console.log(`Ghế ${seatNumber} đã đặt. Không thể chọn.`);
                return;
            }

            // Kiểm tra nếu ghế đã được chọn
            const selectedSeatIndex = selectedSeats.findIndex(s => s.seatId === seatId);
            if (selectedSeatIndex !== -1) {
                // Nếu đã chọn, bỏ chọn ghế
                selectedSeats.splice(selectedSeatIndex, 1); // Bỏ chọn ghế
                totalPrice -= seatPrice; // Giảm giá vé
                seat.classList.remove('selected');
            } else {
                // Nếu chưa chọn, thêm ghế vào danh sách đã chọn
                selectedSeats.push({seatId, seatNumber}); // Thêm đối tượng ghế vào danh sách đã chọn
                totalPrice += seatPrice; // Tăng giá vé
                seat.classList.add('selected');
            }

            // Cập nhật thông tin ghế đã chọn
            updateSelectedSeats();
        }

// Hàm xác nhận đặt vé
        function confirmBooking() {
            // Cập nhật các giá trị ẩn trong form
            document.getElementById('totalPrice').value = totalPrice.toFixed(2); // Cập nhật tổng giá vé
            document.getElementById('selectedSeats').value = selectedSeats.map(s => s.seatId).join(','); // Cập nhật ID ghế đã chọn

            // Gửi form
            document.getElementById('booking-form').submit();
        }
        // Hàm xác nhận đặt vé
        function confirmBooking() {
            // Cập nhật các giá trị ẩn trong form
            document.getElementById('totalPrice').value = totalPrice.toFixed(2); // Cập nhật tổng giá vé
            document.getElementById('selectedSeats').value = selectedSeats.map(s => s.seatId).join(','); // Cập nhật ID ghế đã chọn

            // Gửi form
            document.getElementById('booking-form').submit();
            const submitUrl = $("#booking-form").attr("action");
            $.ajax({
                type: "POST",
                url: submitUrl,
                data: postData,
                dataType: 'JSON',
                success: function (x) {
                    if (x.code === '00') {
                        if (window.vnpay) {
                            vnpay.open({width: 768, height: 600, url: x.data});
                        } else {
                            location.href = x.data;
                        }
                        return false;
                    } else {
                        alert(x.Message);
                    }
                }
            });
        }
    </script>

    <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
    <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>



</body>


</html>
<%@include file="include/footer.jsp" %>