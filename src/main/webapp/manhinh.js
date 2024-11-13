const seatMap = document.getElementById('seat-map');
const rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I']; // Hàng ghế từ A đến I
const seatsPerRow = 10; // Số ghế mỗi hàng

rows.forEach(rowLetter => {
    const seatRow = document.createElement('div');
    seatRow.classList.add('seat-row');
    seatRow.dataset.row = rowLetter;



    for (let i = 1; i <= seatsPerRow; i++) {
        const seat = document.createElement('div');
        seat.classList.add('seat', seatType);
        seat.dataset.seatNumber = rowLetter + i; // Tạo tên ghế (A1, A2,...)
        seat.textContent = rowLetter + i;

        // Thêm sự kiện khi nhấn vào ghế
        handleSeatClick(seat);

        // Thêm nút xóa vào ghế
        addDeleteButton(seat);

        // Thêm ghế vào hàng ghế
        seatRow.appendChild(seat);
    }

    // Thêm nút thêm ghế ở cuối hàng
    const addSeatBtn = document.createElement('button');
    addSeatBtn.textContent = '+';
    addSeatBtn.classList.add('add-seat-btn');
    seatRow.appendChild(addSeatBtn);

    // Thêm sự kiện để thêm ghế
    addSeatBtn.addEventListener('click', function () {
        const seatCount = seatRow.querySelectorAll('.seat').length + 1;
        const seat = document.createElement('div');
        seat.classList.add('seat', seatType);
        seat.dataset.seatNumber = rowLetter + seatCount;
        seat.textContent = rowLetter + seatCount;

        // Thêm sự kiện click và nút xóa cho ghế mới
        handleSeatClick(seat);
        addDeleteButton(seat);

        // Chèn ghế mới trước nút thêm
        seatRow.insertBefore(seat, addSeatBtn);
    });

    // Thêm hàng ghế vào bản đồ ghế
    seatMap.appendChild(seatRow);
});

// Hàm xử lý khi nhấn vào ghế (chọn hoặc bỏ chọn ghế)
function handleSeatClick(seat) {
    seat.addEventListener('click', () => {
        if (!seat.classList.contains('booked')) {
            seat.classList.toggle('selected');
            updateSelectedSeats();
            updateConfirmButton();
        }
    });
}

// Hàm xử lý thêm nút xóa cho ghế
function addDeleteButton(seat) {
    const deleteBtn = document.createElement('button');
    deleteBtn.textContent = 'X';
    deleteBtn.classList.add('delete-seat-btn');
    seat.appendChild(deleteBtn);

    // Gắn sự kiện click cho nút xóa
    deleteBtn.addEventListener('click', function () {
        seat.remove();
        updateSelectedSeats();
        updateConfirmButton();
    });
}

// Hàm cập nhật danh sách ghế đã chọn
function updateSelectedSeats() {
    const selectedSeats = Array.from(document.querySelectorAll('.seat.selected'))
            .map(seat => seat.dataset.seatNumber);
    document.getElementById('selected-seats').textContent = selectedSeats.join(', ') || 'Chưa chọn ghế';
}

// Hàm cập nhật trạng thái của nút xác nhận
function updateConfirmButton() {
    const selectedSeats = document.querySelectorAll('.seat.selected').length;
    document.getElementById('confirm-btn').disabled = selectedSeats === 0;
}

// Xác nhận đặt vé
document.getElementById('confirm-btn').addEventListener('click', () => {
    const selectedSeats = Array.from(document.querySelectorAll('.seat.selected'))
            .map(seat => seat.dataset.seatNumber);
    alert("Bạn đã chọn các ghế: " + selectedSeats.join(', '));

    // Sau khi xác nhận, đổi ghế đã chọn thành ghế đã đặt
    document.querySelectorAll('.seat.selected').forEach(seat => {
        seat.classList.remove('selected');
        seat.classList.add('booked');
    });

    // Cập nhật lại danh sách ghế và nút xác nhận
    updateSelectedSeats();
    updateConfirmButton();
});
