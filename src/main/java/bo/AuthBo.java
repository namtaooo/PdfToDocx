package bo;

import dao.UserDao;
import model.User;
import util.PasswordUtil;

public class AuthBo {
	private final UserDao userDao = new UserDao();
	
	public User login(String username, String plainPassword) {
		User user = userDao.findByUsername(username);
		if (user == null) return null;
		
		boolean ok = PasswordUtil.verify(plainPassword, user.getPasswordHash());
		return ok ? user : null;
	}
	
	public boolean register(String username, String plainPassword) {
		User estU = userDao.findByUsername(username);
		if (estU != null) {
			return false; // tài khoản đã tồn tại
		}
		String hash = PasswordUtil.hash(plainPassword);
		User u = new User();
		u.setUsername(username);
		u.setPasswordHash(hash);
		return userDao.insert(u);
	}
	
	
}
