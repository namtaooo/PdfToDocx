package test;

import java.io.FileOutputStream;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.poi.xwpf.usermodel.XWPFDocument;

public class testTiheheh {
	public static void main(String[] args) throws Exception{
		PDDocument pdf = new PDDocument();
		pdf.addPage(new PDPage());
		pdf.save("test-lib.pdf");
		pdf.close();

		XWPFDocument doc = new XWPFDocument();
		doc.createParagraph().createRun().setText("Hello from Apache POI!");
		try (FileOutputStream out = new FileOutputStream("test-lib.docx")) {
		    doc.write(out);
		}
		doc.close();

		
	}
}
