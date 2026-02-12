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

        <style>
            .back-btn {
                margin-top: 20px;
                margin-left: 30px;
                text-decoration: none;
                color: #1e8e3e;
                font-weight: 600;
                font-size: 18px;
                display: inline-block;
                margin-bottom: 25px;
            }

            .back-btn:hover {
                text-decoration: underline;
            }
        </style>

    </head>

    <body>

        <!-- ================= NAVBAR ================= -->
        <div class="navbar">
            <div class="navsection">
                <div class="navsec1">DishDecode</div>

                <div class="navsec2">
                    <a href="../myhtml/home_page.html">Home</a>
                    <a href="guest_resturant.jsp">Restaurants</a>
                    <a href="guest_menu.jsp">Menu</a>
                </div>

                <div class="navsec3">
                    <a class="login" href="../myhtml/login_user.html"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
                    <a class="signup" href="../myhtml/signup_user.html"><i class="fa-solid fa-user-plus"></i> Sign Up</a>
                    <a class="continue" href="#"><i class="fa-solid fa-user"></i> Guest</a>
                </div>
            </div>
        </div>
        
        <%
            String id = request.getParameter("name");
        %>

        <!-- ================= Container ================= -->
        <div class="container">
            <div class="resto-card">
                <%
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/foodorder", "root", "root");
                        String q1 = "select r.Resturant_Name , r.Resturant_Email , r.Resturant_Phoneno , r.Resturant_Address ,"
                                + "r.Resturant_Opentime , r.Resturant_Closetime from resturantdetail r inner join "
                                + "foodresturantdetail fr on r.Resturant_UniqueID = fr.Resturant_UniqueID inner join "
                                + "fooditem f on fr.Fooditem_UniqueID = f.Fooditem_UniqueID where f.Fooditem_UniqueID = ?";
                        pst = con.prepareStatement(q1);
                        pst.setString(1, id);
                        rs = pst.executeQuery();
                        if (rs.next()) {
                %>

                <h1 class="resto-name"><%=rs.getString("Resturant_Name")%></h1>
                <p class="resto-cuisine"><%=rs.getString("Resturant_Email")%></p>
                <p class="resto-address"><%=rs.getString("Resturant_Address")%></p>
                <div class="resto-meta">
                    <span class="open">Open Now</span>    
                    <span class="time"><%=rs.getString("Resturant_Opentime")%> - 
                        <%=rs.getString("Resturant_Closetime")%></span>
                    <span class="divider">|</span>
                    <span class="phone"><%=rs.getString("Resturant_Phoneno")%></span>
                </div>
            </div>
            <hr>

            <%
                String q2 = "select f.Fooditem_Name , f.Fooditem_Description , fr.price from fooditem f inner join"
                        + " foodresturantdetail fr on f.Fooditem_UniqueID = fr.Fooditem_UniqueID where f.Fooditem_UniqueID =?";
                pst = con.prepareStatement(q2);
                pst.setString(1, id);
                rs = pst.executeQuery();
                if (rs.next()) {
            %>

            <div class="food-section">
                <div class="food-img-box">
                    <img src="<%=request.getContextPath()%>/showfoodimg?id=<%= rs.getString("FoodItem_Name")%>"
                         alt="Food Image"></div>
                <div>
                    <h2 class="food-name"><input type="hidden" name="foodname" 
                                                 value="<%= rs.getString("Fooditem_Name")%>"><%= rs.getString("Fooditem_Name")%>
                    </h2>
                    <p class="food-desc"><%=rs.getString("Fooditem_Description")%></p>
                    <div class="qty-box">
                        Add Quantity  
                        <button type="button" onclick="decreaseQty()">−</button>
                        <span id="qty">1</span>
                        <button type="button" onclick="increaseQty()">+</button>

                        <!-- 👇 YE ADD KARO (hidden input) -->
                        <input type="hidden" name="quantity" id="quantityInput" value="1">
                    </div>

                    <div class="price-cart">

                        <div class="food-price">
                            ₹<input type="hidden" name="price" 
                                    value="<%= rs.getInt("price")%>"><%= rs.getInt("price")%>
                        </div>

                        <button type="button" class="cart-btn" onclick="checkLoginAndSubmit()">
                            🛒 Add to Cart
                        </button>

                    </div>

                    <%
                        double totalCalories = 0, totalCarbs = 0, totalProtein = 0, totalFat = 0;

                        String q3 = "SELECT SUM(fi.calories_kcal) AS totalCalories, "
                                + "SUM(fi.carbs_g) AS totalCarbs, "
                                + "SUM(fi.protein_g) AS totalProtein, "
                                + "SUM(fi.fat_g) AS totalFat "
                                + "FROM foodingredientdetail fi inner join fooditem f on"
                                + " fi.Fooditem_UniqueID = f.Fooditem_UniqueID WHERE f.Fooditem_UniqueID=?";

                        pst = con.prepareStatement(q3);
                        pst.setString(1, id);
                        rs = pst.executeQuery();

                        if (rs.next()) {
                            totalCalories = rs.getDouble("totalCalories");
                            totalCarbs = rs.getDouble("totalCarbs");
                            totalProtein = rs.getDouble("totalProtein");
                            totalFat = rs.getDouble("totalFat");
                        }
                    %>
                    <div class="side-nutrition">
                        <div class="nut-box calories">🔥Calories<br>
                            <input type="hidden" name="cal" 
                                   value="<%= totalCalories%>"><%= totalCalories%> </div>
                        <div class="nut-box carbs">🍞Carbs<br>
                            <input type="hidden" name="car" 
                                   value="<%= totalCarbs%>"><%= totalCarbs%></div>
                        <div class="nut-box protein">💪Protein<br> 
                            <input type="hidden" name="pro" 
                                   value="<%= totalProtein%>"><%= totalProtein%></div>
                        <div class="nut-box fat">🧈Fats<br>
                            <input type="hidden" name="fat" 
                                   value="<%= totalFat%>"><%= totalFat%></div>
                    </div>
                </div>
            </div>

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
                        String q4 = "SELECT i.Ingredient_Name, f.unit, f.Quantity, "
                                + "f.calories_kcal, f.carbs_g, f.protein_g, f.fat_g "
                                + "FROM foodingredientdetail f "
                                + "INNER JOIN ingredient i "
                                + "ON i.Ingredient_UniqueID = f.Ingredient_UniqueID inner join "
                                + "fooditem fo on f.Fooditem_UniqueID = fo.Fooditem_UniqueID "
                                + "WHERE fo.FoodItem_UniqueID = ?";

                        pst = con.prepareStatement(q4);
                        pst.setString(1, id);
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
                                }
                            }
                            rs.close();
                            pst.close();
                            con.close();
                        } catch (Exception e) {
                            out.println(e);
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


        <script>
            let qty = 1;

            function increaseQty() {
                qty++;
                document.getElementById("qty").innerText = qty;
                document.getElementById("quantityInput").value = qty;
            }

            function decreaseQty() {
                if (qty > 1) {
                    qty--;
                    document.getElementById("qty").innerText = qty;
                    document.getElementById("quantityInput").value = qty;
                }
            }

            function checkLoginAndSubmit() {
                alert("Please login first to add items to cart");
            }

        </script>



    </body>
</html>
