package dao;

import model.ConversionJob;
import org.junit.Assert;
import org.junit.Test;

import java.util.List;

public class ConversionJobDaoTest {

    private final ConversionJobDao jobDao = new ConversionJobDao();

    @Test
    public void testInsertAndFindByUser() {
        int userId = 1; // giả sử đã có user id = 1 trong DB

        ConversionJob job = new ConversionJob();
        job.setUserId(userId);
        job.setOriginalFileName("abc123.pdf");
        job.setFileSize(1234);
        job.setStatus("PENDING");

        jobDao.insert(job);

        Assert.assertTrue(job.getId() > 0);

        List<ConversionJob> jobs = jobDao.findByUser(userId);
        Assert.assertNotNull(jobs);

        boolean found = jobs.stream().anyMatch(j -> j.getId() == job.getId());
        Assert.assertTrue(found);
    }

    @Test
    public void testNextPending() {
        // Tạo job PENDING
        ConversionJob job = new ConversionJob();
        job.setUserId(1);
        job.setOriginalFileName("pendingtest.pdf");
        job.setFileSize(456);
        job.setStatus("PENDING");
        jobDao.insert(job);

        // Worker khi chạy sẽ gọi cái này
        ConversionJob next = jobDao.findNextPending();
        Assert.assertNotNull(next);
        Assert.assertEquals("PENDING", next.getStatus());
    }

    @Test
    public void testUpdateSuccess() {
        // Tạo job
        ConversionJob job = new ConversionJob();
        job.setUserId(1);
        job.setOriginalFileName("file.pdf");
        job.setFileSize(789);
        job.setStatus("PENDING");
        jobDao.insert(job);

        // Update DONE
        jobDao.updateSuccess(job.getId(), "output.docx");

        ConversionJob after = jobDao.findById(job.getId());

        Assert.assertEquals("DONE", after.getStatus());
        Assert.assertEquals("output.docx", after.getOutputFileName());
        Assert.assertNotNull(after.getFinishedAt());
    }
}
