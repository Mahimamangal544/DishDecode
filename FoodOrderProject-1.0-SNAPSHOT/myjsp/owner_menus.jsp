<%-- 
    Document   : owner_menus
    Created on : 29 Jan 2026, 10:13:25 pm
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

        <!-- CSS-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/owner_menus.css">

    </head>

    <style>
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

        <!-- ================= NAVBAR ================= -->
        <div class="navbar">
            <div class="navsection">
                <div class="navsec1">DishDecode</div>

                <div class="navsec2">
                    <a href="owner_homepage.jsp">Home</a>
                    <a href="owner_menu.jsp">Menu</a>
                    <a href="addfooditem.jsp">Add FoodItem</a>
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

                            <a href="../myhtml/home_page.html">
                                <i class="fa-solid fa-right-from-bracket"></i> Logout
                            </a>
                        </div>
                    </div>
                </div> 
            </div>
        </div>

        <!-- ================= container ================= -->
        
        <a href="owner_homepage.jsp" class="back-btn">⬅ Back</a>
        
        <div class="container"> 

            <!-- ================= resto info ================= -->
            <div class="resto-card">
                <%
                    String email = (String) session.getAttribute("ownerEmail");
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection(
                                "jdbc:mysql://localhost:3306/foodorder", "root", "root");

                        String q = "select Resturant_UniqueID from resturantdetail where Resturant_Email = ?";
                        pst = con.prepareStatement(q);
                        pst.setString(1, email);
                        rs = pst.executeQuery();

                        String id = null;

                        if (rs.next()) {
                            id = rs.getString("Resturant_UniqueID");
                        }

                        String q3 = "select Resturant_UniqueID, Resturant_Name , Resturant_Email , Resturant_Phoneno , Resturant_Address  , "
                                + "Resturant_Opentime , Resturant_Closetime from resturantdetail "
                                + "where Resturant_UniqueID = ?";
                        pst = con.prepareStatement(q3);
                        pst.setString(1, id);
                        rs = pst.executeQuery();
                        while (rs.next()) {
                %>
                <h1 class="resto-name"><%=rs.getString("Resturant_Name")%></h1>
                <p class="resto-cuisine"><b>Email :</b>  <%=rs.getString("Resturant_Email")%></p>
                <p class="resto-address"><b>Address :</b>  <%=rs.getString("Resturant_Address")%></p>
                <p class="resto-cuisine"><b>Phone no :</b>  <%=rs.getString("Resturant_Phoneno")%></p>
                <p class="resto-address"><b>Open Time :</b>  <%=rs.getString("Resturant_Opentime")%></p>
                <p class="resto-cuisine"><b>Close Time :</b>  <%=rs.getString("Resturant_Closetime")%></p>
                <a href="edit_restaurant.jsp?id=<%= rs.getString("Resturant_UniqueID")%>">
                    <button class="view-btn" style="width: 15%">View Details</button></a>
            </div>

        </div> 
        <hr>

        <!-- ================= food info ================= -->
        <%
            }
            String q1 = "select f.FoodItem_UniqueID, fr.Resturant_UniqueID, f.FoodItem_Name, fr.price , f.FoodItem_Description "
                    + "from fooditem f inner join foodresturantdetail fr on f.FoodItem_UniqueID = "
                    + "fr.FoodItem_UniqueID where fr.Resturant_UniqueID = ? ";
            pst = con.prepareStatement(q1);
            pst.setString(1, id);
            rs = pst.executeQuery();
        %>
        <div class="restaurant-grid">

            <%    while (rs.next()) {
            %>

            <div class="restaurant-box">
                <div class="rest-img">
                    <img src="<%=request.getContextPath()%>/showfoodimg?id=<%= rs.getString("FoodItem_Name")%>"
                         alt="Food Image">
                </div>

                <div class="rest-info">
                    <h4><%= rs.getString("FoodItem_Name")%></h4>
                    <h4>Price : <%= rs.getString("price")%></h4>


                    <div class="address">
                        <%= rs.getString("FoodItem_Description")%>
                    </div>

                    <a href="owner_fooddetail.jsp?id=<%= rs.getString("FoodItem_UniqueID")%>">
                        <button class="view-btn">View Details</button></a>
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
            function toggleDropdown() {
                var dropdown = document.getElementById("userDropdown");
                dropdown.classList.toggle("show");
            }

            // Click outside to close
            window.onclick = function (event) {
                if (!event.target.closest('.user-menu')) {
                    var dropdown = document.getElementById("userDropdown");
                    if (dropdown.classList.contains('show')) {
                        dropdown.classList.remove('show');
                    }
                }
            };
        </script>

    </body>
</html>
