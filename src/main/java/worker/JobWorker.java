package worker;


import bo.PdfToWordConverter;
import dao.ConversionJobDao;
import model.ConversionJob;
import util.FileUtil;

public class JobWorker implements Runnable{
	private final ConversionJobDao jd = new ConversionJobDao();
	private boolean running = true;
	
	@Override
	public void run() {
		System.out.println("Bắt đầu chạy job worker .......");
		
		while(running) {
			try {
				ConversionJob job = jd.findNextPending();
				if (job == null) {
					Thread.sleep(3000);
					continue;
				}
				
				jd.updateStatus(job.getId(), "PROCESSING", null);
				
				try {
					String inputPath = FileUtil.getUploadPath(job.getOriginalFileName());
					String outName = FileUtil.changeExtension(inputPath, ".docx");
					String outputPath = FileUtil.getOutputPath(outName);
					
					PdfToWordConverter.convert(inputPath, outputPath);
					
					jd.updateSuccess(job.getId(), outName);
					
				}catch (Exception ex) {
					jd.updateStatus(job.getId(), "FAILED", ex.getMessage());
				}
				
			}catch (Exception e) {
				System.err.println("Lỗi jobwworker");
			}
		}
	}
	public void stop() {
		running = false;
	}
}
