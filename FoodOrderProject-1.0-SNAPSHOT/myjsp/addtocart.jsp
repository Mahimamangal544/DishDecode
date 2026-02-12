<%-- 
    Document   : addtocart
    Created on : 10 Jan 2026, 1:03:53 pm
    Author     : mahim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
    List<Map<String, Object>> cart
            = (List<Map<String, Object>>) session.getAttribute("cart");

    if (cart == null) {
        cart = new ArrayList<>();
        session.setAttribute("cart", cart);
    }

    String action = request.getParameter("action");
    String removeFood = request.getParameter("remove");

    /* ===== REMOVE ALL ===== */
    if ("clear".equals(action)) {
        cart.clear();
        session.setAttribute("cart", cart);
        response.sendRedirect("addtocart.jsp");
        return;
    }

    /* ===== REMOVE SINGLE ITEM ===== */
    if (removeFood != null) {
        Iterator<Map<String, Object>> it = cart.iterator();
        while (it.hasNext()) {
            Map<String, Object> item = it.next();
            if (removeFood.equals(item.get("foodname"))) {
                it.remove();
                break;
            }
        }
        session.setAttribute("cart", cart);
        response.sendRedirect("addtocart.jsp");
        return;   // 🔥 VERY IMPORTANT
    }

    /* ===== ADD ITEM (ONLY IF REMOVE NOT CALLED) ===== */
    String foodname = request.getParameter("foodname");
    String priceStr = request.getParameter("price");
    String qtyStr = request.getParameter("quantity");
    String calories = request.getParameter("cal");
    String carbs = request.getParameter("car");
    String protein = request.getParameter("pro");
    String fat = request.getParameter("fat");

    if (foodname != null && priceStr != null && qtyStr != null) {

        int price = Integer.parseInt(priceStr);
        int qty = Integer.parseInt(qtyStr);

        Map<String, Object> item = new HashMap<>();
        item.put("foodname", foodname);
        item.put("price", price);
        item.put("qty", qty);
        item.put("tprice", price * qty);
        item.put("cal", Double.parseDouble(calories) * qty);
        item.put("car", Double.parseDouble(carbs) * qty);
        item.put("pro", Double.parseDouble(protein) * qty);
        item.put("fat", Double.parseDouble(fat) * qty);

        cart.add(item);
        session.setAttribute("cart", cart);

        response.sendRedirect("addtocart.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Your Cart</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/mycss/addtocart.css">
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

                            <a href="../logout">
                                <i class="fa-solid fa-right-from-bracket"></i> Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="cart-page">

            <!-- LEFT -->
            <div class="cart-items">
                <h2>Your Cart</h2>
                <%
                    int grandTotal = 0;
                    double ttca = 0, ttc = 0, ttp = 0, ttf = 0;

                    if (cart != null && !cart.isEmpty()) {
                        for (Map<String, Object> it : cart) {
                            grandTotal += (int) it.get("tprice");
                            ttca += (double) it.get("cal");
                            ttc += (double) it.get("car");
                            ttp += (double) it.get("pro");
                            ttf += (double) it.get("fat");
                %>




                <div class="cart-item">
                    <img src="<%=request.getContextPath()%>/showfoodimg?id=<%= it.get("foodname")%>"
                         alt="Food Image">

                    <div>
                        <h4><%= it.get("foodname")%></h4>
                        <p class="qty">Quantity: <%= it.get("qty")%></p>
                        <p>Total: ₹<%= it.get("tprice")%></p>

                        <!-- ✅ REMOVE BUTTON (PER ITEM) -->
                        <a href="addtocart.jsp?remove=<%= it.get("foodname")%>"
                           class="remove">
                            cancel
                        </a>
                    </div>

                    <div class="nutrition-cards">
                        <div class="nutri-box calories">Calories<br>
                            <strong><%= it.get("cal")%></strong></div>
                        <div class="nutri-box carbs">Carbs<strong><%= it.get("car")%></strong></div>
                        <div class="nutri-box protein">Protein<strong><%= it.get("pro")%></strong></div>
                        <div class="nutri-box fats">Fat<strong><%= it.get("fat")%></strong></div>
                    </div>
                </div>


                <%
                    }
                } else {
                %>
                <p>Your cart is empty</p>
                <%
                    }
                %>
                <div class="add-more-box">
                    <!-- ➕ ADD MORE ITEMS -->
                    <a href="user_menu.jsp" class="add-more-btn">
                        Add more items
                    </a>
                </div>

            </div>


            <!-- RIGHT -->
            <div class="bill-box">
                <h3>Bill Details</h3>
                <%
                    if (cart != null && !cart.isEmpty()) {
                        for (Map<String, Object> it : cart) {

                %>


                <div class="bill-row">
                    <span class="foodname"><%= it.get("foodname")%></span>
                    <span class="tprice">₹<%= it.get("tprice")%></span>

                </div>

                <%
                        }
                    }
                %>
                <hr>
                <div class="bill-row">
                    <span>Total</span>
                    <span id="grandtotal">₹ <%=grandTotal%></span>
                </div>

                <div class="bill-row">
                    <span>Total Calories</span>
                    <span id="totalcal"><%=ttca%></span>
                </div>

                <div class="bill-row">
                    <span>Total Carbs</span>
                    <span id="totalcarb"><%=ttc%></span>
                </div>

                <div class="bill-row">
                    <span>Total Protein</span>
                    <span id="totalpro"><%=ttp%></span>
                </div>

                <div class="bill-row">
                    <span>Total Fat</span>
                    <span id="totalfat"><%=ttf%></span>
                </div>

                <button class="checkout-btn" onclick="proceed()">Checkout</button>

                <form action="addtocart.jsp" method="post">
                    <input type="hidden" name="action" value="clear">
                    <button class="remove-btn">❌ Remove All Items</button>
                </form>

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


        <!-- ===== JAVASCRIPT ===== -->
        <script>
            function changeQty(btn, change) {
                let item = btn.closest('.cart-item');
                let qtyEl = item.querySelector('.qty');
                let price = parseInt(item.dataset.price);

                let qty = parseInt(qtyEl.innerText);
                qty += change;

                if (qty < 1)
                    qty = 1;

                qtyEl.innerText = qty;
                item.querySelector('.item-total').innerText = "₹" + (qty * price);

                updateBill();
            }

            function updateBill() {
                let total = 0;
                document.querySelectorAll('.cart-item').forEach(item => {
                    let qty = parseInt(item.querySelector('.qty').innerText);
                    let price = parseInt(item.dataset.price);
                    total += qty * price;
                });

                document.getElementById("itemTotal").innerText = "₹" + total;
                document.getElementById("grandTotal").innerText = "₹" + (total + 60);
            }

            function toggleDropdown() {
                document.getElementById("userDropdown").classList.toggle("show");
            }

// close dropdown on outside click
            window.onclick = function (event) {
                if (!event.target.closest('.user-menu')) {
                    document.getElementById("userDropdown").classList.remove("show");
                }
            };

            function proceed() {
                let names = document.getElementsByClassName("foodname");
                let prices = document.getElementsByClassName("tprice");
                let qty = document.getElementsByClassName("qty");

                let cartItems = [];

                for (let i = 0; i < names.length; i++) {
                    cartItems.push({
                        name: names[i].innerText,
                        price: prices[i].innerText,
                        quantity: qty[i].innerText
                    });
                }

                let orderData = {
                    items: cartItems,
                    total: document.getElementById("grandtotal").innerText,
                    carbs: document.getElementById("totalcarb").innerText,
                    protein: document.getElementById("totalpro").innerText,
                    calories: document.getElementById("totalcal").innerText,
                    fat: document.getElementById("totalfat").innerText
                };

                // Save data in localStorage
                localStorage.setItem("orderData", JSON.stringify(orderData));

                // Go to next page
                window.location.href = "payment_proceed.jsp";
            }


        </script>
    </body>
</html>
