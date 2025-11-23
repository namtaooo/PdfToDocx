<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * {
            box-sizing: border-box;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #4f46e5, #06b6d4);
        }

        .login-container {
            background: #ffffff;
            width: 360px;
            padding: 32px 28px;
            border-radius: 16px;
            box-shadow: 0 18px 40px rgba(15, 23, 42, 0.25);
        }

        .login-title {
            text-align: center;
            margin: 0 0 24px;
            font-size: 24px;
            font-weight: 600;
            color: #111827;
        }

        .form-group {
            margin-bottom: 16px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
            color: #4b5563;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            border-radius: 10px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            outline: none;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.15);
        }

        .actions {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 16px;
            font-size: 13px;
        }

        .remember {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #4b5563;
        }

        .remember input {
            margin: 0;
        }

        .forgot {
            color: #4f46e5;
            text-decoration: none;
        }

        .forgot:hover {
            text-decoration: underline;
        }

        .btn-submit {
            width: 100%;
            padding: 10px 0;
            border-radius: 999px;
            border: none;
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            color: #ffffff;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.1s ease, box-shadow 0.1s ease;
        }

        .btn-submit:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 25px rgba(79, 70, 229, 0.35);
        }

        .btn-submit:active {
            transform: translateY(0);
            box-shadow: none;
        }

        .note {
            margin-top: 14px;
            text-align: center;
            font-size: 13px;
            color: #6b7280;
        }

        .note a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 500;
        }

        .note a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h2 class="login-title">Đăng nhập</h2>

        <!-- Thêm action và method nếu bạn có servlet xử lý -->
        <form action="login" method="post">
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
                <a href="#" class="forgot">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn-submit">Đăng nhập</button>

            <p class="note">
                Chưa có tài khoản?
                <a href="#">Đăng ký ngay</a>
            </p>
        </form>
    </div>
</body>
</html>
