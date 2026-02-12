<%-- 
    Document   : payment_proceed
    Created on : 28 Jan 2026, 10:12:00 am
    Author     : mahim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Checkout - DishDecode</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

        <style>
            *{
                margin:0;
                padding:0;
                box-sizing:border-box;
                font-family:'Poppins',sans-serif;
            }

            body{
                background:#f8f9fb;
                color:#333;
            }

            /* BACK LINK */
            .back-link{
                display:inline-block;
                margin:20px 40px 0;
                color:#37884c;
                font-weight:500;
                text-decoration:none;
                font-size:14px;
            }
            .back-link:hover{
                text-decoration:underline;
            }

            /* MAIN LAYOUT */
            .checkout-page{
                display:flex;
                gap:30px;
                padding:30px 40px 50px;
            }

            /* LEFT SIDE */
            .checkout-items{
                flex:2;
                background:#fff;
                padding:25px;
                border-radius:16px;
                box-shadow:0 8px 24px rgba(0,0,0,0.06);
            }

            .checkout-items h2{
                font-size:20px;
                margin-bottom:18px;
            }

            .checkout-item{
                display:flex;
                justify-content:space-between;
                padding:12px 0;
                border-bottom:1px solid #eee;
                font-size:15px;
            }

            /* NUTRITION */
            .nutrition{
                display:grid;
                grid-template-columns:repeat(2,1fr);
                gap:12px;
                margin-top:18px;
            }

            .nutri-box{
                background:#e8f5e9;
                border-radius:12px;
                padding:14px;
                text-align:center;
                font-size:13px;
                box-shadow:0 2px 8px rgba(0,0,0,0.05);
            }

            .nutri-box {
                display:block;
                color:#37884c;
                font-size:15px;
                margin-top:5px;
                font-weight: 700;
            }

            /* RIGHT SIDE BILL */
            .bill-box{
                flex:1;
                background:#fff;
                padding:25px;
                border-radius:16px;
                box-shadow:0 8px 24px rgba(0,0,0,0.06);
                height:fit-content;
                position:sticky;
                top:20px;
            }

            .bill-box h3{
                margin-bottom:15px;
                font-size:18px;
            }

            .bill-row{
                display:flex;
                justify-content:space-between;
                margin-bottom:12px;
                font-size:14px;
            }

            .total{
                font-weight:600;
                border-top:1px dashed #ccc;
                padding-top:12px;
                font-size:16px;
            }

            /* PAYMENT METHODS */
            .payment-methods{
                margin-top:20px;
            }

            .payment-methods h4{
                margin-bottom:10px;
                font-size:15px;
            }

            .payment-methods label{
                display:flex;
                align-items:center;
                gap:10px;
                padding:10px;
                border:1px solid #eee;
                border-radius:10px;
                margin-bottom:8px;
                cursor:pointer;
                transition:0.2s;
            }

            .payment-methods label:hover{
                border-color:#ff5a5f;
                background:#fff5f5;
            }

            .payment-methods input{
                accent-color:#ff5a5f;
            }

            /* PLACE ORDER BUTTON */
            .place-order-btn{
                margin-top:18px;
                width:100%;
                padding:14px;
                border:none;
                border-radius:12px;
                background:#2e7d32;
                color:white;
                font-size:16px;
                font-weight:600;
                cursor:pointer;
                transition:0.3s;
            }

            .place-order-btn:hover{
                transform:translateY(-2px);
                box-shadow:0 6px 18px rgba(255,90,95,0.3);
            }

            /* MOBILE */
            @media(max-width:900px){
                .checkout-page{
                    flex-direction:column;
                    padding:20px;
                }
            }

        </style>
    </head>
    <body>

        <!-- BACK TO CART LINK -->
        <a href="addtocart.jsp" class="back-link">← Back to Cart</a>

        <div class="checkout-page">

            <!-- LEFT SIDE -->
            <div class="checkout-items">
                <h2>Your Order</h2>

                <div id="orderItems"></div>


                <h2 style="margin-top:25px;">Nutrition Summary</h2>
                <div class="nutrition">
                    <div class="nutri-box" id="cal">Calories<strong>850 kcal</strong></div>
                    <div class="nutri-box" id="carbs">Carbs<strong>120 g</strong></div>
                    <div class="nutri-box" id="pro">Protein<strong>42 g</strong></div>
                    <div class="nutri-box" id="fat">Fat<strong>28 g</strong></div>
                </div>
            </div>

            <!-- RIGHT SIDE -->
            <div class="bill-box">
                <h3>Bill Details</h3>

                <div class="bill-row">
                    <span>Items Total</span>
                    <span id="tprice">₹500</span>
                </div>

                <div class="bill-row">
                    <span>Delivery Fee</span>
                    <span>₹0</span>
                </div>

                <div class="bill-row total">
                    <span>Grand Total</span>
                    <span id="gtotal">₹540</span>
                </div>

                <div class="payment-methods">
                    <h4>Select Payment Method</h4>

                    <label><input type="radio" name="pay"> UPI (GPay, PhonePe, Paytm)</label>
                    <label><input type="radio" name="pay"> Credit / Debit Card</label>
                    <label><input type="radio" name="pay"> Net Banking</label>
                    <label><input type="radio" name="pay"> Wallets</label>
                    <label><input type="radio" name="pay"> Cash on Delivery</label>
                </div>


                <button class="place-order-btn" id="placeOrderBtn">Place Order</button>
            </div>

        </div>

    </body>

    <script>

        let d = localStorage.getItem("orderData");

        if (d == null) {
            console.log("No order data found");
        } else {

            let data = JSON.parse(d);

            let itemsDiv = document.getElementById("orderItems");

            for (let i = 0; i < data.items.length; i++) {
                let item = data.items[i];

                itemsDiv.innerHTML +=
                        "<div class='checkout-item'>" +
                        "<span>" + item.name + "</span>" +
                        "<span>" + item.quantity + "</span>" +
                        "<span>" + item.price + "</span>" +
                        "</div>";
            }
            document.getElementById("cal").innerText = data.calories;
            document.getElementById("carbs").innerText = data.carbs;
            document.getElementById("pro").innerText = data.protein;
            document.getElementById("fat").innerText = data.fat;
            document.getElementById("tprice").innerText = data.total;
            document.getElementById("gtotal").innerText = data.total;
        }

        document.getElementById("placeOrderBtn").addEventListener("click", function () {

            // popup message
            alert("🎉 Order placed successfully!");

            // clear cart data (optional)
            localStorage.removeItem("orderData");

            // go to homepage
            window.location.href = "user_homepage.jsp"; // change if your home page name is different
        });

    </script>

</html>
