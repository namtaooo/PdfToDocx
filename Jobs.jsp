<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>File đã chuyển</title>
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

        /* Navbar */
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

        /* Container */
        .container {
            max-width: 900px;
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
            font-size: 26px;
            font-weight: 700;
            color: #111827;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
        }

        thead {
            background: #4f46e5;
            color: white;
        }

        th, td {
            padding: 14px;
            font-size: 15px;
            text-align: left;
        }

        tbody tr:nth-child(even) {
            background: #f3f4f6;
        }

        tbody tr:nth-child(odd) {
            background: #ffffff;
        }

        tbody tr:hover {
            background: #e0e7ff;
        }

        .download-btn {
            display: inline-block;
            background: #06b6d4;
            color: white;
            padding: 8px 14px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: background 0.2s ease;
        }

        .download-btn:hover {
            background: #0891b2;
        }
    </style>
</head>

<body>

    <!-- NAVBAR -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>PDF to Docx</h1>
            <!-- Nút quay lại trang Upload -->
            <a href="Upload.jsp" class="nav-link">⬅ Quay lại Upload</a>
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
        <h2 class="title">Danh sách file đã chuyển</h2>

        <table>
            <thead>
                <tr>
                    <th>Tên file</th>
                    <th>Ngày chuyển</th>
                    <th>Định dạng</th>
                    <th>Tải xuống</th>
                </tr>
            </thead>
            <tbody>

                <%-- 
                   Sau này bạn có thể dùng JSTL c:forEach để lặp qua list file.
                   Ở đây mình để ví dụ tĩnh để bạn test giao diện.
                --%>

                <tr>
                    <td>Example.pdf</td>
                    <td>12/02/2025</td>
                    <td>DOCX</td>
                    <td>
                        <a href="download?file=Example.docx" class="download-btn">Tải xuống</a>
                    </td>
                </tr>

                <tr>
                    <td>BaoCao.pdf</td>
                    <td>10/02/2025</td>
                    <td>DOCX</td>
                    <td>
                        <a href="download?file=BaoCao.docx" class="download-btn">Tải xuống</a>
                    </td>
                </tr>

                <tr>
                    <td>BaiTap.pdf</td>
                    <td>08/02/2025</td>
                    <td>DOCX</td>
                    <td>
                        <a href="download?file=BaiTap.docx" class="download-btn">Tải xuống</a>
                    </td>
                </tr>

            </tbody>
        </table>

    </div>

</body>
</html>
