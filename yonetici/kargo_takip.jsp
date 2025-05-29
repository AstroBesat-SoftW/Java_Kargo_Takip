<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>
<%
    String kullanici = (String) session.getAttribute("yonetici");
    if (kullanici == null) {
        response.sendRedirect("giris.jsp");
        return;
    }
    String dbname = "kargosistemi";
%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
      <title>Kargo Listesi</title>
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
    <a href="calisan_ekle.jsp" >➕ Ekip Çalışanı Ekle</a>
    <a href="kargo_takip.jsp" style="background: red">🔍 Kargo Takip</a>
    <a href="kargolar.jsp">📦 Kargolar</a>
     <a href="ekip.jsp">👤 Ekip Çalışanları</a>
    <a href="profil_bilgilerim.jsp">👤 Profilim</a>
</div>

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

<script>
    function secimYap(deger) {
        if (deger) {
            window.location.href = deger;
        }
    }
</script>

</body>
</html>
