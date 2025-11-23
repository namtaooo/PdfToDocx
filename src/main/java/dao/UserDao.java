package dao;
import java.sql.*;

import model.User;

public class UserDao {
	public User findByUsername(String username) {
		String sql = "Select * From user Where username = ?";
		try(Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql)){
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setPasswordHash(rs.getString("password_hash"));
				Timestamp ts = rs.getTimestamp("created_at");
				if (ts != null) {
					u.setCreatedAt(ts.toLocalDateTime());
				}
				return u;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public boolean insert(User user) {
		String sql = "INSERT INTO user(username, password_hash, created_at) VALUES (?, ?, NOW())";
		try(Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPasswordHash());
			int affected = ps.executeUpdate();
			if (affected > 0) {
				ResultSet keys = ps.getGeneratedKeys();
				if ( keys.next()) {
					user.setId(keys.getInt(1));
				}
				return true;
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}
