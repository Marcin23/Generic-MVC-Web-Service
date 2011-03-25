<%--
 DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.

 Copyright 1997-2010 Oracle and/or its affiliates. All rights reserved.

 Oracle and Java are registered trademarks of Oracle and/or its affiliates.
 Other names may be trademarks of their respective owners.

 The contents of this file are subject to the terms of either the GNU
 General Public License Version 2 only ("GPL") or the Common
 Development and Distribution License("CDDL") (collectively, the
 "License"). You may not use this file except in compliance with the
 License. You can obtain a copy of the License at
 http://www.netbeans.org/cddl-gplv2.html
 or nbbuild/licenses/CDDL-GPL-2-CP. See the License for the
 specific language governing permissions and limitations under the
 License.  When distributing the software, include this License Header
 Notice in each file and include the License file at
 nbbuild/licenses/CDDL-GPL-2-CP.  Oracle designates this
 particular file as subject to the "Classpath" exception as provided
 by Oracle in the GPL Version 2 section of the License file that
 accompanied this code. If applicable, add the following below the
 License Header, with the fields enclosed by brackets [] replaced by
 your own identifying information:
 "Portions Copyrighted [year] [name of copyright owner]"
 
 Contributor(s):
 
 The Original Software is NetBeans. The Initial Developer of the Original
 Software is Sun Microsystems, Inc. Portions Copyright 1997-2007 Sun
 Microsystems, Inc. All Rights Reserved.
 
 If you wish your version of this file to be governed by only the CDDL
 or only the GPL Version 2, indicate your decision by adding
 "[Contributor] elects to include this software in this distribution
 under the [CDDL or GPL Version 2] license." If you do not indicate a
 single choice of license, a recipient has the option to distribute
 your version of this file under either the CDDL, the GPL Version 2 or
 to extend the choice of license to its licensees as provided above.
 However, if you add GPL Version 2 code and therefore, elected the GPL
 Version 2 license, then the option applies only if the new code is
 made subject to such option by the copyright holder.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>JAXWS RESTFul example</title>


<script type="text/javascript" language="javascript">


   var myFirstJSON = {  "firstName" : "Sonya",
                        "lastName" : "Sanyo",
                        "phoneNr" : "555-555-5555",
                        "emailID" : "Sono@goo.com",
                        "password" : "123456paswordpassword"};
                    
   var http_request = false;
   function makePOSTRequest(method,url, parameters) {
      http_request = false;
      if (window.XMLHttpRequest) { // Mozilla, Safari,...
         http_request = new XMLHttpRequest();
         //if (http_request.overrideMimeType) {
         	// set type accordingly to anticipated content type
            http_request.overrideMimeType('text/json');
           // http_request.overrideMimeType('text/html');
         //}
      } else if (window.ActiveXObject) { // IE
         try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
         } catch (e) {
            try {
               http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
         }
      }
      if (!http_request) {
         alert('Cannot create XMLHTTP instance');
         return false;
      }

      http_request.onreadystatechange = alertContents;
     // http_request.open(method, url, true);

      if(method=='GET'){
			http_request.open(method, url+parameters, true);
			http_request.setRequestHeader("Content-type", "application/json");
			http_request.setRequestHeader("Content-length", parameters.length);
			http_request.setRequestHeader("Connection", "close");
			http_request.send(null);
		}
	   if(method=='POST')  {
               var toServer = JSON.stringify(myFirstJSON);
               alert('Sending XML to server:\n'+toServer);
			http_request.open(method, url, true);
			http_request.setRequestHeader("Content-type", "application/json");
			http_request.setRequestHeader("Content-length", toServer.length);
			http_request.setRequestHeader("Connection", "close");
			http_request.send(toServer);
		  }

   }

   function alertContents() {
      if (http_request.readyState == 4) {
         if (http_request.status == 200 || http_request.status==201) {
            alert('Response received from server:\n'+http_request.responseText);
            result = http_request.responseText;
			//  Turn < and > into &lt; and &gt; (case matters)
		  //  result = result.replace(/\<([^!])/g, '&lt;$1');
		  //  result = result.replace(/([^-])\>/g, '$1&gt;');
            if (result === 'success'){
                document.getElementById('serverresponse').innerHTML = result;
            }else{
              var myObject = eval('(' + result + ')');
              document.getElementById('serverresponse').innerHTML = myObject.firstName;
              document.getElementById('serverresponse2').innerHTML= myObject.lastName;
            }
         } else {
            alert('There was a problem with the request.' + http_request.responseText +'XXXXXXXXXXXXXXXXXXXXX '+ http_request.status);
			document.getElementById('serverresponse').innerHTML = http_request.responseText;
         }
      }
   }

   function getTheForm() {
      var getStr = encodeURI(document.myform.xmldata.value) ;
	   alert('Sending XML to server:\n'+getStr);
      makePOSTRequest('GET',document.myform.endpointURL.value , getStr);
   }

   function postTheForm() {
      var poststr = document.myform.xmldata.value ;
	 //  alert('Sending XML to server:\n'+poststr);
      makePOSTRequest('POST',document.myform.endpointURL.value , poststr);
   }




</script>
</head>

<body>



<form action="javascript:get(document.getElementById('myform'));" name="myform" id="myform">
  <table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td><b>Endpoint URL</b></td>
      <td colspan="3"><input name="endpointURL" type="text" value="http://localhost:8080/EntityDatabaseDAL/resources/entity/user/create/" size="100"></td>
    </tr>
    <tr>
      <td><b>XML to send</b> </td>
      <td colspan="3"><textarea name="xmldata" cols="100" rows="26"></textarea></td>
  </tr></table>
   <table> <tr>
      <td><input type="button" name="getbutton" value="SEND via GET"  onclick="javascript:getTheForm();">	  </td>
      <td><input type="button" name="putbutton" value="SEND Via POST" onclick="javascript:postTheForm();"></td>
    </tr>
  </table>
</form>

<h3><br>
  <br>
Server-Response:<br>
</h3>
<hr>
<span name="serverresponse" id="serverresponse"></span> <br/><br/>
<span name="serverresponse2" id="serverresponse2"></span> <br/><br/>

<hr>
</body>
</html>