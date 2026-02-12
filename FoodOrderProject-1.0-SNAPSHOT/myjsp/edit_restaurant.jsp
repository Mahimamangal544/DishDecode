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

        <a href="owner_menus.jsp" class="back-btn">⬅ Back</a>

        <div class="container">
            <h2>Edit Restaurant Details</h2>

            <%
                String id = request.getParameter("id");
                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/foodorder", "root", "root");

                    String q = "select Resturant_Name , Resturant_Email , Resturant_Phoneno , Resturant_Address , "
                            + "Resturant_Ownername , Resturant_Opentime , Resturant_Closetime from resturantdetail "
                            + "where Resturant_UniqueID = ?";
                    pst = con.prepareStatement(q);
                    pst.setString(1, id);
                    rs = pst.executeQuery();
                    if (rs.next()) {
            %>

            <form action="/FoodOrderProject/updateresturant" method="post">
                
                <input type="hidden" name="id" value="<%=id%>">


                <div class="form-group">
                    <label>Restaurant Name</label>
                    <input type="text" name="name" value="<%=rs.getString("Resturant_Name")%>"
                           placeholder="Enter restaurant name">
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Owner Name</label>
                        <input type="text" name="ownername" value="<%=rs.getString("Resturant_Ownername")%>"
                               placeholder="Enter owner name">
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" value="<%=rs.getString("Resturant_Email")%>"
                               placeholder="Enter email">
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" value="<%=rs.getString("Resturant_Phoneno")%>"
                               placeholder="Enter phone number">
                    </div>

                    <div class="form-group">
                        <label>Opening Time</label>
                        <input type="time" name="opentime" value="<%=rs.getString("Resturant_Opentime")%>">
                    </div>
                </div>

                <div class="form-group">
                    <label>Closing Time</label>
                    <input type="time" name="closetime" value="<%=rs.getString("Resturant_Closetime")%>">
                </div>

                <div class="form-group">
                    <label>Restaurant Address</label>
                    <input type="textarea" name="address" value="<%=rs.getString("Resturant_Address")%>" 
                           placeholder="Enter full address">
                </div>

                <%
                    }
                %>

                <div class="btn-group">
                    <button type="submit" class="save-btn">Save Changes</button>
                    
                </div>

            </form>
        </div>

        <%rs
                        .close();
                pst.close();
                con.close();
            } catch (Exception e) {
                out.println(e);
            }
        %>

    </body>
</html>

