/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package RESTws;

/**
 *
 * @author Marcin
 */

import EntityDB.EntityBase;
import EntityDB.User;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;

import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;
import javax.xml.bind.JAXBElement;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;


@Stateless
@Path("/entity/user/create/")
public class AddUser {

    @GET
    @Produces({ MediaType.APPLICATION_JSON })
    public TestFetchBean getXml() {
       //@PathParam(nameParm);
   		TestFetchBean fetchBean = new TestFetchBean();
		fetchBean.setFirstName("mojo");
		fetchBean.setLastName("jojo");
		return fetchBean;   //sent in JSON format
    }


    @POST
    @Produces({ MediaType.APPLICATION_JSON })
    @Consumes({MediaType.APPLICATION_JSON})
    public TestFetchBean putTestFetchBean(JAXBElement<TestFetchBean> TestFetchBean) throws NoSuchAlgorithmException, Exception {
        try {
            TestFetchBean test = TestFetchBean.getValue(); //receive JSON and store it in the bean
            System.out.print(test.getFirstName());
            System.out.print(test.getLastName());
            System.out.print(test.getPhoneNr());
            System.out.print(test.getEmailID());
            System.out.print(test.getPassword());

            String email = test.getEmailID();
            String pwd1 = test.getPassword();
            System.out.print(pwd1);

            User u = new User();
            u.createNewID();
//            u.setEntityId(EntityBase.generateNewID());
//            u.setEntityAccessStatus("1");
//            u.setTypeId(0);
            u.setEmail(test.getEmailID());
            u.setFirstName(test.getLastName());
            u.setLastName(test.getFirstName());
            u.setPhone(test.getPhoneNr());
            try {
                u.setPassword(pwd1);
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(AddUser.class.getName()).log(Level.SEVERE, null, ex);
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(AddUser.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                u.save(true);
            } catch(Exception e){
                System.err.print(e);
                throw e;
            }
            User ut = User.getUserByPassword(email, pwd1);
            assert (ut != null);
            System.out.print(ut.getFirstName() + "   test!!!");
            ut.delete(true);
            //        User utest = new User();
            //        try {
            //            utest = User.getUserByPassword(test.getEmailID(), test.getPassword());
            //        } catch (NoSuchAlgorithmException ex) {
            //            Logger.getLogger(AddUser.class.getName()).log(Level.SEVERE, null, ex);
            //        } catch (UnsupportedEncodingException ex) {
            //            Logger.getLogger(AddUser.class.getName()).log(Level.SEVERE, null, ex);
            //        }
            //        System.out.print("***********");
            //        System.out.print(utest.getFirstName());
            //        System.out.print(utest.getFirstName());
            //        System.out.print(utest.getFirstName());
            //        System.out.print("**************");
            return test;
        } catch (UnsupportedEncodingException ex) {
            return null;

        }
    }
}
