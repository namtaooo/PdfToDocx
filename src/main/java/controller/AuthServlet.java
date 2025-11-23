package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bo.AuthBo;
import model.User;

/**
 * Servlet implementation class AuthServlet
 */
@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private final AuthBo ab = new AuthBo();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if ("logout".equalsIgnoreCase(action)) {
			HttpSession session = request.getSession(false);
			if (session != null) {
				session.invalidate();
			}
			response.sendRedirect("login.jsp");
			return;
		}
		
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		if ("register".equalsIgnoreCase(action)) {
			handleRegister(request, response);
			
		}else {
			handleLogin(request, response);
		}
	}
	
	private void handleRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		boolean ok = ab.register(username, password);
		if (!ok) {
			request.setAttribute("error", "Tên người dùng đã tồn tại");
			request.getRequestDispatcher("register.jsp").forward(request, response);
			return;
		}
		request.setAttribute("message", "Đăng ký thành công!");
		request.getRequestDispatcher("login.jsp").forward(request, response);
		
	}
	private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user = ab.login(username, password);
        if (user == null) {
        	request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác");
        	request.getRequestDispatcher("login.jsp").forward(request, response);
        	return;
        }
        
        HttpSession ss = request.getSession(false);
        ss.setAttribute("userId", user.getId());
        ss.setAttribute("username", user.getUsername());
        
        response.sendRedirect("upload.jsp");
	}

}
