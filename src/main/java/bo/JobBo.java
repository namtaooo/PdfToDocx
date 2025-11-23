package bo;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.Part;

import dao.ConversionJobDao;
import model.ConversionJob;
import util.FileUtil;

public class JobBo {
	private final ConversionJobDao jobDao = new ConversionJobDao();
	
	public ConversionJob createJob(int userId, Part pdfPart, ServletContext context) throws IOException{
		
		String fileName = FileUtil.extractFileName(pdfPart);
		if (fileName == null || !fileName.endsWith(".pdf")){
			throw new IOException("File không phải PDF!");
		}
		
		String uploadDir = FileUtil.getUploadDir(context);
		String savedName = FileUtil.randomName(fileName);
		File savedFile = new File(uploadDir, savedName);
		pdfPart.write(savedFile.getAbsolutePath());
		
		// tạo job
		ConversionJob job = new ConversionJob();
		job.setUserId(userId);
		job.setOriginalFileName(savedName);
		job.setFileSize(savedFile.length());
		job.setStatus("PENDING");
		
		jobDao.insert(job);
		return job;
	}
	
	public List<ConversionJob> getJobsByUser(int userId){
		return jobDao.findByUser(userId);
	}
	
	public ConversionJob getJobById(int id) {
		return jobDao.findById(id);
	}
}
