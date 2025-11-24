package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.ConversionJob;

public class ConversionJobDao {
    public void insert(ConversionJob job) {
    	String sql = "INSERT INTO conversion_job(user_id, real_name, original_file_name, file_size, status, created_at) " +
                "VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        	ps.setInt(1, job.getUserId());
        	ps.setString(2, job.getRealName());
        	ps.setString(3, job.getOriginalFileName());
        	ps.setLong(4, job.getFileSize());
        	ps.setString(5, job.getStatus());

            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                job.setId(keys.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //Lấy danh sách job theo userid
    public List<ConversionJob> findByUser(int userId) {
        List<ConversionJob> list = new ArrayList<>();
        String sql = "SELECT * FROM conversion_job WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // lấy pending cũ nhất xử lsy trước
    public ConversionJob findNextPending() {
    	String sql = "Select * From conversion_job Where status = 'PENDING' Order By created_at ASC LIMIT 1";
    	try(Connection conn = DBConnection.getConnection();
    			PreparedStatement ps = conn.prepareStatement(sql)){
    		ResultSet rs = ps.executeQuery();
    		if (rs.next()) {
    			return mapRow(rs);
    		}
    	}catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return null;
    }
    
    public void updateStatus(int jobId, String status, String errorMessage) {
        String sql = "UPDATE conversion_job SET status = ?, error_message = ?, finished_at = " +
                     "CASE WHEN ? = 'DONE' OR ? = 'FAILED' THEN NOW() ELSE finished_at END " +
                     "WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, errorMessage);
            ps.setString(3, status);
            ps.setString(4, status);
            ps.setInt(5, jobId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updateSuccess(int jobId, String outputFileName) {
        String sql = "UPDATE conversion_job SET status = 'DONE', output_file_name = ?, finished_at = NOW() WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, outputFileName);
            ps.setInt(2, jobId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public ConversionJob findById(int id) {
        String sql = "SELECT * FROM conversion_job WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    
 // Hàm map cho nhanh lười copy ResultSet -> ConversionJob
    private ConversionJob mapRow(ResultSet rs) throws SQLException {
        ConversionJob job = new ConversionJob();
        job.setId(rs.getInt("id"));
        job.setUserId(rs.getInt("user_id"));
        job.setRealName(rs.getString("real_name"));
        job.setOriginalFileName(rs.getString("original_file_name"));
        job.setOutputFileName(rs.getString("output_file_name"));
        job.setFileSize(rs.getLong("file_size"));
        job.setStatus(rs.getString("status"));
        job.setErrorMessage(rs.getString("error_message"));

        Timestamp created = rs.getTimestamp("created_at");
        if (created != null) job.setCreatedAt(created.toLocalDateTime());

        Timestamp finished = rs.getTimestamp("finished_at");
        if (finished != null) job.setFinishedAt(finished.toLocalDateTime());

        return job;
    }
  
}
