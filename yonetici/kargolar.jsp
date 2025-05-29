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
            font-size: 10px;
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
    <a href="kargo_takip.jsp" >🔍 Kargo Takip</a>
    <a href="kargolar.jsp" style="background: red">📦 Kargolar</a>
     <a href="ekip.jsp">👤 Ekip Çalışanları</a>
    <a href="profil_bilgilerim.jsp">👤 Profilim</a>
</div>

<!-- İçerik -->
<div class="main">
    <div class="card">
    <h2>📦 Kayıtlı Kargolar</h2>
    <input type="text" id="arama" placeholder="🔍 Aramak için yazınız..." style="width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 6px; border: 1px solid #ccc; font-size: 16px;">

    <table id="kargoTablosu">
        <thead>
        <tr>
            <th>📷</th>
            <th>ID</th>
            <th>Gönderici</th>
            <th>G. Tel</th>
            <th>Alıcı</th>
            <th>A. Tel</th>
            <th>Tür</th>
            <th>Ağırlık</th>
            <th>G. Tarihi</th>
            <th>Teslim Tarihi</th>
            <th>Adres</th>
            <th>Takip No</th>
            <th>Kargo Durumu</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                Connection conn = VeritabaniBaglanti.getConnection(dbname);
                String sql = "SELECT * FROM kargo ORDER BY id DESC";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                while(rs.next()) {
        %>
        <tr>
            <td><img src="../gorsel/urun.png" alt="Kargo" style="width:32px;height:32px;"></td>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("gonderici_adsoyad") %></td>
            <td><%= rs.getString("gonderici_tel") %></td>
            <td><%= rs.getString("alici_adsoyad") %></td>
            <td><%= rs.getString("alici_tel") %></td>
            <td><%= rs.getString("kargo_turu") %></td>
            <td><%= rs.getDouble("agirlik") %> kg</td>
            <td><%= rs.getDate("gonderim_tarihi") %></td>
            <td><%= rs.getDate("tahmini_teslim_tarihi") %></td>
            <td><%= rs.getString("adres") %></td>
            <td><%= rs.getString("takip_no") %></td>
            <td style="background: red"><%= rs.getString("durum") %></td>
        </tr>
        <%
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="12">Hata: <%= e.getMessage() %></td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
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
