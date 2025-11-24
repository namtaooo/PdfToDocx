<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
   </head>

<body class="bg-gradient">
    <div class="register-container">
        <h2 class="register-title">Đăng ký</h2>

        <form action="auth" method="post">
        <input type="hidden" name="action" value="register">
        
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập">
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu">
            </div>

            <button type="submit" class="btn-submit">Tạo tài khoản</button>
            <% if (request.getAttribute("error") != null) { %>
		    <p style="color:red;"><%= request.getAttribute("error") %></p>
			<% } %>
			
			<% if (request.getAttribute("message") != null) { %>
			    <p style="color:green;"><%= request.getAttribute("message") %></p>
			<% } %>
	            
            <p class="register-note">
                Đã có tài khoản?
                <a href="login.jsp">Đăng nhập ngay</a>
            </p>
        </form>
    </div>
</body>
</html>
