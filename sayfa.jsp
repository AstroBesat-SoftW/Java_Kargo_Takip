<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="vt.VeritabaniBaglanti" %>
<%
    String dbName = "vt";
    String baslik = "Hoşgeldiniz!";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giriş</title>
    <style>
        body {
            background-image: url('kargo.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            font-family: Arial, sans-serif;
            color: white;
        }

        .form-container {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 30px;
            max-width: 400px;
            margin: 100px auto;
            border-radius: 10px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
        }

        input[type="text"], input[type="password"], input[type="submit"] {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: none;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2><%= baslik %></h2>

        <form action="sonuc.jsp" method="post">
            <input type="text" name="tc" placeholder="TC Kimlik No" required>
            <input type="password" name="pin" placeholder="PIN" required>
            <input type="submit" value="Giriş Yap">
        </form>
    </div>

</body>
</html>
