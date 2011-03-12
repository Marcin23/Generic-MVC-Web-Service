/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package helloworld;

/**
 *
 * @author Marcin
 */

import java.util.regex.Matcher;
import java.util.regex.Pattern;
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
@Path("/ADD/USER/")
public class AddUser {


    @GET
    @Produces({ MediaType.APPLICATION_JSON })
    public TestFetchBean getXml() {
       //@PathParam(nameParm);
   		TestFetchBean fetchBean = new TestFetchBean();
		fetchBean.setName("mojo");
		fetchBean.setUserid("jojo");
		return fetchBean;   //sent in JSON format
    }


    @POST
    @Consumes({MediaType.APPLICATION_JSON})
    public String putTestFetchBean(JAXBElement<TestFetchBean> TestFetchBean) {
		TestFetchBean test = TestFetchBean.getValue(); //receive JSON and store it in the bean
                System.out.print(test.getName());
                System.out.print(test.getUserid());

		return "success";
    }
}
