package dao;

import model.User;
import org.junit.Assert;
import org.junit.Test;

public class UserDaoTest {
	private final UserDao userDao = new UserDao();

    @Test
    public void testInsertAndFindByUsername() {
        // chuẩn bị
        String username = "testuser_" + System.currentTimeMillis();
        String passHash = "hash123";

        User u = new User();
        u.setUsername(username);
        u.setPasswordHash(passHash);

        // chèn dữ liệu
        boolean ok = userDao.insert(u);
        Assert.assertTrue(ok);
        Assert.assertTrue(u.getId() > 0);

        // kiểm tra có tìm lại được không
        User found = userDao.findByUsername(username);
        Assert.assertNotNull(found);
        Assert.assertEquals(username, found.getUsername());
        Assert.assertEquals(passHash, found.getPasswordHash());
    }
}
