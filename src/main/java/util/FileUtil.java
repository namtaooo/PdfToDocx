package util;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Part;

public class FileUtil {
	//Lấy tên file
	public static String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                String fileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                return fileName.replace("\\", ""); // fix IE
            }
        }
        return null;
    }
	
	// tạo random tên file
	public static String randomName(String originalName) {
        String ext = "";
        int dot = originalName.lastIndexOf(".");
        if (dot >= 0) ext = originalName.substring(dot); // giữ nguyên .pdf

        return UUID.randomUUID().toString().replace("-", "") + ext;
    }
	
	// lấy thư mục lưu upload
	public static String getUploadDir(ServletContext context) {
        String realPath = context.getRealPath("/uploads");
        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();
        return realPath;
    }
	
    //  Lấy đường dẫn file upload theo tên
    //  (nếu không có request)
	public static String getUploadPath(String fileName) {
	    String base = System.getProperty("pdf2word.uploadDir");
	    if (base == null) {
	        throw new IllegalStateException("pdf2word.uploadDir chưa được set");
	    }
	    return new File(base, fileName).getAbsolutePath();
	}
	
	// lấy thư mucjxuats file docx ra
	public static String getOutputPath(String fileName) {
	    String base = System.getProperty("pdf2word.outputDir");
	    if (base == null) {
	        throw new IllegalStateException("pdf2word.outputDir chưa được set");
	    }
	    File dir = new File(base);
	    if (!dir.exists()) dir.mkdirs();
	    return new File(dir, fileName).getAbsolutePath();
	}
	//  Đổi đuôi file
    public static String changeExtension(String originalName, String newExt) {
        int idx = originalName.lastIndexOf(".");
        if (idx < 0) return originalName + newExt;
        return originalName.substring(0, idx) + newExt;
    }
}
