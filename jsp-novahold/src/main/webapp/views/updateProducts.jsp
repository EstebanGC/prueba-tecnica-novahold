<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL, java.net.HttpURLConnection, java.io.OutputStream" %>
<html>
<head>
    <title>Editar un producto</title>
    <link rel="stylesheet" type="text/css" href="../css/styles.css">
</head>
<body style="background: linear-gradient(to right, #003366, #66ccff); color: #333; font-family: Arial, sans-serif; margin: 0; padding: 20px;">
    <h1>Update Product</h1>

    <form method="post" action="updateProduct.jsp">
        <label for="productId">Id del producto:</label>
        <input type="text" id="productId" name="productId" required><br><br>

        <label for="name">Nombre:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="available">Disponible (true/false):</label>
        <input type="text" id="available" name="available" required><br><br>

        <label for="minUnits">Unidades minimas:</label>
        <input type="number" id="minUnits" name="minUnits" required><br><br>

        <label for="maxUnits">Unidades maximas:</label>
        <input type="number" id="maxUnits" name="maxUnits" required><br><br>

        <button type="submit">Editar producto</button>
    </form>

    <%

        if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                String productId = request.getParameter("productId");
                String name = request.getParameter("name");
                String available = request.getParameter("available");
                String minUnits = request.getParameter("minUnits");
                String maxUnits = request.getParameter("maxUnits");


                String jsonInputString = "{"
                        + "\"productId\":" + productId + ","
                        + "\"name\":\"" + name + "\","
                        + "\"available\":" + available + ","
                        + "\"minUnits\":" + minUnits + ","
                        + "\"maxUnits\":" + maxUnits
                        + "}";


                URL url = new URL("http://localhost:8080/update/product");
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                con.setRequestMethod("PUT");
                con.setRequestProperty("Content-Type", "application/json; utf-8");
                con.setRequestProperty("Accept", "application/json");
                con.setDoOutput(true);

                try (OutputStream os = con.getOutputStream()) {
                    byte[] input = jsonInputString.getBytes("utf-8");
                    os.write(input, 0, input.length);
                }

                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
                StringBuilder apiResponse = new StringBuilder();
                String responseLine = null;
                while ((responseLine = br.readLine()) != null) {
                    apiResponse.append(responseLine.trim());
                }

                out.println("<h3>Product Updated Successfully!</h3>");
                out.println("<pre>" + apiResponse.toString() + "</pre>");

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h3>Error updating product: " + e.getMessage() + "</h3>");
            }
        }
    %>
</body>
</html>
