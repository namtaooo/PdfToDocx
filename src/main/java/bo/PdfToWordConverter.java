package bo;


import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.TextPosition;
import org.apache.poi.xwpf.usermodel.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PdfToWordConverter {

    // Ngưỡng font-size để coi là heading (tùy file, bạn có thể chỉnh)
    private static final float HEADING_FONT_THRESHOLD = 14.0f;

    /**
     * Convert PDF sang DOCX, cố gắng phát hiện heading dựa trên font size.
     */
    public static void convert(String inputPdfPath, String outputDocxPath) throws IOException {
        File pdfFile = new File(inputPdfPath);
        if (!pdfFile.exists()) {
            throw new IOException("PDF file không tồn tại: " + inputPdfPath);
        }

        try (PDDocument pdf = PDDocument.load(pdfFile);
             XWPFDocument docx = new XWPFDocument()) {

            HeadingAwareStripper stripper = new HeadingAwareStripper();
            stripper.setSortByPosition(true);
            stripper.stripPage(pdf); // tự viết hàm này để chạy qua tất cả trang

            List<PageLine> lines = stripper.getLines();

            int currentPage = -1;

            for (PageLine line : lines) {
                // Khi sang trang mới → thêm page break + title nho nhỏ (optional)
                if (line.pageNumber != currentPage) {
                    if (currentPage != -1) {
                        XWPFParagraph breakPara = docx.createParagraph();
                        XWPFRun brRun = breakPara.createRun();
                        brRun.addBreak(BreakType.PAGE);
                    }

                    // Tiêu đề "Page X"
                    XWPFParagraph pageTitle = docx.createParagraph();
                    pageTitle.setAlignment(ParagraphAlignment.CENTER);
                    XWPFRun pageRun = pageTitle.createRun();
                    pageRun.setBold(true);
                    pageRun.setFontSize(13);
                    pageRun.setFontFamily("Times New Roman");
                    pageRun.setText("Page " + line.pageNumber);

                    currentPage = line.pageNumber;
                }

                if (line.text.trim().isEmpty()) {
                    // Dòng trống → tạo paragraph trống
                    XWPFParagraph empty = docx.createParagraph();
                    empty.createRun().addCarriageReturn();
                    continue;
                }

                // Nếu font trung bình >= threshold → coi là heading
                boolean isHeading = line.avgFontSize >= HEADING_FONT_THRESHOLD;

                XWPFParagraph para = docx.createParagraph();
                para.setAlignment(isHeading
                        ? ParagraphAlignment.CENTER
                        : ParagraphAlignment.BOTH);

                XWPFRun run = para.createRun();
                run.setFontFamily("Times New Roman");
                run.setFontSize(isHeading ? 14 : 12);
                run.setBold(isHeading);
                run.setText(line.text);
            }

            try (FileOutputStream out = new FileOutputStream(outputDocxPath)) {
                docx.write(out);
            }
        }
    }

    // =========================
    //  Inner classes helper
    // =========================

    /**
     * Lưu 1 dòng text + thông tin page + font-size trung bình.
     */
    private static class PageLine {
        int pageNumber;
        String text;
        float avgFontSize;

        PageLine(int pageNumber, String text, float avgFontSize) {
            this.pageNumber = pageNumber;
            this.text = text;
            this.avgFontSize = avgFontSize;
        }
    }

    /**
     * Stripper custom dùng TextPosition để đo font-size cho từng dòng.
     */
    private static class HeadingAwareStripper extends PDFTextStripper {

        private final List<PageLine> lines = new ArrayList<>();

        public HeadingAwareStripper() throws IOException {
            super();
        }

        public List<PageLine> getLines() {
            return lines;
        }

        // Chạy qua tất cả các trang
        public void stripPage(PDDocument doc) throws IOException {
            setStartPage(1);
            setEndPage(doc.getNumberOfPages());
            writeText(doc, new java.io.OutputStreamWriter(new java.io.ByteArrayOutputStream()));
        }

        @Override
        protected void writeString(String text, List<TextPosition> textPositions) throws IOException {
            if (text == null) text = "";
            float sum = 0;
            int count = 0;

            for (TextPosition tp : textPositions) {
                sum += tp.getFontSizeInPt();
                count++;
            }

            float avg = (count > 0) ? (sum / count) : 0f;
            int page = getCurrentPageNo();  // từ PDFTextStripper

            lines.add(new PageLine(page, text, avg));
        }
    }
}

