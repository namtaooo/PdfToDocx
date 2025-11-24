package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


import bo.JobBo;
import model.ConversionJob;
import util.FileUtil;

/**
 * Servlet implementation class DownloadServlet
 */
@WebServlet("/download")
public class DownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private final JobBo jobBo = new JobBo();
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
		String idStr = request.getParameter("id");
		if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu job id");
            return;
        }
		int jobId;
		try {
			jobId = Integer.parseInt(idStr);
		}catch(NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Job id không hợp lệ");
			return;
		}
		ConversionJob job = jobBo.getJobById(jobId);
		if (job == null || job.getUserId() != userId) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Không tìm thấy job");
			return;
		}
		if(!"DONE".equalsIgnoreCase(job.getStatus()) || job.getOutputFileName() == null) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Job chưa hoàn thành hoặc bị lỗi");
            return;
		}
		
		String outputPath = FileUtil.getOutputPath(job.getOutputFileName());
		File file = new File(outputPath);
		if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File không tồn tại trên server");
            return;
        }
		
		// Mime type đơn giản cho docx
        response.setContentType(
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        );
        String downloadName = job.getOutputFileName();
        String encoded = URLEncoder.encode(downloadName, "UTF-8")
                .replaceAll("\\+", "%20"); 
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + encoded + "\"; filename*=UTF-8''" + encoded);
        response.setContentLengthLong(file.length());
        
        try (InputStream in = new FileInputStream(file);
        		OutputStream out = response.getOutputStream()){
        	byte[] buffer = new byte[8129];
        	int len;
        	while((len = in.read(buffer)) != -1) {
        		out.write(buffer, 0, len);
        	}
        }
	}
}
