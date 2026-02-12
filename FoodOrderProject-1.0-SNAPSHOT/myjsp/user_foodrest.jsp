<%-- 
    Document   : userrestfood
    Created on : 17 Jan 2026, 8:04:34 pm
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
        <title>JSP Page</title>
        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <!-- CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/guest_foodrest.css">
        <style>
            .resto-card{
                padding:32px;

            }

            .resto-name{
                font-size:36px;
                margin:0;
                color:#1b5e20;
            }

            .resto-cuisine{
                margin:6px 0;
                font-size:15px;
                color:#555;
            }

            .resto-address{
                font-size:14px;
                color:#777;
            }

            .resto-meta{
                margin-top:12px;
                display:flex;
                flex-wrap:wrap;
                gap:14px;
                align-items:center;
                font-size:14px;
            }

            .open{
                background:#e8f5e9;
                color:#2e7d32;
                padding:6px 14px;
                border-radius:20px;
                font-weight:600;
            }

            .time{
                color:#555;
            }
            .phone{
                color:#1b5e20;
                font-weight:500;
            }

            .divider{
                color:#bbb;
            }

            hr{
                border:none;
                border-top:1px solid #e0e0e0;
            }

            .navsec3 {
                position: relative;
            }

            .user-menu {
                position: relative;
            }

            .user-btn {
                background: none;
                border: none;
                cursor: pointer;
                font-size: 18px;
                color: #333;
            }

            .user-btn i {
                margin-left: 5px;
            }

            .dropdown-menu {
                display: none;
                position: absolute;
                right: 0;
                top: 40px;
                background: #fff;
                border-radius: 6px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.15);
                min-width: 220px;
                z-index: 100;
            }

            .dropdown-menu a,
            .dropdown-menu .email-box {
                display: block;
                padding: 10px 15px;
                text-decoration: none;
                color: #333;
                font-size: 14px;
            }

            .dropdown-menu a:hover {
                background-color: #f2f2f2;
            }

            .email-box {
                font-weight: 600;
                border-bottom: 1px solid #ddd;
                background: #fafafa;
            }

            /* important */
            .dropdown-menu.show {
                display: block;
            }

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
                    <a href="user_homepage.jsp">Home</a>
                    <a href="user_resturant.jsp">Restaurants</a>
                    <a href="user_menu.jsp">Menu</a>
                    <a href="addtocart.jsp">Cart</a>
                </div>

                <div class="navsec3">
                    <div class="user-menu">
                        <button class="user-btn" onclick="toggleDropdown()">
                            <i class="fa-solid fa-user"></i>
                            <i class="fa-solid fa-caret-down"></i>
                        </button>

                        <div class="dropdown-menu" id="userDropdown">

                            <!-- EMAIL -->
                            <div class="email-box">
                                <i class="fa-solid fa-envelope"></i>
                                ${ownerEmail}
                            </div>

                            <a href="user_profile.jsp">
                                <i class="fa-solid fa-id-badge"></i> User Profile
                            </a>

                            <a href="../myhtml/home_page.html">
                                <i class="fa-solid fa-right-from-bracket"></i> Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%
            String foodName = request.getParameter("name");
        %>

        <a href="user_menu.jsp" class="back-btn">⬅ Back</a>

        <!-- container -->

        <%
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/foodorder", "root", "root");
                String q = "select f.food_image , f.FoodItem_Name , f.FoodItem_Description , fr.price from fooditem f "
                        + "inner join foodresturantdetail fr on f.FoodItem_UniqueID = fr.FoodItem_UniqueID where "
                        + "f.FoodItem_Name = ?";
                pst = con.prepareStatement(q);
                pst.setString(1, foodName);
                rs = pst.executeQuery();
        %>

        <div class="resto-card">
            <%    while (rs.next()) {
            %>
            <h1 class="resto-name"><%= rs.getString("FoodItem_Name")%></h1>

            <p class="resto-address">
                <%= rs.getString("FoodItem_Description")%>
            </p>

        </div>
        <hr>

        <%
            }
            String q1 = "select fr.price, r.Resturant_UniqueID , r.Resturant_Name , r.Resturant_Address ,"
                    + "r.Resturant_Opentime , r.Resturant_Closetime , "
                    + "r.restimg from resturantdetail r inner join "
                    + "foodresturantdetail fr on r.Resturant_UniqueID = fr.Resturant_UniqueID inner join "
                    + "fooditem f on fr.Fooditem_UniqueID = f.Fooditem_UniqueID where f.Fooditem_Name = ?";
            pst = con.prepareStatement(q1);
            pst.setString(1, foodName);
            rs = pst.executeQuery();

        %>


        <div class="restaurant-grid">

            <%    while (rs.next()) {
            %>

            <div class="restaurant-box">
                <div class="rest-img">
                    <img src="<%=request.getContextPath()%>/showresturantimg?id=<%= rs.getString("Resturant_Name")%>"
                         alt="Restaurant Image">
                </div>

                <div class="rest-info">
                    <h4><%= rs.getString("Resturant_Name")%></h4>

                    <p class="address">Address : <%= rs.getString("Resturant_Address")%></p>
                    <p class="address">Price : <%= rs.getString("price")%></p>
                    <div class="open-time">
                        Open • <%= rs.getString("Resturant_Opentime")%> - <%= rs.getString("Resturant_Closetime")%>
                    </div>

                    <a href="user_fooddetail.jsp?name=<%= foodName%>">
                        <button class="view-btn">Select</button>
                    </a>

                </div>
            </div>

            <%
                }
            %>

        </div>


        <%
                rs.close();
                pst.close();
                con.close();
            } catch (Exception e) {
                out.println(e);
            }
        %>

        <!-- ================= FOOTER ================= -->
        <footer class="footer">
            <div class="footer-section">
                <h2 class="brand"><span class="leaf">🍃</span> DishDecode</h2>
                <p>Delivering fresh, healthy meals to your doorstep.</p>
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
                <p>Indian</p>
                <p>Chinese</p>
                <p>Vegan</p>
            </div>

            <div class="footer-section">
                <h3>Support</h3>
                <p>Help Center</p>
                <p>Privacy Policy</p>
                <p>FAQs</p>
            </div>

            <div class="footer-section">
                <h3>Contact</h3>
                <p>contact@dishdecode.com</p>
                <p>(555) 123-4567</p>
            </div>
        </footer>
    </body>
    <script>
        function toggleDropdown() {
            document.getElementById("userDropdown").classList.toggle("show");
        }

// close dropdown on outside click
        window.onclick = function (event) {
            if (!event.target.closest('.user-menu')) {
                document.getElementById("userDropdown").classList.remove("show");
            }
        };
    </script>
</html>
