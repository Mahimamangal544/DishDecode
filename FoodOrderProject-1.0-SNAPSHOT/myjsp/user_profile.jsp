<%-- 
    Document   : user_profile
    Created on : 28 Jan 2026, 9:31:19 am
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
        <meta charset="UTF-8">
        <title>User Profile</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f2f4f8;
                margin: 0;
                padding: 0;
            }

            .top-bar {
                padding: 15px 30px;
            }

            .back-btn {
                text-decoration: none;
                background: #4CAF50;
                color: white;
                padding: 8px 14px;
                border-radius: 6px;
                font-size: 14px;
                transition: 0.3s;
            }

            .back-btn:hover {
                background: #388e3c;
            }


            .container {
                width: 95%;
                max-width: 1100px;
                margin: 25px auto;
            }

            h2 {
                margin-bottom: 15px;
            }

            /* PROFILE */
            .profile-card {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 25px;
            }

            .profile-row {
                display: flex;
                justify-content: space-between;
                padding: 8px 0;
                border-bottom: 1px solid #eee;
            }

            .profile-row:last-child {
                border-bottom: none;
            }

            .label {
                font-weight: bold;
                color: #555;
            }

            .value {
                color: #222;
            }

            .edit-btn {
                margin-top: 45px;
                padding: 8px 15px;
                border: none;
                background: #4CAF50;
                color: white;
                border-radius: 4px;
                cursor: pointer;
            }

            /* ORDERS */
            .orders {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .order {
                border: 1px solid #eee;
                border-radius: 6px;
                margin-bottom: 20px;
                padding: 15px;
            }

            .order-header {
                font-weight: bold;
                margin-bottom: 8px;
                color: #333;
            }

            .restaurant {
                color: #777;
                font-size: 14px;
                margin-bottom: 10px;
            }

            .food-item {
                display: flex;
                gap: 15px;
                margin-bottom: 12px;
                padding-bottom: 10px;
                border-bottom: 1px dashed #ddd;
            }

            .food-item img {
                width: 90px;
                height: 90px;
                border-radius: 6px;
                object-fit: cover;
            }

            .food-details {
                flex: 1;
            }

            .food-name {
                font-weight: bold;
                margin-bottom: 4px;
            }

            .price {
                color: #e91e63;
                font-weight: bold;
                margin-bottom: 4px;
            }

            .nutrition {
                font-size: 13px;
                color: #555;
            }

            .total {
                text-align: right;
                font-weight: bold;
                margin-top: 10px;
            }
        </style>
    </head>

    <body>


        <%
            String email = (String) session.getAttribute("ownerEmail");
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/foodorder", "root", "root");
                String q = "select Customer_Name , Customer_Email , Customer_Phoneno , Customer_Address"
                        + " ,Customer_Password from "
                        + "customerdetails where Customer_Email = ?";
                pst = con.prepareStatement(q);
                pst.setString(1, email);
                rs = pst.executeQuery();
                if (rs.next()) {

        %>

        <div class="top-bar">
            <a href="user_homepage.jsp" class="back-btn">← Back to Home</a>
        </div>


        <div class="container">

            <!-- USER PROFILE -->
            <div class="profile-card">
                <h2>User Profile</h2>

                <div class="profile-row">
                    <div class="label">Full Name</div>
                    <div class="value"><%= rs.getString("Customer_Name")%></div>
                </div>
                <div class="profile-row">
                    <div class="label">Email</div>
                    <div class="value"><%= rs.getString("Customer_Email")%></div>
                </div>
                <div class="profile-row">
                    <div class="label">Phone</div>
                    <div class="value"><%= rs.getString("Customer_Phoneno")%></div>
                </div>
                <div class="profile-row">
                    <div class="label">Address</div>
                    <div class="value"><%= rs.getString("Customer_Address")%></div>
                </div>
                <div class="profile-row">
                    <div class="label">Password</div>
                    <div class="value"><%= rs.getString("Customer_Password")%></div>
                </div>

                <a href="edit_userprofile.jsp" class="edit-btn">Edit Profile</a>
               
            </div>

            <%
                }

            %>

            <!-- ORDER HISTORY -->
            <div class="orders">
                <h2>Order History</h2>

                <!-- ORDER 1 -->
                <div class="order">
                    <div class="order-header">Order #1023 — 12 Jan 2026</div>
                    <div class="restaurant">Restaurant: Green Bowl Cafe</div>

                    <div class="food-item">
                        <img src="https://source.unsplash.com/100x100/?paneer" alt="">
                        <div class="food-details">
                            <div class="food-name">Paneer Butter Masala</div>
                            <div class="price">₹250</div>
                            <div class="nutrition">
                                Calories: 320 kcal |
                                Carbs: 18g |
                                Protein: 12g |
                                Fat: 22g
                            </div>
                        </div>
                    </div>

                    <div class="food-item">
                        <img src="https://source.unsplash.com/100x100/?naan" alt="">
                        <div class="food-details">
                            <div class="food-name">Butter Naan</div>
                            <div class="price">₹40</div>
                            <div class="nutrition">
                                Calories: 110 kcal |
                                Carbs: 15g |
                                Protein: 3g |
                                Fat: 4g
                            </div>
                        </div>
                    </div>

                    <div class="total">Total Bill: ₹350</div>
                </div>


                <!-- ORDER 2 -->
                <div class="order">
                    <div class="order-header">Order #1011 — 5 Jan 2026</div>
                    <div class="restaurant">Restaurant: Spice Villa</div>

                    <div class="food-item">
                        <img src="https://source.unsplash.com/100x100/?biryani" alt="">
                        <div class="food-details">
                            <div class="food-name">Veg Biryani</div>
                            <div class="price">₹180</div>
                            <div class="nutrition">
                                Calories: 280 kcal |
                                Carbs: 40g |
                                Protein: 6g |
                                Fat: 10g
                            </div>
                        </div>
                    </div>

                    <div class="food-item">
                        <img src="https://source.unsplash.com/100x100/?raita" alt="">
                        <div class="food-details">
                            <div class="food-name">Raita</div>
                            <div class="price">₹40</div>
                            <div class="nutrition">
                                Calories: 90 kcal |
                                Carbs: 6g |
                                Protein: 4g |
                                Fat: 5g
                            </div>
                        </div>
                    </div>

                    <div class="total">Total Bill: ₹220</div>
                </div>

            </div>

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
