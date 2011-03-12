/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package helloworld;

/**
 *
 * @author Marcin
 */
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
// JAX-RS supports an automatic mapping from JAXB annotated class to XML and JSON
public class TestFetchBean {
    private String name;
    private String userid;

    public TestFetchBean() {
    }

    public TestFetchBean (String name, String userid){
		this.name = name;
		this.userid = userid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }




}