<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <h1>Đặt Ghế Rạp Chiếu Phim</h1>

        <div class="container">
            <div class="theater">
                <div class="screen">Màn Hình</div>
                <div id="seat-map">
                    <!-- Ghế sẽ được tạo tự động bằng JavaScript -->
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
            </div>

            <div class="info-panel">
                <h2>Bảng Thông Tin</h2>
                <div class="info-item">
                    <strong>Các ghế đã chọn:</strong> <span id="selected-seats"></span>
                </div>
                <button id="confirm-btn" style="height: 30px" disabled>Xác nhận đặt vé</button>
            </div>


        </div>

        <script src="manhinh.js"></script>
    </body>
</html>
