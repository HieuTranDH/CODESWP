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
            <p><strong>Giá ghế:</strong> <span id="price-seats"></span></p>

            <div class="combo-selection">
                <h2>Chọn Combo</h2>
                <label for="combo">Combo: </label>
                <select id="combo" name="combo">
                    <option value="" data-price="0">Không chọn combo</option>
                    <c:forEach var="combo" items="${combos}">
                        <option value="${combo.comboId}" data-price="${combo.comboPrice}">${combo.comboName} - ${combo.comboPrice} VNĐ</option>
                    </c:forEach>
                </select>
                <c:forEach var="combo" items="${combos}">
                    <p id="combo-description-${combo.comboId}" class="combo-description" style="display: none;">
                        ${combo.description}
                    </p>
                </c:forEach>
            </div>


            <div class="promotion-selection">
                <h2>Chọn Khuyến Mãi</h2>
                <label for="promotion">Khuyến Mãi: </label>
                <select id="promotion" name="promotion">
                    <option value="">Không chọn khuyến mãi</option>
                    <c:forEach var="promotion" items="${promotions}">
                        <option value="${promotion.promotionId}" 
                                data-min-tickets="${promotion.minTicketQuantity}" 
                                data-discount-percentage="${promotion.discountPercentage}" 
                                data-max-discount="${promotion.maxDiscountAmount}">
                            ${promotion.promotionId} - ${promotion.promotionCode} - Giảm ${promotion.discountPercentage}% (Tối đa ${promotion.maxDiscountAmount} VNĐ)
                        </option>
                    </c:forEach>
                </select>
                <p id="error" style="color: red;"></p> <!-- Thêm style cho thông báo lỗi -->
            </div>


            <p><strong>Tổng Giá Vé:</strong> <span id="total-price">0.00 VNĐ</span></p>
            <button id="confirm-btn" style="height: 40px; width: 200px;" disabled>Xác nhận đặt vé</button>
        </div>
    </div>

    <!-- Form để gửi dữ liệu -->
    <form id="booking-form" action="buyticket" method="POST">
        <input type="hidden" id="showtimeId" name="showtimeId" value="${showtimeId}">
        <input type="hidden" id="customerId" name="customerId" value="${USER.customerId}">
        <input type="hidden" id="selectedPromotionId" name="selectedPromotionId" value="">
        <input type="hidden" id="comboId" name="comboId" value="">
        <input type="hidden" id="totalPrice" name="totalPrice" value="">
        <input type="hidden" id="selectedSeats" name="selectedSeats" value="">
    </form>

    <script>
        let selectedSeats = []; // Mảng chứa các đối tượng ghế
        let totalPrice = 0;

        $(document).ready(function () {
            // Thiết lập các sự kiện khi tài liệu được tải
            $('.seat').on('click', function () {
                handleSeatClick($(this)); // Sử dụng jQuery để lấy ghế
            });

            $('#combo').on('change', handleComboChange);
            $('#promotion').on('change', handlePromotionChange);
            $('#confirm-btn').on('click', confirmBooking);

            // Sự kiện khi thay đổi combo để hiển thị mô tả combo
            $('#combo').on('change', function () {
                // Ẩn tất cả các mô tả combo
                $('.combo-description').hide();

                // Hiển thị mô tả tương ứng với combo được chọn
                const selectedComboId = $(this).val();
                $('#combo-description-' + selectedComboId).show();
            });
        });

        function handleComboChange() {
            updateTotalPrice(); // Cập nhật tổng giá sau khi chọn combo
        }

        function handlePromotionChange() {
            const selectedPromotion = $('#promotion option:selected');

            // Cập nhật ID khuyến mãi
            $('#selectedPromotionId').val(selectedPromotion.val());

            updateTotalPrice(); // Cập nhật tổng giá sau khi chọn khuyến mãi
        }

        function updateTotalPrice() {
            // Tính tổng giá ghế đã chọn
            totalPrice = selectedSeats.reduce((sum, seat) => sum + seat.seatPrice, 0);

            // Cập nhật giá combo
            const selectedComboPrice = parseFloat($('#combo option:selected').data('price'));
            totalPrice += selectedComboPrice; // Thêm giá combo

            // Tính toán giảm giá nếu có khuyến mãi
            const selectedPromotion = $('#promotion option:selected');

            const errorElement = $('#error');
            errorElement.text(''); // Xóa thông báo lỗi

            if (selectedPromotion.val()) {
                const minTickets = parseInt(selectedPromotion.data('min-tickets'));
                const discountPercentage = parseFloat(selectedPromotion.data('discount-percentage'));
                const maxDiscount = parseFloat(selectedPromotion.data('max-discount'));

                if (selectedSeats.length >= minTickets) {
                    const discountAmount = (totalPrice * discountPercentage) / 100;
                    const finalDiscount = Math.min(discountAmount, maxDiscount);
                    totalPrice -= finalDiscount; // Cập nhật tổng giá vé sau khi áp dụng giảm giá
                } else {
                    const errorMessage = 'Không đủ ghế để áp dụng khuyến mãi ' + selectedPromotion.val() + '. Cần ít nhất ' + minTickets + ' ghế.';
                    errorElement.text(errorMessage); // Hiển thị thông báo lỗi
                    $('#promotion').val(''); // Đặt lại khuyến mãi
                    $('#selectedPromotionId').val(''); // Đặt lại ID khuyến mãi
                }
            } else {
                $('#selectedPromotionId').val(''); // Đặt lại ID khuyến mãi
            }

            updateDisplayedTotalPrice(); // Cập nhật lại tổng giá vé trên giao diện
            toggleConfirmButton(); // Kiểm tra và cập nhật trạng thái nút xác nhận
        }

        function updateDisplayedTotalPrice() {
            $('#total-price').text(totalPrice.toFixed(2) + ' VNĐ'); // Hiển thị tổng giá
        }

        function toggleConfirmButton() {
            $('#confirm-btn').prop('disabled', selectedSeats.length === 0); // Kích hoạt hoặc hủy kích hoạt nút xác nhận
        }

        function updateSelectedSeats() {
            const seatNumbers = selectedSeats.map(seat => seat.seatNumber);
            const seatPrices = selectedSeats.map(seat => seat.seatPrice);

            $('#selected-seats').text(seatNumbers.join(', ')); // Hiển thị số ghế
            $('#price-seats').text(seatPrices.join(', ')); // Hiển thị giá ghế

            updateTotalPrice(); // Gọi hàm tính toán tổng giá mới
        }

        function handleSeatClick(seat) {
            const seatId = seat.data('seat-id'); // Lấy seatId từ thuộc tính data-seat-id
            const seatNumber = seat.attr('title');
            const seatPrice = parseFloat(seat.data('price')); // Lấy giá ghế từ thuộc tính data-price

            if (seat.hasClass('booked')) {
                console.log(`Ghế ${seatNumber} đã đặt. Không thể chọn.`);
                return;
            }

            const selectedSeatIndex = selectedSeats.findIndex(s => s.seatId === seatId);
            if (selectedSeatIndex !== -1) {
                // Nếu đã chọn, bỏ chọn ghế
                selectedSeats.splice(selectedSeatIndex, 1); // Bỏ chọn ghế
                seat.removeClass('selected');
            } else {
                // Nếu chưa chọn, thêm ghế vào danh sách đã chọn
                selectedSeats.push({seatId, seatNumber, seatPrice});
                seat.addClass('selected');
            }

            updateSelectedSeats(); // Cập nhật thông tin ghế đã chọn
            toggleConfirmButton(); // Cập nhật trạng thái nút xác nhận sau khi thay đổi ghế
        }

        function confirmBooking() {
            // Cập nhật các giá trị ẩn trong form
            $('#totalPrice').val(totalPrice.toFixed(2)); // Cập nhật tổng giá vé
            $('#comboId').val($('#combo').val()); // Cập nhật combo đã chọn
            $('#selectedSeats').val(selectedSeats.map(s => s.seatId).join(',')); // Cập nhật ID ghế đã chọn

            $('#booking-form').submit(); // Gửi form
        }
    </script>



    <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
    <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>



</body>


</html>
<%@include file="include/footer.jsp" %>