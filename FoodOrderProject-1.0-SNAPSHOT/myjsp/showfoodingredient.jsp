<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Fresh Garden Salad | DishDecode</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <!-- CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/guest_fooddetail.css">
    </head>
    <style>
        .food-img-box {
            width: 500px;
            height: 330px;
            flex-shrink: 0;
            position: relative;/* fallback bg */
        }

        .food-img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .back-btn {
            text-decoration: none;
            color: #1e8e3e;
            font-weight: 500;
            font-size: 14px;
            display: inline-block;
            margin-bottom: 25px;
        }

        .back-btn:hover {
            text-decoration: underline;
        }
        
    </style>

    <body>

        <!-- ================= NAVBAR (UNCHANGED) ================= -->
        <div class="navbar">
            <div class="navsection">
                <div class="navsec1">DishDecode</div>

                <div class="navsec2">
                    <a href="owner_homepage.jsp">Home</a>
                    <a href="owner_menu.jsp">Menu</a>
                    <a href="addfooditem.jsp">Add FoodItem</a>
                </div>

                <div class="navsec3">
                    <a class="login" href="../myhtml/login_user.html"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
                    <a class="signup" href="../myhtml/signup_user.html"><i class="fa-solid fa-user-plus"></i> Sign Up</a>
                    <a class="continue" href="#">
                        <i class="fa-solid fa-user"></i> Email: ${ownerEmail}
                    </a>
                </div>
            </div>
        </div>

        <!-- ================= MAIN CONTENT ================= -->
        
        <a href="owner_menus.jsp" class="back-btn">⬅ Back</a>
        
        <div class="container">
            <div class="resto-card">
                <%
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;
                    ArrayList<String[]> list = (ArrayList<String[]>) request.getAttribute("shows");
                    if (list != null) {
                        for (String[] user : list) {
                %>
                <h1 class="resto-name"><%= user[4]%></h1>
                <p class="resto-cuisine">
                    <%= user[5]%>
                </p>
                <p class="resto-address">
                    <%= user[7]%>
                </p>
                <div class="resto-meta">
                    <span class="open">Open Now</span>
                    <span class="time"><%= user[8]%> – <%= user[9]%></span>
                    <span class="divider">|</span>
                    <span class="phone">📞 <%= user[6]%></span>
                </div>
            </div>
            <hr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/foodorder", "root", "root");
                    String foodid = (String) request.getAttribute("foodid");
                    String q = "select FoodItem_Name from fooditem where FoodItem_UniqueID = ?";
                    pst = con.prepareStatement(q);
                    pst.setString(1, foodid);
                    rs = pst.executeQuery();
                    if (rs.next()) {
            %>

            <div class="food-section">
                <div class="food-img-box">
                    <img src="<%=request.getContextPath()%>/showfoodimg?id=<%= rs.getString("FoodItem_Name")%>"
                         alt="Food Image">
                </div>
                <%}%>
                <div>
                    <h2 class="food-name"><%= user[1]%></h2>
                    <p class="food-desc">
                        <%= user[2]%>
                    </p>

                    <div class="price-cart">
                        <div class="food-price">₹<%= user[3]%></div>
                        </div>

                    <%

                        double totalCalories = 0, totalCarbs = 0, totalProtein = 0, totalFat = 0;

                        String q2 = "SELECT SUM(calories_kcal) AS totalCalories, "
                                + "SUM(carbs_g) AS totalCarbs, "
                                + "SUM(protein_g) AS totalProtein, "
                                + "SUM(fat_g) AS totalFat "
                                + "FROM foodingredientdetail WHERE FoodItem_UniqueID=?";

                        pst = con.prepareStatement(q2);
                        pst.setString(1, foodid);
                        rs = pst.executeQuery();

                        if (rs.next()) {
                            totalCalories = rs.getDouble("totalCalories");
                            totalCarbs = rs.getDouble("totalCarbs");
                            totalProtein = rs.getDouble("totalProtein");
                            totalFat = rs.getDouble("totalFat");
                        }

                    %>

                    <div class="side-nutrition">
                        <div class="nut-box calories">🔥Calories<br> <%= totalCalories%></div>
                        <div class="nut-box carbs">🍞Carbs<br><%= totalCarbs%></div>
                        <div class="nut-box protein">💪Protein<br> <%= totalProtein%></div>
                        <div class="nut-box fat">🧈Fats<br><%= totalFat%></div>
                    </div>
                </div>
            </div>


            <%
                            rs.close();
                            pst.close();
                        } catch (Exception e) {
                            out.println(e);
                        } finally {
                            if (rs != null) {
                                rs.close();
                            }
                            if (pst != null) {
                                pst.close();
                            }
                            if (con != null) {
                                con.close();
                            }
                        }
                    }
                }
            %>


            <!-- ================= INGREDIENTS TABLE ================= -->
            <div class="table-section">
                <h2>Ingredients & Quantity</h2>
                <table>
                    <tr>
                        <th>Ingredient</th>
                        <th>Unit</th>
                        <th>Quantity</th>
                        <th>Calories</th>
                        <th>Carbs</th>
                        <th>Protein</th>
                        <th>Fat</th>
                    </tr>

                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection(
                                    "jdbc:mysql://localhost:3306/foodorder", "root", "root");

                            String foodid = (String) request.getAttribute("foodid");

                            // Ingredient list
                            String q1 = "SELECT i.Ingredient_Name, f.unit, f.Quantity, "
                                    + "f.calories_kcal, f.carbs_g, f.protein_g, f.fat_g "
                                    + "FROM foodingredientdetail f "
                                    + "INNER JOIN ingredient i "
                                    + "ON i.Ingredient_UniqueID = f.Ingredient_UniqueID "
                                    + "WHERE f.FoodItem_UniqueID = ?";

                            pst = con.prepareStatement(q1);
                            pst.setString(1, foodid);
                            rs = pst.executeQuery();

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getString("Ingredient_Name")%></td>
                        <td><%= rs.getString("unit")%></td>
                        <td><%= rs.getInt("Quantity")%></td>
                        <td><%= rs.getDouble("calories_kcal")%></td>
                        <td><%= rs.getDouble("carbs_g")%></td>
                        <td><%= rs.getDouble("protein_g")%></td>
                        <td><%= rs.getDouble("fat_g")%></td>
                    </tr>

                    <%
                            }
                            rs.close();
                            pst.close();

                            // TOTAL nutrition
                        } catch (Exception e) {
                            out.println(e);
                        } finally {
                            if (rs != null) {
                                rs.close();
                            }
                            if (pst != null) {
                                pst.close();
                            }
                            if (con != null) {
                                con.close();
                            }
                        }
                    %>

                </table>




            </div>
        </div>

        <!-- 🌿 FOOTER ADDED AT LAST -->
        <footer class="footer">
            <div class="footer-section">
                <h2 class="brand"><span class="leaf">🍃</span> DishDecode</h2>
                <p>Delivering fresh, healthy meals to your doorstep. Eat healthy, live fresh, order smart.</p>
                <div class="social">
                    <i class="fa-brands fa-facebook"></i>
                    <i class="fa-brands fa-twitter"></i>
                    <i class="fa-brands fa-instagram"></i>
                    <i class="fa-brands fa-youtube"></i>
                </div>
            </div>

            <div class="footer-section">
                <h3>Categories</h3>
                <p>Salads</p>
                <p>Fruits</p>
                <p>Indian</p>
                <p>Chinese</p>
                <p>Vegan</p>
                <p>Bowls</p>
            </div>

            <div class="footer-section">
                <h3>Support</h3>
                <p>Help Center</p>
                <p>Terms of Service</p>
                <p>Privacy Policy</p>
                <p>FAQs</p>
            </div>

            <div class="footer-section">
                <h3>Contact Us</h3>
                <p>123 Health Street</p>
                <p>Fresh City, FC 12345</p>
                <p>contact@dishdecode.com</p>
                <p>(555) 123–4567</p>
            </div>
        </footer>

    </body>
</html>
