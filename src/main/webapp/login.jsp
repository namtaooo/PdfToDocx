	<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html lang="vi">
	<head>
	    <meta charset="UTF-8">
	    <title>Login</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="style.css">
	</head>
	
	<body class="bg-gradient">
	    <div class="login-container">
	        <h2 class="login-title">Đăng nhập</h2>
	            <% if(request.getAttribute("error")!=null){ %>
	            	 <p style="color:red;"><%= request.getAttribute("error") %></p>
	            <% } %>
	        <!-- Thêm action và method nếu bạn có servlet xử lý -->
	        <form action="auth" method="post">
	        	<input type="hidden" name="action" value="login">
	            <div class="form-group">
	                <label for="username">Tên đăng nhập</label>
	                <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập">
	            </div>
	
	            <div class="form-group">
	                <label for="password">Mật khẩu</label>
	                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu">
	            </div>
	
	            <div class="actions">
	                <label class="remember">
	                    <input type="checkbox" name="remember">
	                    Ghi nhớ tôi
	                </label>
	            </div>
	
	            <button type="submit" class="btn-submit">Đăng nhập</button>
	            <p class="note">
	                Chưa có tài khoản?
	                <a href="register.jsp">Đăng ký ngay</a>
	            </p>
	        </form>
	    </div>
	</body>
	</html>
