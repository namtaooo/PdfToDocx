<%@page import="model.ConversionJob"%>
<%@page import="java.util.List"%>
<%@page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>File đã chuyển</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel= "stylesheet" href = "style.css">
</head>

<body class ="bg-gradient">

	<% List<ConversionJob> jobs = (List<ConversionJob>) request.getAttribute("jobs"); %>
    <!-- NAVBAR -->
    <div class="navbar">
        <div class="navbar-left">
            <h1>PDF to Docx</h1>
            <!-- Nút quay lại trang Upload -->
            <a href="upload.jsp" class="nav-link">⬅ Quay lại Upload</a>
        </div>

        <div class="user-info">
          <%    HttpSession ss = request.getSession(false); %>
                <strong><%
				    if (ss == null || ss.getAttribute("username") == null) {
				        response.sendRedirect("login.jsp");
				        return;
				    }
				    String username = (String) ss.getAttribute("username");
				%>
				
				<span>Xin chào, <strong><%= username %></strong></span>
				</strong>
            <form action="/auth" method="post" style="margin:0;">
                <button type ="submit" name ="action" value = "logout"  class="logout-btn"">Đăng xuất</button>
            </form>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <form action="/jobs" method="get" >
    <div class="jobs-container">
        <h2 class="jobs-title">Danh sách file đã chuyển</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
			        <th>Tên file PDF</th>
			    	<th>Tên file sau khi chuyển</th>
			        <th>Trạng thái</th>
			        <th>Thời gian tạo</th>
			        <th>Thời gian hoàn thành</th>
			        <th>Lỗi</th>
			        <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
            <%if(jobs!=null){
            	for(ConversionJob job: jobs){
            	%>
            	<tr>
            	<td><%=job.getId() %></td>
            	<td><%=job.getRealName() %></td>
            	<td><%=job.getOutputFileName() %></td>
            	<td><%=job.getStatus() %></td>
            	<td><%=job.getCreatedAt() %></td>      
            	
            		
            	<td><%=job.getFinishedAt() %></td>
            	<td><%= job.getErrorMessage() == null ? "-" : job.getErrorMessage() %></td>
            	<td>
				    <% if ("DONE".equals(job.getStatus())) { %>
				        <a href="download?id=<%= job.getId() %>" class="btn-download">Tải xuống</a>
				    <% } else { }%>
				</td>
				</tr>
				<%
            		}
            	}
				%>
            
            </tbody>
        </table>

    </div></form>
    

</body>
</html>
