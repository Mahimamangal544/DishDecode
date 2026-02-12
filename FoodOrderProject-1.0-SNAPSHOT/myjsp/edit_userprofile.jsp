<%-- 
    Document   : edit_restaurant
    Created on : 28 Jan 2026, 7:17:53 pm
    Author     : mahim
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/edit_resturant.css">
        <title>JSP Page</title>
    </head>
    <body>

        <a href="user_profile.jsp" class="back-btn">⬅ Back</a>

        <div class="container">
            <h2>Edit Details</h2>

            <%
                String email = (String) session.getAttribute("ownerEmail");

                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/foodorder", "root", "root");

                    String q = "select Customer_UniqueID, Customer_Name , Customer_Email , "
                            + "Customer_Phoneno , Customer_Address"
                            + " ,Customer_Password from "
                            + "customerdetails where Customer_Email = ?";
                    pst = con.prepareStatement(q);
                    pst.setString(1, email);
                    rs = pst.executeQuery();
                    if (rs.next()) {
            %>

            <form action="/FoodOrderProject/edituserprofile" method="post">
                <input type="hidden" name="id" value="<%=rs.getString("Customer_UniqueID")%>">

                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="name" value="<%=rs.getString("Customer_Name")%>"
                           placeholder="Enter name">
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" name="email" value="<%=rs.getString("Customer_Email")%>"
                               placeholder="Enter owner name">
                    </div>

                    <div class="form-group">
                        <label>Phone no</label>
                        <input type="number" name="phone" value="<%=rs.getString("Customer_Phoneno")%>">

                    </div>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="textarea" name="add" value="<%=rs.getString("Customer_Address")%>" 
                           placeholder="Enter full address">
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="text" name="pass" value="<%=rs.getString("Customer_Password")%>" 
                           >
                </div>

                <%
                    }
                %>

                <div class="btn-group">
                    <button type="submit" class="save-btn">Save Changes</button>

                </div>

            </form>
        </div>

        <%
                rs.close();
                pst.close();
                con.close();
            } catch (Exception e) {
                out.println(e);
            }
        %>

    </body>
</html>

