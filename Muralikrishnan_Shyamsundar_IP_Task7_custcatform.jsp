<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Retrieve Customers from a range of category</title>
    </head>
    <body>
        <h2>Retrieve Customers from a range of category</h2>
        <!--
            
        -->
        <form action="catcust.jsp">
            <!-- The form organized in an HTML table for better clarity. -->
            <table border=1>
                <tr>
                    <th colspan="2">Enter category values:</th>
                </tr>
                <tr>
                    <td>Start value:</td>
                    <td><div style="text-align: center;">
                    <input type=text name=category1>
                    </div></td>
                </tr>
                <tr>
                    <td>End value:</td>
                    <td><div style="text-align: center;">
                    <input type=text name=category2>
                    </div></td>
                </tr>
            
                <tr>
                    <td><div style="text-align: center;">
                    <input type=reset value=Clear>
                    </div></td>
                    <td><div style="text-align: center;">
                    <input type=submit value=Insert>
                    </div></td>
                </tr>
            </table>
        </form>
    </body>
</html>
