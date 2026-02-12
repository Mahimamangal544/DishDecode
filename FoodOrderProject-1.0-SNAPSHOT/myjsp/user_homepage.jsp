<%-- 
    Document   : afteruserlogin
    Created on : 19 Dec 2025, 11:29:54 am
    Author     : mahim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../mycss/homepage.css">
        <title>DishDecode | Home</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
        </style>

    </head>

    <body>

        <!-- NAVBAR -->
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

        <!-- HERO SECTION -->
        <div class="img">
            <div class="content">
                <h1>Eat Healthy ● Live Fresh</h1>
                <h2>Order Smart</h2>
                <p>Discover delicious, nutritious meals crafted with premium ingredients<br>
                    and delivered fresh to your doorstep.</p>
            </div>
        </div>

        <!-- CATEGORY SECTION -->
        <div class="category">
            <h2>Top Categories</h2>
            <p>Explore our diverse selection of healthy food categories</p>

            <div class="dishes">
                <div class="pic">
                    <img class="picture" src="../Image/salad.avif">
                    <div class="picabout">
                        <div class="dishname">Salad</div>
                        <div class="dishqty">20+ dishes</div>
                    </div>
                </div>

                <div class="pic">
                    <img class="picture" src="../Image/fruit.jpg">
                    <div class="picabout">
                        <div class="dishname">Fruits</div>
                        <div class="dishqty">15+ dishes</div>
                    </div>
                </div>

                <div class="pic">
                    <img class="picture" src="../Image/fastfood.jpg">
                    <div class="picabout">
                        <div class="dishname">Chinese</div>
                        <div class="dishqty">28+ dishes</div>
                    </div>
                </div>

                <div class="pic">
                    <img class="picture" src="../Image/Indian-food-765x760.jpg">
                    <div class="picabout">
                        <div class="dishname">Indian</div>
                        <div class="dishqty">30+ dishes</div>
                    </div>
                </div>

                <div class="pic">
                    <img class="picture" src="../Image/smoothie.webp">
                    <div class="picabout">
                        <div class="dishname">Smoothies</div>
                        <div class="dishqty">23+ dishes</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- WHY CHOOSE DISHDECODE -->
        <div class="why">
            <h2>Why Choose DishDecode?</h2>
            <p>We're revolutionizing food delivery with complete transparency, keeping<br>
                you safe and informed about every bite.</p>

            <div class="why-cards">

                <div class="why-card">
                    <i class="fa-solid fa-eye icon green"></i>
                    <h3>Complete Transparency</h3>
                    <p>See every ingredient in your food with detailed nutritional breakdowns
                        and allergen information.</p>
                </div>

                <div class="why-card">
                    <i class="fa-solid fa-shield icon green"></i>
                    <h3>Allergy Protection</h3>
                    <p>Set your allergies once and get instant alerts. Never worry about
                        accidental exposure again.</p>
                </div>

                <div class="why-card">
                    <i class="fa-solid fa-chart-column icon yellow"></i>
                    <h3>Health Analytics</h3>
                    <p>Visual charts showing calories, macros, and health scores to make informed food choices.</p>
                </div>

                <div class="why-card">
                    <i class="fa-solid fa-users icon yellow"></i>
                    <h3>Restaurant Partners</h3>
                    <p>Trusted restaurants committed to ingredient transparency and food safety standards.</p>
                </div>

            </div>
        </div>

        <!-- 🌿 GREEN HEALTH SECTION -->
        <div class="health-section">
            <h1>Start Your Healthy Food Journey Today</h1>
            <p>Join thousands of users who prioritize their health with informed food choices.</p>

            <button class="find-btn">
                <i class="fa-solid fa-magnifying-glass"></i>
                Find Restaurants Near You
            </button>
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
