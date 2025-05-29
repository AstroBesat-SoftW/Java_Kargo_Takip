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
    String kullanici = (String) session.getAttribute("musteri");
    if (kullanici == null) {
        response.sendRedirect("giris.jsp");
        return;
    }
    String dbname = "kargosistemi";
    int durum = 1;
    String telefon = "";
    // bu alt kısım kuryeler için harici fazladan kod yazmak yerine başta kontrol ekledim
    // eğer bu ise bazı kısımlar gözükmecek
    


             // birde subesini bulalım
           if (1 == 1){    
            Connection conn = VeritabaniBaglanti.getConnection(dbname);
        
    
        PreparedStatement pst = null;
    ResultSet rs = null;
    
   
        String subeSorgusu = "SELECT telefon FROM musteriler WHERE email = ?";
        pst = conn.prepareStatement(subeSorgusu);
        pst.setString(1, kullanici);
        rs = pst.executeQuery();

        if (rs.next()) {
            telefon = rs.getString("telefon");
        }
        
      
        rs.close();
        pst.close();
    }
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
   -
  
     
       <a href="kargolar_kurye.jsp" style="background: red">📦 Kargolar</a>
      
    <a href="profil_bilgilerim.jsp" >👤 Profilim</a>
</div>

<!-- İçerik -->
<div class="main">
    <div class="card">
    <h2>📦 Kayıtlı Kargolar</h2>
    <input type="text" id="arama" placeholder="🔍 Aramak için yazınız..." style="width: 100%; padding: 10px; margin-bottom: 15px; border-radius: 6px; border: 1px solid #ccc; font-size: 16px;">

   <table id="kargoTablosu">
    <thead>
    <tr>
       
        <th>Alıcı</th>
        <th>Takip No</th>
        <th>Adres</th>
        <th>Kargo Durumu</th>
        
        <th>Detay</th>
    </tr>
    </thead>
    <tbody>
    <%
        
        try {
            Connection conn = VeritabaniBaglanti.getConnection(dbname);
           
         String sql = "SELECT * FROM kargo WHERE alici_tel = ? OR gonderici_tel = ? ORDER BY id DESC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, telefon); // alici_tel
        stmt.setString(2, telefon); // gonderici_tel için de aynı telefon değeri kullanılıyor
        ResultSet rs = stmt.executeQuery();

            while(rs.next()) {
    %>
    <tr>
        
        <td><%= rs.getString("alici_adsoyad") %></td>
        <td><%= rs.getString("takip_no") %></td>
        
        <td><%= rs.getString("adres") %></td>
        
       <% if ("Teslim Edildi".equals(rs.getString("durum"))) { %>    
    <td style="background: green"><%= rs.getString("durum") %></td>
<% } else { %>        
    <td style="background: red"><%= rs.getString("durum") %></td>
<% } %>

       
        <td><a href="kargo_detay_kurye.jsp?id=<%= rs.getInt("id") %>" style="color: blue; text-decoration: underline;">Detay</a></td>
    </tr>
    <%
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
    %>
    <tr>
        <td colspan="6">Hata: <%= e.getMessage() %></td>
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
