<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String kullanici = (String) session.getAttribute("yonetici");
    if (kullanici == null) {
        response.sendRedirect("../yonetici_giris.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Kargo Paneli - Ana Sayfa</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }

        /* Üst Menü */
        .navbar {
            background-color: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 999;
        }

        .navbar .sol {
            font-size: 18px;
        }

        .navbar .sag select {
            padding: 5px;
            font-size: 14px;
            border-radius: 5px;
        }

        /* Yan Menü */
        .sidebar {
            width: 200px;
            height: 100vh;
            background-color: #34495e;
            position: fixed;
            top: 60px;
            left: 0;
            padding-top: 20px;
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background-color: #1abc9c;
        }

        /* İçerik Alanı */
        .main {
            margin-left: 200px;
            margin-top: 80px;
            padding: 20px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>

<!-- Üst Menü -->
<div class="navbar">
    <div class="sol">📦 Kargo Sistemi - Hoş Geldin <%= kullanici %></div>
    <div class="sag">
        <select onchange="secimYap(this.value)">
            <option disabled selected>Menü</option>
            <option value="profil_bilgilerim.jsp">Profilim</option>
            <option value="../index.jsp">Çıkış Yap</option>
        </select>
    </div>
</div>

<!-- Yan Menü -->
<div class="sidebar">
      <a href="anasayfa.jsp">🏠 Ana Sayfa</a>
    <a href="calisan_ekle.jsp">➕ Ekip Çalışanı Ekle</a>
    <a href="kargo_takip.jsp">🔍 Kargo Takip</a>
    <a href="kargolar.jsp">📦 Kargolar</a>
     <a href="ekip.jsp">👤 Ekip Çalışanları</a>
    <a href="profil_bilgilerim.jsp">👤 Profilim</a>
</div>

<!-- İçerik -->
<div class="main">
    <div class="card">
        <h2>📋 Kargo Yönetici Panali</h2>
        <p>Buradan yönetici olarak ekip çalışanı ekleyebilir, düzenleyebilir ve kargo durumunu takip edebilirsiniz.</p>
    </div>
</div>

<script>
    function secimYap(deger) {
        if (deger) {
            window.location.href = deger;
        }
    }
</script>

</body>
</html>
