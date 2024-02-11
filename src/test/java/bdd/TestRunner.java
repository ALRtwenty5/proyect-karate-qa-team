package bdd;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
    @Karate.Test
    Karate testLogin() {
        return Karate.run("auth/loginAuth").relativeTo(getClass());
    }

    @Karate.Test
    Karate testRegister() {
        return Karate.run("auth/registerAuth").relativeTo(getClass());
    }

    @Karate.Test
    Karate addProduct() {
        return Karate.run("product/addProduct").relativeTo(getClass());
    }

    @Karate.Test
    Karate getProduct() {
        return Karate.run("product/getProduct").relativeTo(getClass());
    }

    @Karate.Test
    Karate statusChange() {return Karate.run("product/statusChange").relativeTo(getClass());
    }
}
