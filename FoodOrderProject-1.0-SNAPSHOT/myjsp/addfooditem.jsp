<%-- 
    Document   : addfooditem
    Created on : 2 Dec 2025, 9:07:30 am
    Author     : mahim
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/addfooditem.css">
        <script src="${pageContext.request.contextPath}/myjs/addfooditem.js"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <!-- BACK TO HOME BUTTON OUTSIDE THE CONTAINER -->
        <div class="back-home-wrapper">
            <a href="owner_homepage.jsp" class="back-home-btn">← Back to Home</a>
        </div>

        <form action="${pageContext.request.contextPath}/storefoodingredient"
              method="post"
              enctype="multipart/form-data">

            <div class="container">

                <h2 class="heading">Add Food Item</h2>

                <div class="top-section">

                    <div class="basic-form">

                        <div class="field">
                            <label>Food Item Name</label>
                            <input type="text" name="foodname" placeholder="Enter food name">
                        </div>

                        <div class="row">
                            <div class="field">
                                <label>Price</label>
                                <input type="number" name="foodprice" placeholder="Price">
                            </div>

                            <div class="field">
                                <label>Type</label>
                                <select name="foodtype">
                                    <option>Veg</option>
                                    <option>Non-Veg</option>
                                </select>
                            </div>
                        </div>

                        <div class="field">
                            <label>Description</label>
                            <textarea placeholder="Write description" name="description"></textarea>
                        </div>

                    </div>

                    <div class="upload-box">
                        <p class="upload-title">Upload Photo</p>

                        <label class="upload-area">
                            <input type="file" name="photo" accept="image/*" required> 

                        </label>
                    </div>


                </div>

                <div class="ingredients-section">
                    <h3 class="sub-heading">Ingredients</h3>

                    <div id="ingredients-container">

                        <div class="ingredient-row">

                            <div><label>Grains</label></div>
                            <div class="group">

                                <select name="grain[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Grains");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="grainqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="grainunit[]">
                                    <option>gram</option>
                                    <option>kg</option>
                                </select>
                            </div>
                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>


                        </div>


                        <div class="ingredient-row">

                            <div><label>Dal aur Beans</label></div>
                            <div class="group">

                                <select name="dalbeans[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Dal aur Beans");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="dalbeansqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="dalbeansunit[]">
                                    <option>gram</option>
                                    <option>kg</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>


                        </div>



                        <div class="ingredient-row">

                            <div> <label>Vegetables</label></div>
                            <div class="group">

                                <select name="vegetables[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Vegetables");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="vegetablesqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="vegetablesunit[]">
                                    <option>gram</option>
                                    <option>kg</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>



                        </div>



                        <div class="ingredient-row">

                            <div><label>Fruits</label></div>
                            <div class="group">

                                <select name="fruits[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Fruits");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="fruitsqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="fruitsunit[]">
                                    <option>gram</option>
                                    <option>kg</option>
                                    <option>tablespoon</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>


                        </div>



                        <div class="ingredient-row">

                            <div> <label>Dairy Products</label></div>
                            <div class="group">

                                <select name="dairyproduct[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Dairy Product");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="dairyproductqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="dairyproductunit[]">
                                    <option>tablespoon</option>
                                    <option>millilitre</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>



                        </div>



                        <div class="ingredient-row">

                            <div> <label>Non Veg</label></div>
                            <div class="group">

                                <select name="nonveg[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Non Veg");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="nonvegqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="nonvegunit[]">
                                    <option>gram</option>
                                    <option>kg</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>


                        </div>



                        <div class="ingredient-row">

                            <div><label>Spices</label></div>
                            <div class="group">

                                <select name="spices[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Spices");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="spicesqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="spicesunit[]">
                                    <option>gram</option>
                                    <option>tablespoon</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>


                        </div>


                        <div class="ingredient-row">

                            <div><label>Herbs</label></div>
                            <div class="group">

                                <select name="herbs[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Herbs");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="herbsqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="herbsunit[]">
                                    <option>gram</option>
                                    <option>tablespoon</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>



                        </div>


                        <div class="ingredient-row">

                            <div><label>Oils and fats</label></div>
                            <div class="group">

                                <select name="oilfat[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Oils and fats");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="oilfatqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="oilfatunit[]">
                                    <option>tablespoon</option>
                                    <option>millilitre</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>


                        </div>


                        <div class="ingredient-row">

                            <div><label>Sweetners</label></div>
                            <div class="group">

                                <select name="sweetners[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Sweetners");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="sweetnersqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="sweetnersunit[]">
                                    <option>gram</option>
                                    <option>tablespoon</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>



                        </div>



                        <div class="ingredient-row">

                            <div><label>Sauces</label></div>
                            <div class="group">

                                <select name="sauces[]">
                                    <option value="">-- Select --</option>
                                    <%
                                        try {
                                            Class.forName("com.mysql.jdbc.Driver");
                                            Connection con = DriverManager.getConnection(
                                                    "jdbc:mysql://localhost:3306/mysql", "root", "root");

                                            String sql = "SELECT Ingredient_ID, Ingredient_Name FROM foodorder.ingredient where Ingredient_Type=?";
                                            PreparedStatement pst = con.prepareStatement(sql);
                                            pst.setString(1, "Sauces");
                                            ResultSet rs = pst.executeQuery();

                                            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("Ingredient_Name")%>">
                                        <%= rs.getString("Ingredient_Name")%>
                                    </option>
                                    <%
                                            }
                                            rs.close();
                                            pst.close();
                                            con.close();

                                        } catch (Exception e) {
                                            out.println(e);
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="group">
                                <label>Quantity</label>
                                <input type="number" placeholder="50" name="saucesqty[]">
                            </div>

                            <div class="group">
                                <label>Unit</label>
                                <select name="saucesunit[]">
                                    <option>gram</option>
                                    <option>tablespoon</option>
                                </select>
                            </div>

                            <button type="button" class="add-btn" onclick="addRow(this)">Add +</button>
                            <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>


                        </div>

                    </div>
                </div>

                <button type="submit" class="submit-btn">Add Food Item</button>


            </div></form> 
    </body>
</html>
