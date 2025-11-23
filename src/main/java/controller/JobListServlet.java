package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import bo.JobBo;
import model.ConversionJob;

/**
 * Servlet implementation class JobListServlet
 */
@WebServlet("/jobs")
public class JobListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private final JobBo jb = new JobBo();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession ss = request.getSession(false);
		Integer userId = (ss != null) ? (Integer) ss.getAttribute("userId") : null;
		if (userId == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		List<ConversionJob> jobs = jb.getJobsByUser(userId);
		request.setAttribute("jobs", jobs);
		
		request.getRequestDispatcher("jobs.jsp").forward(request, response);
	}

}
