<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>


<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>
<%
    String kullanici = (String) session.getAttribute("yonetici");
    if (kullanici == null) {
        response.sendRedirect("../yonetici_giris.jsp");
        return;
    }

    String mesaj = "";
    String dbName = "kargosistemi";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String eposta = request.getParameter("eposta");
        String pin = request.getParameter("pin");
        String isim = request.getParameter("isim");
        String iletisim = request.getParameter("iletisim");
        String tc = request.getParameter("tc");
        String dogumTarihi = request.getParameter("dogum_tarihi");
        String adres = request.getParameter("adres");
        String cinsiyet = request.getParameter("cinsiyet");
        String mevki = request.getParameter("mevki");
       String sube = request.getParameter("sube");
        try {
            Connection conn = VeritabaniBaglanti.getConnection(dbName);
            String sql = "INSERT INTO kullanici (eposta, pin, isim, iletisim, tc, dogum_tarihi, adres, cinsiyet, mevki, sube) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, eposta);
            stmt.setString(2, pin);
            stmt.setString(3, isim);
            stmt.setString(4, iletisim);
            stmt.setString(5, tc);
            stmt.setDate(6, Date.valueOf(dogumTarihi));
            stmt.setString(7, adres);
            stmt.setString(8, cinsiyet);
            stmt.setString(9, mevki);
            stmt.setString(10, sube);

            int sonuc = stmt.executeUpdate();
            mesaj = (sonuc > 0) ? "✅ Ekip çalışanı başarıyla eklendi." : "❌ Kayıt başarısız.";

            stmt.close();
            conn.close();
        } catch (Exception e) {
            mesaj = "⚠️ Hata: " + e.getMessage();
        }
    }
%>

<!-- bu alt şube seçimi için -->

<%
    // Şubeleri listelemek için
    Connection connSube = null;
    PreparedStatement stmtSube = null;
    ResultSet rsSube = null;
    List<String> subeListesi = new ArrayList<>();

    try {
        connSube = VeritabaniBaglanti.getConnection(dbName);
        String sqlSube = "SELECT sube_ad FROM subeler";
        stmtSube = connSube.prepareStatement(sqlSube);
        rsSube = stmtSube.executeQuery();

        while (rsSube.next()) {
            subeListesi.add(rsSube.getString("sube_ad"));
        }

    } catch (Exception e) {
        out.println("⚠️ Şube verileri çekilemedi: " + e.getMessage());
    } finally {
        if (rsSube != null) rsSube.close();
        if (stmtSube != null) stmtSube.close();
        if (connSube != null) connSube.close();
    }
%>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Ekip Çalışanı Ekle</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }
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
        }
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
        }
        .main {
            margin-left: 200px;
            margin-top: 80px;
            padding: 20px;
        }
        .form-container {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            background-color: #27ae60;
            color: white;
            border: none;
            cursor: pointer;
        }
        .mesaj {
            color: green;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>👤 Ekip Çalışanı Ekle - Hoş Geldin <%= kullanici %></div>
    <div>
        <select onchange="secimYap(this.value)">
            <option disabled selected>Menü</option>
            <option value="profil_bilgilerim.jsp">Profilim</option>
            <option value="../index.jsp">Çıkış Yap</option>
        </select>
    </div>
</div>

<div class="sidebar">
    <a href="anasayfa.jsp">🏠 Ana Sayfa</a>
    <a href="calisan_ekle.jsp" style="background: red">➕ Ekip Çalışanı Ekle</a>
    <a href="kargo_takip.jsp">🔍 Kargo Takip</a>
    <a href="kargolar.jsp">📦 Kargolar</a>
    <a href="ekip.jsp">👤 Ekip Çalışanları</a>
    <a href="profil_bilgilerim.jsp">👤 Profilim</a>
</div>

<div class="main">
    <div class="form-container">
        <h2>➕ Yeni Ekip Çalışanı Ekle</h2>
        <% if (!mesaj.equals("")) { %>
            <div class="mesaj"><%= mesaj %></div>
        <% } %>
        <form method="post">
            <label>İsim:</label>
            <input type="text" name="isim" required>
            
             <label>TC Kimlik No:</label>
            <input type="text" name="tc" required maxlength="11">

            <label>E-posta:</label>
            <input type="email" name="eposta" required>

             <label>PIN (şifre):</label>
             <input type="text" name="pin" id="pinInput" required readonly>

            

            <label>İletişim:</label>
            <input type="text" name="iletisim" required>

            
            <label>Doğum Tarihi:</label>
            <input type="date" name="dogum_tarihi" required>

            <label>Adres:</label>
            <textarea name="adres" rows="3" required></textarea>
        
            <label>Cinsiyet:</label>
            <select name="cinsiyet" required>
                <option value="Erkek">Erkek</option>
                <option value="Kadin">Kadın</option>
                <option value="Belirtmek istemiyorum">Belirtmek istemiyorum</option>
            </select>
             <label>Mevki(Çalışma Yeri):</label>
             <select name="mevki" required>
                <option value="Kurye">Kurye</option>
                <option value="Ofis Calisani">Ofis Çalışanı</option>
                <option value="Belirtmek istemiyorum">-</option>
            </select>
            
             <!--  <select name="sube" required>
                <option value="Ankara">Ankara</option>
                <option value="Malkara">Malkara</option>
                <option value="Belirtmek istemiyorum">-</option>
            </select> -->
             
             <label>Şube:</label>
<select name="sube" required>
    <% for(String sube : subeListesi) { %>
        <option value="<%= sube %>"><%= sube %></option>
    <% } %>
    <option value="Belirtmek istemiyorum">-</option>
</select>


            <input type="submit" value="Ekip Çalışanını Kaydet">
        </form>
    </div>
</div>

<script>
    function secimYap(deger) {
        if (deger) window.location.href = deger;
    }


 
    // Sayfa yüklendikten sonra 2 saniye bekleyip PIN üret
    window.addEventListener('load', function () {
        setTimeout(function () {
            let pin = '';
            for (let i = 0; i < 6; i++) {
                pin += Math.floor(Math.random() * 10); // 0-9 arası rakam
            }
            document.getElementById('pinInput').value = pin;
        }, 2000); // 2000 ms = 2 saniye
    });


</script>


</body>
</html>
