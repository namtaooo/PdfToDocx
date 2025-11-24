<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PDF to Docx - Upload</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" href = "style.css">
    </head>

<body class = "bg-gradient">

    <!-- NAVBAR -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>PDF to Docx</h1>
            <!-- Nút chuyển sang trang danh sách file đã chuyển -->
            <a href="jobs.jsp" class="nav-link">File đã chuyển</a>
        </div>

        <div class="user-info">
            <span>Xin chào,
                <strong><%= request.getAttribute("username") != null ? request.getAttribute("username") : "User" %></strong>
            </span>
            <form action="auth" method="get" style="margin:0;">
                <button type ="submit" name ="action" value = "logout"  class="logout-btn"">Đăng xuất</button>
            </form>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="upload-container">
        <h2 class="title">Chuyển đổi PDF sang Docx</h2>

        <!-- upload: servlet xử lý upload & convert -->
        <form action="upload" method="post" enctype="multipart/form-data">

            <!-- Nhập địa chỉ (URL hoặc đường dẫn hiển thị) -->
            <div class="input-group">
                <input type="text" id="filePathInput" name="filepath"
                       placeholder="Nhập đường dẫn hoặc chọn tệp từ máy">
                <button type="button" class="file-btn"
                        onclick="document.getElementById('fileInput').click();">
                    Chọn tệp
                </button>
            </div>

            <!-- input file ẩn -->
            <input type="file" id="fileInput" name="file" accept="application/pdf" style="display:none">

            <button type="submit" class="upload-btn">Tải lên & chuyển đổi</button>
        </form>
    </div>

    <script>
        const fileInput = document.getElementById('fileInput');
        const filePathInput = document.getElementById('filePathInput');

        // Khi chọn file từ máy → hiển thị tên file vào ô text
        fileInput.addEventListener('change', function () {
            if (this.files && this.files.length > 0) {
                // Chỉ lấy tên file (trình duyệt không cho lấy full path thật)
                filePathInput.value = this.files[0].name;
            } else {
                filePathInput.value = "";
            }
        });
    </script>

</body>
</html>
