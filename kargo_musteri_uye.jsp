<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>

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
            width: 600px;
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
  .form-group {
            margin-bottom: 15px;
        }
        .form-group label { font-weight: bold; }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #ec1c24;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
        }
        @media (max-width: 500px) {
            .form-container {
                width: 90%;
                margin-top: 150px;
            }
        }
    </style>
</head>
<body>

    <!-- Üst Menü -->
    <div class="navbar">
        <h1>Kargo Takip</h1>
        <ul>
            <li><a href="index.jsp">Giriş Yap</a></li>
            <li><a href="kargo_musteri_giris.jsp">Müşteri Giriş</a></li>
            <li><a href="kargo_sorgula.jsp">Kargo Sorgulama</a></li>
        </ul>
    </div>

    <!-- Form Kutusu -->
    <div class="form-container">
        <img src="https://media1.tenor.com/m/G9osTS-lbSIAAAAd/aircargo-cargo-ship.gif" alt="Giriş Animasyonu">
        <h2>Üye Ol</h2>
       <form action="" method="post">
        <div class="form-group">
            <label for="isim">İsim</label>
            <input type="text" id="isim" name="isim" required>
        </div>
        <div class="form-group">
            <label for="telefon">Telefon</label>
            <input type="text" id="telefon" name="telefon" required>
        </div>
        <div class="form-group">
            <label for="email">E-Posta</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="sifre">Şifre</label>
            <input type="password" id="sifre" name="sifre" required>
        </div>
        <div class="form-group">
            <label for="dogum_tarihi">Doğum Tarihi</label>
            <input type="date" id="dogum_tarihi" name="dogum_tarihi" required>
        </div>
        <div class="form-group">
            <label for="adres">Adres</label>
            <textarea id="adres" name="adres" rows="3" required></textarea>
        </div>
        <button type="submit">Kayıt Ol</button>
    </form>
        <a href="kargo_musteri_giris.jsp">Müşteri Giriş Yap</a> 
    </div>

</body>
</html>

<% if ("POST".equalsIgnoreCase(request.getMethod())) {
    request.setCharacterEncoding("UTF-8");

    String isim = request.getParameter("isim");
    String telefon = request.getParameter("telefon");
    String email = request.getParameter("email");
    String sifre = request.getParameter("sifre");
    String dogumTarihi = request.getParameter("dogum_tarihi");
    String adres = request.getParameter("adres");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
         conn = VeritabaniBaglanti.getConnection("kargosistemi");
        String sql = "INSERT INTO musteriler (isim, telefon, email, sifre, dogum_tarihi, adres) VALUES (?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, isim);
        stmt.setString(2, telefon);
        stmt.setString(3, email);
        stmt.setString(4, sifre);
        stmt.setString(5, dogumTarihi);
        stmt.setString(6, adres);

        int sonuc = stmt.executeUpdate();

        if (sonuc > 0) {
%>
            <script>
                alert("Kayıt başarıyla oluşturuldu!");
                window.location.href = "kargo_musteri_giris.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("Kayıt sırasında bir hata oluştu.");
                window.history.back();
            </script>
<%
        }
    } catch (Exception e) {
        out.println("Hata: " + e.getMessage());
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception ex) {}
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
 }

%>
