package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import bo.JobBo;


/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private JobBo jobBo = new JobBo();
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			response.sendRedirect("login.jsp");
			return;
		}// lấy tên đăng nhập
		
		//LẤy file bằng part
		Part fPart = request.getPart("pdfFile");
		
		try {
			jobBo.createJob(userId, fPart, getServletContext());
			response.sendRedirect("jobs");
			
		}catch(IOException e) {
			request.setAttribute("error", e.getMessage());
			request.getRequestDispatcher("upload.jsp").forward(request, response);
		}
		
		
	}

}
