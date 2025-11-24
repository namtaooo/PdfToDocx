# PDF to Word Converter – JSP/Servlet + MySQL + Tomcat

Dự án web chuyển đổi PDF → Word, được xây dựng bằng JSP/Servlet, sử dụng MySQL làm cơ sở dữ liệu và chạy trên Apache Tomcat. Hệ thống hỗ trợ xử lý ngầm (background job) qua JobWorker và hàng đợi trong DB.

---

## 1. Hướng dẫn cài đặt Tomcat

1. **Tải Apache Tomcat**  
   - Khuyến nghị: Apache Tomcat 9 .
   - Tải tại trang chủ: `tomcat.apache.org`.

2. **Giải nén Tomcat**  
   - Ví dụ: giải nén vào thư mục:
     ```text
     C:\tomcat9\
     ```

3. **Cấu hình Tomcat trong Eclipse (nếu dùng Eclipse)**  
   - Mở: `Window → Preferences → Server → Runtime Environments → Add`.  
   - Chọn: **Apache Tomcat v9/v10** → Browse đến thư mục cài Tomcat (`C:\tomcat9\`).  
   - Nhấn **Finish**.

4. **Thêm project vào Tomcat Server**  
   - Mở tab **Servers** ở Eclipse.  
   - Chuột phải vào server Tomcat → **Add and Remove…**  
   - Chọn project PDF2Word → **Add** → **Finish**.

---

## 2. Hướng dẫn cài đặt Database (import file .sql)

Hệ thống sử dụng MySQL/MariaDB. Toàn bộ cấu trúc bảng đã được đóng gói trong file `.sql` của dự án.

### 2.1. Tạo database

Đăng nhập MySQL (phpMyAdmin, Workbench hoặc terminal) và chạy:

```sql
CREATE DATABASE pdf2word_db;
USE pdf2word_db;
```

### 2.2. Import file `.sql`

Giả sử file nằm tại:  
`/database/pdf2word_db.sql` trong project.

#### a) Nếu dùng phpMyAdmin (XAMPP)

1. Mở trình duyệt: `http://localhost/phpmyadmin`
2. Chọn database: **pdf2word_db**
3. Chọn tab **Import**
4. Chọn file: `pdf2word_db.sql`
5. Nhấn **Go** để import.

#### b) Nếu dùng MySQL Workbench

1. `Server → Data Import`
2. Chọn **Import from Self-Contained File**, trỏ tới `pdf2word_db.sql`
3. Chọn **Default Target Schema** là `pdf2word_db`
4. Nhấn **Start Import**

Sau khi import thành công, database sẽ có ít nhất 2 bảng chính:

- `user`
- `conversion_job`

---

## 3. Cấu hình kết nối DB (DBConnection.java)

Mở file:

```text
src/main/java/dao/DBConnection.java
```

Chỉnh lại thông tin kết nối cho phù hợp với máy của bạn:

```java
private static final String url  =
    "jdbc:mysql://localhost:3306/pdf2word_db?useSSL=false&serverTimezone=UTC";
private static final String user = "root";      // tài khoản MySQL
private static final String pass = "";          // mật khẩu MySQL (rỗng nếu dùng XAMPP mặc định)

static {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
}
```

> Lưu ý:  
> - Nếu bạn đổi tên database, cổng, user hoặc mật khẩu MySQL thì phải sửa lại URL/USER/PASS tương ứng.  
> - Cần bảo đảm thư viện JDBC driver `mysql-connector-java` đã được add vào project (Maven dependency hoặc `WEB-INF/lib`).

---

## 4. Hướng dẫn chạy webapp

1. **Build/Clean project (nếu dùng Eclipse)**  
   - `Project → Clean` để bảo đảm project được biên dịch lại.

2. **Run on Server**  
   - Chuột phải vào project → **Run As → Run on Server**  
   - Chọn server Tomcat đã cấu hình ở bước trên.

3. **Truy cập ứng dụng**  
   - Mở trình duyệt và gõ:  
     ```text
     http://localhost:8080/<tên-project>/
     ```  
   - Ví dụ nếu context path là `pdf2word`:
     ```text
     http://localhost:8080/pdf2word/
     ```

Nếu mọi thứ cấu hình đúng, bạn sẽ thấy trang đăng nhập hoặc trang chủ của ứng dụng.

---

## 5. Hướng dẫn sử dụng các chức năng

Hệ thống cung cấp một số chức năng chính dành cho người dùng cuối:

### 5.1. Đăng ký tài khoản

- Truy cập trang: `register.jsp` hoặc đường dẫn `/auth?action=register` (tuỳ cách điều hướng).  
- Nhập:
  - Tên đăng nhập (username) – duy nhất.
  - Mật khẩu.
- Sau khi đăng ký thành công, tài khoản được lưu vào bảng `user`, người dùng có thể quay lại trang đăng nhập.

### 5.2. Đăng nhập

- Truy cập: `login.jsp` hoặc `/auth`.  
- Nhập username/mật khẩu vừa tạo.  
- Hệ thống dùng `AuthBo` + `UserDao` để kiểm tra thông tin đăng nhập:
  - Nếu đúng → tạo session (`userId`, `username`) và chuyển đến trang upload PDF.  
  - Nếu sai → hiển thị thông báo lỗi trên trang login.

### 5.3. Upload file PDF (tạo job chuyển đổi)

- Sau khi đăng nhập, vào trang `upload.jsp`.  
- Chọn 1 file PDF từ máy (định dạng `.pdf`).  
- Nhấn **Tạo job chuyển đổi**:
  - Servlet `UploadServlet` nhận file và gọi `JobBo.createJob(...)`.
  - File PDF được lưu vào thư mục `uploads/` trên server.
  - Một record mới được tạo trong bảng `conversion_job` với trạng thái ban đầu là `PENDING`.

### 5.4. Worker xử lý job ở chế độ nền

- Khi webapp khởi động, `AppContextListener` sẽ tạo và chạy `JobWorker` trong một thread riêng.
- `JobWorker` định kỳ:
  - Tìm job có trạng thái `PENDING` trong bảng `conversion_job`.
  - Chuyển trạng thái thành `PROCESSING`.
  - Gọi `PdfToWordConverter` để đọc PDF (PDFBox) và tạo file Word `.docx` (Apache POI).
  - Lưu file Word vào thư mục `outputs/`.
  - Cập nhật trạng thái job thành `DONE` hoặc `FAILED`, đồng thời lưu tên file output và thời điểm hoàn thành.

Người dùng không cần giữ trình duyệt mở — quá trình xử lý chạy ngầm trên server.

### 5.5. Xem lịch sử và trạng thái job

- Truy cập trang `jobs.jsp` hoặc đường dẫn `/jobs`.  
- Hệ thống hiển thị danh sách các job của user đang đăng nhập, bao gồm:
  - ID job  
  - Tên file PDF gốc  
  - Trạng thái (`PENDING`, `PROCESSING`, `DONE`, `FAILED`)  
  - Tên file Word (nếu đã có)  
  - Thời gian tạo và thời gian hoàn thành (nếu có)

Người dùng có thể nhấn **Refresh** để cập nhật trạng thái mới nhất.

### 5.6. Download file Word (.docx)

- Khi một job có trạng thái `DONE`, ở cột **Hành động** sẽ xuất hiện nút/link **Download**.
- Link này trỏ tới `DownloadServlet`, ví dụ:  
  ```text
  /download?id=<jobId>
  ```
- `DownloadServlet` sẽ:
  - Kiểm tra user đăng nhập và quyền truy cập job.
  - Kiểm tra job đã ở trạng thái `DONE` và có `output_file_name`.  
  - Đọc file `.docx` tương ứng từ thư mục `outputs/` và stream nội dung về trình duyệt, kèm header `Content-Disposition: attachment` để trình duyệt tự động tải xuống.

---

## 6. Tác giả / Nhóm thực hiện

- **Đề tài**: Ứng dụng web chuyển đổi PDF → Word có xử lý ngầm bằng hàng đợi.  
- **Công nghệ sử dụng**:
  - Ngôn ngữ: Java (JSP/Servlet)
  - Web server: Apache Tomcat
  - CSDL: MySQL
  - Thư viện:
    - PDFBox (đọc nội dung PDF)
    - Apache POI (tạo file Word `.docx`)
- **Nhóm thực hiện**: Phạm Đức Hoài Nam, Phan Văn Hiếu.

- **Lưu ý**: Trước khi chạy code ,hãy update maven để cập nhật toàn bộ thưu viên đi kèm.
