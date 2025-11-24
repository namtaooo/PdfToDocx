package listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import worker.JobWorker;

/**
 * Application Lifecycle Listener implementation class AppContextListener
 *
 */
@WebListener
public class AppContextListener implements ServletContextListener {

	private Thread workerThread;
	private JobWorker worker;
	
	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
    	if (worker != null) worker.stop();
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  { 
    	ServletContext ctx = sce.getServletContext();
    	String uploadPath = ctx.getRealPath("/uploads");
        String outputPath = ctx.getRealPath("/outputs");
        System.setProperty("pdf2word.uploadDir", uploadPath);
        System.setProperty("pdf2word.outputDir", outputPath);
        worker = new JobWorker();
        workerThread = new Thread(worker);
        workerThread.setDaemon(true);
        workerThread.start();
    }
	
}
