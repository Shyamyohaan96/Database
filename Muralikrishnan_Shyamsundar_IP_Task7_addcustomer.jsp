<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Query Result</title>
</head>
    <body>
    <%@page import="jsp_azure_test.datahandler"%>
    <%@page import="java.sql.ResultSet"%>
    <%@page import="java.sql.Array"%>
    <%
    // The handler is the one in charge of establishing the connection.
    datahandler handler = new datahandler();

    // Get the attribute values passed from the input form.
    String cname = request.getParameter("Customer_name");
    String add = request.getParameter("Addr");
    String cat = request.getParameter("category");
    
    if (cname.equals("") || add.equals("") || cat.equals("")) {
        response.sendRedirect("custform.jsp");
    } else {
        int cate = Integer.parseInt(cat);
        
        // Now perform the query with the data from the form.
        boolean success = handler.addCustomer(cname, add, cate);
        if (!success) { // Something went wrong
            %>
                <h2>There was a problem inserting</h2>
            <%
        } else { // Confirm success to the user
            %>
            <h2>The Customer:</h2>

            <ul>
                <li>Customer name: <%=cname%></li>
                <li>Address: <%=add%></li>
                <li>Category: <%=cate%></li>
            </ul>

            <h2>Was successfully inserted.</h2>
            
            <a href="get_all_cust.jsp">Customer table.</a>
            <%
        }
    }
    %>
    </body>
</html>
