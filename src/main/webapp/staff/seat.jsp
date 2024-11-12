<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.DAO.*" %>
<%@ page import="model.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                margin: 20px 0;
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
                padding: 10px;
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
            }

            .seat.selected {
                background-color: #90EE90; /* Màu xanh lá cây cho ghế đang chọn */
            }

            .seat.booked {
                background-color: #808080; /* Màu xám cho ghế đã đặt */
                pointer-events: none;
            }

            .delete-seat-btn {
                margin-top: 12px;
                margin-left: -4px;
                cursor: pointer;
                background-color: red;
                color: white;
                border: none;
                min-width: 40px;
            }

            /* Phần chú thích ghế */
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
        </style>
    </head>
    <body>  
        <c:set var="screenroom" value="${ScreeningRoom_DB.getScreeningRoomById(roomId)}" />
        <c:set var="seats" value="${Seat_DB.getAllSeatByRoomIDNone(roomId)}" />
        <!-- Nút quay lại --> 
        <div style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/staff/screenroom" class="btn btn-primary">Quay lại</a>
        </div>
        <h1>Room : ${screenroom.roomName}</h1>

        <div class="container" style="height: 60%">
            <div class="theater">
                <div class="screen">Màn Hình</div>
                <form id="seatForm" method="post" action="seat">
                    <input type="hidden" id="action" name="action" value="" />
                    <input type="hidden" id="seatId" name="seatId" value="" />
                    <input type="hidden" id="seatNumber" name="seatNumber" value="" />
                    <input type="hidden" id="roomid" name="roomid" value="${roomId}" />
                    <input type="hidden" id="seatType" name="seatType" value="standard" /> <!-- Loại ghế mặc định -->
                    <input type="hidden" id="seatPrice" name="seatPrice" value="50000" /> <!-- Giá mặc định -->

                    <div id="seat-map">
                        <c:forEach var="rowLetter" items="A,B,C,D,E,F,G,H,I">
                            <div class="seat-row" data-row="${rowLetter}">
                                <c:forEach var="seat" items="${seats}">
                                    <c:if test="${seat.seatNumber.startsWith(rowLetter)}">
                                        <div class="seat ${seat.seatType.toLowerCase()} ${seat.seatStatus.toLowerCase()}" title="${seat.seatNumber}" data-seat-id="${seat.seatId}" data-seat-number="${seat.seatNumber}">
                                            ${seat.seatNumber}
                                            <button class="delete-seat-btn" type="button" data-seat-id="${seat.seatId}">X</button>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <!-- Nút thêm ghế ở cuối mỗi hàng -->
                                <button class="add-seat-btn" type="button">+</button>
                            </div>
                        </c:forEach>
                    </div>
                </form>
            </div>
        </div>
        <!-- Phần chú thích ghế -->
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

        <script>
            const seatMap = document.getElementById('seat-map');
            const rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'];

            // Thêm ghế
            document.querySelectorAll('.add-seat-btn').forEach(addBtn => {
                addBtn.addEventListener('click', function () {
                    const row = this.closest('.seat-row');
                    const rowLetter = row.dataset.row;

                    // Lấy tất cả số ghế hiện có trong hàng
                    const existingSeats = Array.from(row.querySelectorAll('.seat')).map(seat => seat.dataset.seatNumber);

                    // Tìm số ghế bị trống
                    let seatNumber = null;
                    for (let i = 1; i <= existingSeats.length + 1; i++) {
                        if (!existingSeats.includes(rowLetter + i)) {
                            seatNumber = rowLetter + i;  // Lấp đầy ghế trống đầu tiên
                            break;
                        }
                    }

                    document.getElementById('seatNumber').value = seatNumber;
                    document.getElementById('action').value = 'add';

                    // Xác định loại ghế và giá dựa trên hàng ghế
                    if (['A', 'B', 'C', 'D', 'E'].includes(rowLetter)) {
                        document.getElementById('seatType').value = 'Standard';
                        document.getElementById('seatPrice').value = 50000;
                    } else if (['F', 'G', 'H'].includes(rowLetter)) {
                        document.getElementById('seatType').value = 'VIP';
                        document.getElementById('seatPrice').value = 70000;
                    } else if (rowLetter === 'I') {
                        document.getElementById('seatType').value = 'Couple';
                        document.getElementById('seatPrice').value = 100000;
                    }

                    document.getElementById('seatForm').submit();
                });
            });


            // Xóa ghếếế 
            document.querySelectorAll('.delete-seat-btn').forEach(deleteBtn => {
                deleteBtn.addEventListener('click', function () {
                    const seatId = this.getAttribute('data-seat-id');

                    document.getElementById('action').value = 'delete';
                    document.getElementById('seatId').value = seatId;
                    document.getElementById('seatForm').submit();
                });
            });
        </script>
    </body>




</html>
