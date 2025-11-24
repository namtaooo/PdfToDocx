<%@page import="model.ConversionJob"%>
<%@page import="java.util.List;"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>File đã chuyển</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href = "style.css">
</head>

<body class ="bg-gradient">

	<% List<ConversionJob> jobs = (List<ConversionJob>) request.getAttribute("jobs"); %>
    <!-- NAVBAR -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>PDF to Docx</h1>
            <!-- Nút quay lại trang Upload -->
            <a href="upload.jsp" class="nav-link">⬅ Quay lại Upload</a>
        </div>

        <div class="user-info">
            <span>Xin chào,
                <strong><%= request.getAttribute("username") != null ? request.getAttribute("username") : "User" %></strong>
            </span>
            <form action="/auth" method="post" style="margin:0;">
                <button type ="submit" name ="action" value = "logout"  class="logout-btn"">Đăng xuất</button>
            </form>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="jobs-container">
        <h2 class="jobs-title">Danh sách file đã chuyển</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
			        <th>Tên file PDF</th>
			        <th>Trạng thái</th>
			        <th>File Word</th>
			        <th>Thời gian tạo</th>
			        <th>Thời gian hoàn thành</th>
			        <th>Hành động</th>
                </tr>
            </thead>
            <tbody>

                <tr>
                	<td>001</td>
                    <td>Example.pdf</td>
                    <td>Done</td>
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
