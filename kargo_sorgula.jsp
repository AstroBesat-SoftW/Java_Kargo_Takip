<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>
<%
    
    String dbname = "kargosistemi";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giriş Yap</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('gorsel/kargo.png') no-repeat center center fixed;
            background-size: cover;
        }

        /* ÜST MENÜ */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 15px 30px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 10;
        }

        .navbar h1 {
            color: #fff;
            margin: 0;
            font-size: 24px;
        }

        .navbar ul {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        .navbar ul li a {
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 14px;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        .navbar ul li a:hover {
            background-color: #ec1c24;
        }

        .form-container {
            width: 800px;
            margin: 120px auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .form-container img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 15px;
        }

        .form-container h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group button {
            background-color: #ec1c24;
            color: white;
            padding: 10px;
            width: 100%;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-group button:hover {
            background-color: #bf171c;
        }

        .form-container a {
            display: block;
            margin-top: 10px;
            color: #ec1c24;
            text-decoration: none;
            font-weight: bold;
        }

        .form-container a:hover {
            text-decoration: underline;
        }

        @media (max-width: 500px) {
            .form-container {
                width: 90%;
                margin-top: 150px;
            }
        }
        
       
        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.05);
        }
        
        
           table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2c3e50;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
    </style>
</head>
<body>

    <!-- Üst Menü -->
    <div class="navbar">
        <h1>Kargo Takip</h1>
        <ul>
            <li><a href="index.jsp">Giriş Yap</a></li>
            <li><a href="kargo_sorgula.jsp">Kargo Sorgulama</a></li>
        </ul>
    </div>

    <!-- Form Kutusu -->
    <div class="form-container">
        <!-- İçerik -->
<div class="main">
    <div class="card">
    <h2>📦 Kargo Takip</h2>
           <form method="post" style="margin-bottom: 20px;">
        <label for="barkod">Barkod / Takip Numarası Giriniz:</label><br>
        <input type="text" name="barkod" id="barkod" placeholder="örn. TRK123456" style="width: 60%; padding: 10px; margin-top: 8px; margin-bottom: 12px; border-radius: 6px; border: 1px solid #ccc;">
        <button type="submit" style="padding: 10px 15px; background-color: #2c3e50; color: white; border: none; border-radius: 6px;">Sorgula</button>
    </form>

    <%
        String barkod = request.getParameter("barkod");
        if (barkod != null && !barkod.trim().isEmpty()) {
            try {
                Connection conn = VeritabaniBaglanti.getConnection(dbname);
                String sql = "SELECT * FROM kargo WHERE takip_no = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, barkod);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
    %>
                <table>
                    <tr><th>Gönderici</th><td><%= rs.getString("gonderici_adsoyad") %></td></tr>
                    <tr><th>Gönderici Tel</th><td><%= rs.getString("gonderici_tel") %></td></tr>
                    <tr><th>Alıcı</th><td><%= rs.getString("alici_adsoyad") %></td></tr>
                    <tr><th>Alıcı Tel</th><td><%= rs.getString("alici_tel") %></td></tr>
                    <tr><th>Kargo Türü</th><td><%= rs.getString("kargo_turu") %></td></tr>
                    <tr><th>Ağırlık</th><td><%= rs.getDouble("agirlik") %> kg</td></tr>
                    <tr><th>Gönderim Tarihi</th><td><%= rs.getDate("gonderim_tarihi") %></td></tr>
                    <tr><th>Teslim Tarihi</th><td><%= rs.getDate("tahmini_teslim_tarihi") %></td></tr>
                    <tr><th>Adres</th><td><%= rs.getString("adres") %></td></tr>
                    <tr><th>Kargo Durumu</th><td><%= rs.getString("durum") %></td></tr>
                </table>
    <%
                } else {
    %>
                <p style="color: red;">❌ Girilen barkod ile eşleşen bir kargo bulunamadı.</p>
    <%
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
    %>
            <p style="color: red;">Hata: <%= e.getMessage() %></p>
    <%
            }
        }
    %>

</div>

<script>
    // Arama filtresi
    document.getElementById('arama').addEventListener('keyup', function () {
        let arama = this.value.toLowerCase();
        let satirlar = document.querySelectorAll("#kargoTablosu tbody tr");

        satirlar.forEach(function (satir) {
            let yazi = satir.innerText.toLowerCase();
            satir.style.display = yazi.includes(arama) ? '' : 'none';
        });
    });
</script>

</div>
    </div>

</body>
</html>
