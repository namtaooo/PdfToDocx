<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PDF to Docx - Upload</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        body {
            margin: 0;
            background: linear-gradient(135deg, #4f46e5, #06b6d4);
            min-height: 100vh;
        }

        /* NAVBAR */
        .navbar {
            width: 100%;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(8px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 14px 26px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #fff;
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .navbar h1 {
            font-size: 22px;
            font-weight: 700;
            margin: 0;
        }

        .nav-link {
            background: rgba(255, 255, 255, 0.2);
            padding: 8px 14px;
            border-radius: 999px;
            text-decoration: none;
            color: #ffffff;
            font-size: 14px;
            font-weight: 600;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.35);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 15px;
        }

        .logout-btn {
            background: #ef4444;
            padding: 8px 16px;
            color: white;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.2s ease;
        }

        .logout-btn:hover {
            background: #dc2626;
        }

        /* MAIN CONTAINER */
        .container {
            max-width: 600px;
            margin: 80px auto;
            background: white;
            padding: 32px;
            border-radius: 16px;
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.25);
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .title {
            text-align: center;
            margin-bottom: 24px;
            font-size: 24px;
            font-weight: 700;
            color: #111827;
        }

        /* INPUT + BUTTONS */
        .input-group {
            display: flex;
            gap: 12px;
            margin-bottom: 18px;
        }

        .input-group input[type="text"] {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #d1d5db;
            font-size: 15px;
            outline: none;
        }

        .input-group input[type="text"]:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        .file-btn {
            background: #06b6d4;
            color: #fff;
            padding: 12px 18px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        .file-btn:hover {
            background: #0891b2;
        }

        .upload-btn {
            width: 100%;
            padding: 14px 0;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: white;
            border-radius: 999px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin-top: 12px;
            transition: transform 0.1s ease, box-shadow 0.1s ease;
        }

        .upload-btn:hover {
            box-shadow: 0 10px 20px rgba(79, 70, 229, 0.35);
            transform: translateY(-1px);
        }

        .upload-btn:active {
            transform: translateY(0);
        }
    </style>
</head>

<body>

    <!-- NAVBAR -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>PDF to Docx</h1>
            <!-- Nút chuyển sang trang danh sách file đã chuyển -->
            <a href="Jobs.jsp" class="nav-link">File đã chuyển</a>
        </div>

        <div class="user-info">
            <span>Xin chào,
                <strong><%= request.getAttribute("username") != null ? request.getAttribute("username") : "User" %></strong>
            </span>
            <form action="logout" method="post" style="margin:0;">
                <button class="logout-btn">Đăng xuất</button>
            </form>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="container">
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
