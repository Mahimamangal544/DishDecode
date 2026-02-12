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
                String fid = request.getParameter("id");
                
                Connection con = null;
                PreparedStatement pst = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/foodorder", "root", "root");

                    String q = "select f.Fooditem_Name , f.Fooditem_Type , f.Fooditem_Description , fr.price "
                            + "from fooditem f inner join foodresturantdetail fr on f.Fooditem_UniqueID = "
                            + "fr.Fooditem_UniqueID where f.Fooditem_UniqueID =?";
                    pst = con.prepareStatement(q);
                    pst.setString(1, fid);
                    rs = pst.executeQuery();
                    if (rs.next()) {
            %>

            <form action="/FoodOrderProject/editfooditem" method="post">
                
                <input type="hidden" name="id" value="<%=fid%>">


                <div class="form-group">
                    <label>Food Name</label>
                    <input type="text" name="name" value="<%=rs.getString("Fooditem_Name")%>"
                           placeholder="Enter restaurant name">
                </div>

                <div class="row">
                    <div class="form-group">
                        <label>Food Type</label>
                        <input type="text" name="type" value="<%=rs.getString("Fooditem_Type")%>"
                               placeholder="Enter owner name">
                    </div>

                    <div class="form-group">
                        <label>Price</label>
                        <input type="number" name="price" value="<%=rs.getString("price")%>">

                    </div>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <input type="textarea" name="description" value="<%=rs.getString("Fooditem_Description")%>" 
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

