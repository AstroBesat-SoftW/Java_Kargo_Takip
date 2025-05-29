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
    String kullanici = (String) session.getAttribute("kullanici");
    if (kullanici == null) {
        response.sendRedirect("giris.jsp");
        return;
    }
    String dbname = "kargosistemi";
       
    PreparedStatement pst = null;
    ResultSet rs = null;
    String sube = "";
    String durumFiltre = request.getParameter("durumFiltre");

    
        Connection conn = VeritabaniBaglanti.getConnection(dbname);
        
        // 1. Kullanıcının şubesini bul
        String subeSorgusu = "SELECT sube FROM kullanici WHERE eposta = ?";
        pst = conn.prepareStatement(subeSorgusu);
        pst.setString(1, kullanici);
        rs = pst.executeQuery();

        if (rs.next()) {
            sube = rs.getString("sube");
        }

        rs.close();
        pst.close();

        // 2. Şubeye göre kargoları listele ve durum filtresi uygula
        String kargoSorgusu = "SELECT * FROM kargo WHERE sube = ?";
        if (durumFiltre != null && !durumFiltre.isEmpty()) {
            kargoSorgusu += " AND durum = ?";
        }
        pst = conn.prepareStatement(kargoSorgusu);
        pst.setString(1, sube);
        if (durumFiltre != null && !durumFiltre.isEmpty()) {
            pst.setString(2, durumFiltre);
        }
        rs = pst.executeQuery();
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
            font-size: 10px
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
    <a href="kargo_ekle.jsp">➕ Kargo Girişi</a>
    <a href="kargo_takip.jsp" style="background: red">🔍 Kargo Takip</a>
    <a href="kargolar.jsp">📦 Kargolar</a>
    <a href="profil_bilgilerim.jsp">👤 Profilim</a>
</div>

<!-- İçerik -->
<div class="main">
    <div class="card">
        <h2><%= sube %> Şubesine Ait Kargolar</h2>

        <!-- Durum Filtresi -->
        <form method="GET" action="">
            <select name="durumFiltre" onchange="this.form.submit()">
                <option value="">Tüm Durumlar</option>
                <option value="Teslim Edildi" <%= "Teslim Edildi".equals(durumFiltre) ? "selected" : "" %>>Teslim Edildi</option>
                <option value="Teslim Edilmek Uzere Yola Cikti" <%= "Dağıtımda".equals(durumFiltre) ? "selected" : "" %>>Dağıtımda</option>
                <option value="Subeye Vardi" <%= "Şubede".equals(durumFiltre) ? "selected" : "" %>>Şubede</option>
                <option value="Hazirlaniyor" <%= "Hazırlanıyor".equals(durumFiltre) ? "selected" : "" %>>Hazırlanıyor</option>
            </select>
        </form>

        <input type="text" id="arama" placeholder="🔍 Ara..." style="margin-bottom: 15px; padding: 8px; width: 100%; box-sizing: border-box;">

        <table id="kargoTablosu">
            <thead>
                <tr>
                    <th>Gönderici Ad Soyad</th>
                    <th>Gönderici Tel</th>
                    <th>Alıcı Ad Soyad</th>
                    <th>Alıcı Tel</th>
                    <th>Kargo Türü</th>
                    <th>Ağırlık (kg)</th>
                    <th>Gönderim Tarihi</th>
                    <th>Tahmini Teslim</th>
                    <th>Adres</th>
                    <th>Takip No</th>
                    <th>Durum</th>
                    <th>En (cm)</th>
                    <th>Boy (cm)</th>
                    <th>Ücret (₺)</th>
                    <th>Şube</th>
                    <th>Teslim Eden Kurye</th><!-- comment -->
                    <th>Kurye Seç</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("gonderici_adsoyad") %></td>
                    <td><%= rs.getString("gonderici_tel") %></td>
                    <td><%= rs.getString("alici_adsoyad") %></td>
                    <td><%= rs.getString("alici_tel") %></td>
                    <td><%= rs.getString("kargo_turu") %></td>
                    <td><%= rs.getDouble("agirlik") %></td>
                    <td><%= rs.getDate("gonderim_tarihi") %></td>
                    <td><%= rs.getDate("tahmini_teslim_tarihi") %></td>
                    <td><%= rs.getString("adres") %></td>
                    <td><%= rs.getString("takip_no") %></td>
                    <td><%= rs.getString("durum") %></td>
                    <td><%= rs.getDouble("en") %></td>
                    <td><%= rs.getDouble("boy") %></td>
                    <td><%= rs.getDouble("ucret") %></td>
                    <td><%= rs.getString("sube") %></td>
                     <td><%= rs.getString("teslim_eden") %></td>
                    <td><a href="kargo_teslim_kurye.jsp?id=<%= rs.getInt("id")%>&sube=<%= rs.getString("sube") %>" style="color: blue; text-decoration: underline;">Kurye Seç</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

    </div>
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

<script>
    function secimYap(deger) {
        if (deger) {
            window.location.href = deger;
        }
    }
</script>

</body>
</html>
