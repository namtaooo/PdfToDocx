package bo;

import model.User;
import org.junit.Assert;
import org.junit.Test;
import util.PasswordUtil;

public class AuthBoTest {

    private final AuthBo authBo = new AuthBo();

    @Test
    public void testRegisterAndLogin() {
        String username = "user_" + System.currentTimeMillis();
        String password = "123456";

        boolean created = authBo.register(username, password);
        Assert.assertTrue(created);

        User logged = authBo.login(username, password);
        Assert.assertNotNull(logged);

        // Sai mật khẩu -> null
        User wrong = authBo.login(username, "wrongpass");
        Assert.assertNull(wrong);
    }
}
