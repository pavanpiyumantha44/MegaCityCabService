<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stripe Payment</title>
    <script src="https://js.stripe.com/v3/"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        #card-element { border: 1px solid #ccc; padding: 10px; }
    </style>
</head>
<body>
    <h2>Stripe Payment Demo</h2>

    <!-- Payment Form -->
    <form id="payment-form">
        <div id="card-element"></div>
        <button type="submit">Pay $10</button>
    </form>

    <p id="payment-result"></p>

    <script>
        var stripe = Stripe("pk_test_51QycPKDNHBnF9Ofb7UKS2Qvzf9mGuRHEUtcPcSE7mAmvkJ7XbJw6Yjhcvm4AG1b9oFrdHee3dub6Ge0303BhbdbD006HdiGiFt");
        var elements = stripe.elements();
        var card = elements.create("card");
        card.mount("#card-element");

        $("#payment-form").submit(function(event) {
            event.preventDefault();
            stripe.createToken(card).then(function(result) {
                if (result.error) {
                    $("#payment-result").text(result.error.message);
                } else {
                    $.post("charge", { token: result.token.id }, function(response) {
                        $("#payment-result").text(response);
                    });
                }
            });
        });
    </script>
</body>
</html>
