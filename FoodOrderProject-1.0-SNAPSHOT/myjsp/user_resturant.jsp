<%-- 
    Document   : showresturant
    Created on : 23 Dec 2025, 7:40:27 pm
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/guest_resturant.css">
        <style>
            /* ===== RESTAURANT GRID ===== */
            .restaurant-grid {
                width: 75%;
                margin: 60px auto;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 80px;
            }

            /* ===== CARD ===== */
            .restaurant-box {
                background: #fff;
                border-radius: 18px;
                overflow: hidden;
                box-shadow: 0 8px 25px rgba(0,0,0,0.08);
                transition: transform 0.25s ease, box-shadow 0.25s ease;
            }

            .restaurant-box:hover {
                transform: translateY(-6px);
                box-shadow: 0 18px 40px rgba(0,0,0,0.15);
            }

            /* IMAGE */ .rest-img {
                margin-top: 10px;
                position: relative;
                height: 180px;
            }
            .rest-img img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            /* IMAGE OVERLAY */
            .rest-img::after {
                content: "";
                position: absolute;
                inset: 0;
                background: linear-gradient(to top, rgba(0,0,0,0), transparent);
            }

            /* ===== INFO ===== */
            .rest-info {
                padding: 16px 18px 20px;
            }

            .rest-info h4 {
                font-size: 19px;
                font-weight: 600;
                color: #222;
                margin-bottom: 8px;
            }

            /* ADDRESS */
            .address {
                font-size: 14px;
                color: #666;
                margin-bottom: 6px;
            }

            /* OPEN TIME BADGE */
            .open-time {
                display: inline-block;
                font-size: 13px;
                background: #eaf7ef;
                color: #1a7f37;
                padding: 4px 10px;
                border-radius: 20px;
                margin: 8px 0 14px;
                font-weight: 500;
            }

            /* BUTTON */
            .view-btn {
                width: 100%;
                padding: 11px 0;
                border: none;
                background: linear-gradient(135deg, #16a249, #12823a);
                color: #fff;
                font-size: 15px;
                font-weight: 500;
                border-radius: 10px;
                cursor: pointer;
                transition: opacity 0.3s ease, transform 0.2s ease;
            }

            .view-btn:hover {
                opacity: 0.9;
                transform: scale(1.02);
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

        <!-- container -->

        <a href="user_homepage.jsp" class="back-btn">⬅ Back</a>

        <%
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/foodorder", "root", "root");

                String q1 = "select Resturant_Name, Resturant_Address , Resturant_Opentime, Resturant_Closetime "
                        + "from resturantdetail";
                pst = con.prepareStatement(q1);
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
                    <div class="open-time">
                        Open • <%= rs.getString("Resturant_Opentime")%> - <%= rs.getString("Resturant_Closetime")%>
                    </div>

                    <a href="user_resturantdetail.jsp?name=<%= rs.getString("Resturant_Name")%>">
                        <button class="view-btn">View Details</button>
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
