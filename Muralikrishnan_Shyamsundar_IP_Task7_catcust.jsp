<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
        <title>Customer from a range of category</title>
    </head>
    <body>
        <%@page import="jsp_azure_test.datahandler"%>
        <%@page import="java.sql.ResultSet"%>
        <%
            // We instantiate the data handler here            final datahandler handler = new datahandler();

        // Get the attribute values passed from the input form.
        String r1 = request.getParameter("category1");
        String r2 = request.getParameter("category2");
 
        
        if (r1.equals("") || r1.equals("")) {
            response.sendRedirect("custcatform.jsp");
        } else {
            int s1 = Integer.parseInt(r1);
            int s2 = Integer.parseInt(r2);
        
            final ResultSet customers = handler.getcustomername(s1, s2);
        %>
        <!-- The table for displaying all the customers -->
        <table cellspacing="2" cellpadding="2" border="1">
            <tr> <!-- The table headers row -->
              <td align="center">
                <h4>Customer Name</h4>
              </td>
              <td align="center">
                <h4>Address</h4>
              </td>
              <td align="center">
                <h4>Category</h4>
              </td>
            </tr>
            <%
               while(customers.next()) { 
                   final String Cname = customers.getString("Customer_name");
                   final String Address = customers.getString("Addr");
                   final String Cate = customers.getString("category");
                   
                   out.println("<tr>"); // Start printing out the new table row
                   out.println( // Print each attribute value
                        "<td align=\"center\">" + Cname +
                        "</td><td align=\"center\"> " + Address +
                        "</td><td align=\"center\"> " + Cate + "</td>");
                   out.println("</tr>");
               }
        }
               %>
          </table>
    </body>
</html>
