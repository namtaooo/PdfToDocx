package bo;

import dao.ConversionJobDao;
import model.ConversionJob;
import org.junit.Assert;
import org.junit.Test;

import javax.servlet.ServletContext;
import javax.servlet.http.Part;
import java.io.*;

import static org.mockito.Mockito.*;

public class JobBoTest {

    private final JobBo jobBo = new JobBo();

    @Test
    public void testCreateJob() throws Exception {
        // Giả lập ServletContext
        ServletContext ctx = mock(ServletContext.class);
        when(ctx.getRealPath("/uploads")).thenReturn("uploads_test");

        // Tạo thư mục tạm
        new File("uploads_test").mkdirs();

        // Giả lập file upload Part
        Part fakePart = mock(Part.class);
        when(fakePart.getHeader("content-disposition"))
                .thenReturn("form-data; name=\"pdfFile\"; filename=\"test.pdf\"");

        // Fake dữ liệu PDF
        File tempPdf = new File("uploads_test/source.pdf");
        try (FileOutputStream fos = new FileOutputStream(tempPdf)) {
            fos.write("PDF data".getBytes());
        }
        doAnswer(inv -> {
            String path = inv.getArgument(0);
            try (InputStream in = new FileInputStream(tempPdf);
                 OutputStream out = new FileOutputStream(path)) {
                in.transferTo(out);
            }
            return null;
        }).when(fakePart).write(anyString());

        // Thực thi bo
        ConversionJob job = jobBo.createJob(1, fakePart, ctx);

        Assert.assertNotNull(job);
        Assert.assertEquals("PENDING", job.getStatus());

        // Dọn file
        tempPdf.delete();
    }
}
