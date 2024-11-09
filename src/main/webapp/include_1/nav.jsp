<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="static/css/index.css">
    <link rel="stylesheet" href="../static/css/index.css">
</head>
<nav>
    <p onclick="window.location.href = '${pageContext.request.contextPath}/main';" style="cursor:pointer;"  class="logo">
        FCM<span  style="color:red;">FPTCinemamovie</span>
    </p>
    <i class="fa fa-bars" id="menu"></i>
    <ul id="menu-box">
        <li onclick="window.location.href = '${pageContext.request.contextPath}/main';" style="cursor:pointer;">main</li>
        <li onclick="window.location.href = '${pageContext.request.contextPath}/cinema';" style="cursor:pointer;">theater</li>
        <!-- Search Bar for Movies -->
        <li>
            <form id="search-form" action="${pageContext.request.contextPath}/searchMovie" method="GET" style="display:inline;">
                <input type="text" name="query" id="search-bar" placeholder="Search movies..." class="search-bar" style="padding:5px; width: 200px; border-radius:4px;">
                <div id="dropdown-results" class="dropdown-menu" style="width: 200px; display: none;"></div> <!-- Cập nhật width -->
            </form>
        </li>
        <c:choose>
            <c:when test="${not empty USER}">
                <li onclick="window.location.href = '${pageContext.request.contextPath}/profile';" style="cursor:pointer;">
                    <span>${USER.name} 
                        <img src="${USER.avatar}" style="border-radius:50%; width:30px; height:30px;"> 
                        <i class="fa fa-angle-down"></i>
                    </span>
                </li>
                <li onclick="window.location.href = '${pageContext.request.contextPath}/logout';" style="cursor:pointer;">
                    <b>Sign Out</b>
                </li>
            </c:when>
            <c:otherwise>
                <li onclick="window.location.href = '${pageContext.request.contextPath}/login?value=login';" style="cursor:pointer;">
                    Login
                </li>
                <li onclick="window.location.href = '${pageContext.request.contextPath}/register';" style="cursor:pointer;">
                    Register
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>

<div id="search-results"></div>

<style>
    nav {
        display: flex;
        align-items: center;
        justify-content: space-between;
        background-color: #1a1a1a;
        padding: 10px 20px;
    }

    .logo {
        font-size: 24px;
        font-weight: bold;
        color: white;
    }

    ul {
        list-style-type: none;
        display: flex;
        align-items: center;
        margin: 0;
        padding: 0;
    }

    li {
        margin-right: 20px;
        color: white;
        cursor: pointer;
    }

    .search-bar {
        background-color: white;
        border: 1px solid #ccc;
        padding: 5px 10px;
        border-radius: 4px;
        outline: none;
        width: 200px; /* Đảm bảo độ rộng cố định */
    }

    .dropdown-menu {
        position: absolute;
        z-index: 1000;
        background-color: white; /* Màu nền dropdown sáng hơn */
        border: 1px solid #ccc;
        border-radius: 4px;
        display: none; /* Ẩn mặc định */
        max-height: 200px;
        overflow-y: auto; /* Hiện thanh cuộn nếu danh sách quá dài */
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng bóng để dropdown nổi bật */
        width: 200px; /* Đặt chiều rộng của dropdown bằng với chiều rộng của thanh tìm kiếm */
        left: 188px; /* Đảm bảo dropdown nằm ở vị trí đúng */
    }

    .dropdown-item {
        padding: 10px;
        cursor: pointer;
        background-color: white; /* Nền trắng cho item */
        color: #333; /* Màu chữ đậm hơn để dễ nhìn */
        font-size: 14px; /* Kích thước chữ trung bình */
        border-bottom: 1px solid #e6e6e6; /* Đường gạch ngang giữa các item */
    }

    .dropdown-item:hover {
        background-color: #f1f1f1; /* Đổi màu nền khi hover */
        color: #000; /* Màu chữ khi hover */
    }

    .search-bar:focus {
        border-color: red; /* Hiệu ứng viền màu đỏ khi focus */
    }

    nav {
        position: relative; /* Đảm bảo vị trí dropdown chính xác */
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Tìm phần tử search-bar và dropdown
        const searchBar = document.querySelector('#search-bar');
        const dropdownResults = document.querySelector('#dropdown-results');

        // Kiểm tra nếu phần tử search-bar tồn tại
        if (searchBar) {
            // Lắng nghe sự kiện 'input' khi người dùng nhập liệu
            searchBar.addEventListener('input', function () {
                const query = this.value.trim();  // Lấy giá trị từ thanh tìm kiếm

                if (query === "") {
                    // Nếu giá trị rỗng, ẩn dropdown và không thực hiện tìm kiếm
                    dropdownResults.style.display = 'none';
                    dropdownResults.innerHTML = '';
                    return;
                }

                // Encode query để chuẩn bị cho URL
                const encodedQuery = encodeURIComponent(query);

                // Gửi yêu cầu tìm kiếm AJAX qua phương thức GET
                fetch("http://localhost:8080/FCM/searchMovie?query=" + encodedQuery)
                        .then(response => {
                            if (response.ok) {
                                return response.json();  // Giả sử servlet trả về JSON
                            } else {
                                throw new Error('Search failed');
                            }
                        })
                        .then(data => {
                            // Hiển thị dropdown và kết quả tìm kiếm
                            if (data.length > 0) {
                                dropdownResults.style.display = 'block';
                                dropdownResults.innerHTML = data.map(movie => {
                                    return "<div class='dropdown-item' data-id='" + movie.movieId + "'>" + movie.title + "</div>";
                                }).join('');
                            } else {
                                dropdownResults.style.display = 'block';
                                dropdownResults.innerHTML = "<div class='dropdown-item'>No results found</div>";
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            dropdownResults.innerHTML = "<div class='dropdown-item'>Error occurred</div>";
                            dropdownResults.style.display = 'block';
                        });
            });

            // Sử dụng 'keydown' thay vì 'keypress' và ngăn chặn hành động mặc định của form khi nhấn Enter
            searchBar.addEventListener('keydown', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();  // Ngăn chặn hành động submit mặc định của form

                    const query = this.value.trim();
                    if (query !== "") {
                        // Điều hướng đến trang searchresult.jsp và truyền từ khóa tìm kiếm
                        window.location.href = '${pageContext.request.contextPath}/searchresult?query=' + encodeURIComponent(query);
                    }
                }
            });

            // Xử lý sự kiện khi click vào dropdown item để điều hướng tới trang chi tiết phim
            dropdownResults.addEventListener('click', function (e) {
                if (e.target && e.target.matches('.dropdown-item')) {
                    const movieId = e.target.getAttribute('data-id');  // Lấy movieId từ thuộc tính data-id

                    if (movieId && movieId !== "") {
                        // Chuyển hướng người dùng đến trang chi tiết phim với movieId
                        const contextPath = '<%= request.getContextPath() %>';
                        const url = contextPath + '/detail?movieId=' + movieId;
                        window.location.href = url;

                    } else {
                        console.error('Movie ID not found or empty!');
                    }
                }
            });
        }
    });
</script>
