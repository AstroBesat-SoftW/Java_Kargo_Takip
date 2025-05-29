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
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    String kullanici = (String) session.getAttribute("kullanici");
    if (kullanici == null) {
        response.sendRedirect("giris.jsp");
        return;
    }

    String mesaj = "";
    String dbName = "kargosistemi";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String gonderici = request.getParameter("gonderici");
        String g_tel = request.getParameter("g_tel");
        String alici = request.getParameter("alici");
        String a_tel = request.getParameter("a_tel");
        String tur = request.getParameter("tur");
        String agirlik = request.getParameter("agirlik");
        String g_tarihi = request.getParameter("g_tarihi");
        String t_tarihi = request.getParameter("t_tarihi");
        String adres = request.getParameter("adres");
        String takip_no = request.getParameter("takip_no");
        String en = request.getParameter("en");
        String boy = request.getParameter("boy");
        String ucret = request.getParameter("ucret");
        String sube_id = request.getParameter("sube");

        try {
            String sql = "INSERT INTO kargo (gonderici_adsoyad, gonderici_tel, alici_adsoyad, alici_tel, kargo_turu, agirlik, gonderim_tarihi, tahmini_teslim_tarihi, adres, takip_no, en, boy, ucret, sube) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            Connection conn = VeritabaniBaglanti.getConnection(dbName);
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, gonderici);
            stmt.setString(2, g_tel);
            stmt.setString(3, alici);
            stmt.setString(4, a_tel);
            stmt.setString(5, tur);
            stmt.setDouble(6, Double.parseDouble(agirlik));
            stmt.setDate(7, Date.valueOf(g_tarihi));
            stmt.setDate(8, Date.valueOf(t_tarihi));
            stmt.setString(9, adres);
            stmt.setString(10, takip_no);
            stmt.setDouble(11, Double.parseDouble(en));
            stmt.setDouble(12, Double.parseDouble(boy));
            stmt.setString(13, ucret); // Ücret string istendiği için
            stmt.setString(14, sube_id);

            int sonuc = stmt.executeUpdate();
            if (sonuc > 0) {
                mesaj = "✅ Kargo başarıyla eklendi.";
            } else {
                mesaj = "❌ Kayıt başarısız.";
            }

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
    <title>Kargo Ekle</title>

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

        .form-container {
            max-width: 800px;
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
    <a href="kargo_ekle.jsp" style="background: red">➕ Kargo Girişi</a>
    <a href="kargo_takip.jsp">🔍 Kargo Takip</a>
    <a href="kargolar.jsp" >📦 Kargolar</a>
    <a href="profil_bilgilerim.jsp">👤 Profilim</a>
</div>

<!-- İçerik -->
<div class="main">
    <div class="card">
        <div class="form-container">
            <h2>📦 Kargo Ekleme Formu</h2>
            <% if (!mesaj.equals("")) { %>
                <div class="mesaj"><%= mesaj %></div>
            <% } %>
            <form method="post">
                <label>Gönderici Ad Soyad:</label>
                <input type="text" name="gonderici" required>

                <label>Gönderici Telefon:</label>
                <input type="text" name="g_tel" required>

                <label>Alıcı Ad Soyad:</label>
                <input type="text" name="alici" required>

                <label>Alıcı Telefon:</label>
                <input type="text" name="a_tel" required>

                <label>Kargo Türü:</label>
                <select name="tur">
                    <option value="Standart">Standart</option>
                    <option value="Ekspres">Ekspres</option>
                    <option value="Yurt Dışı">Yurt Dışı</option>
                </select>

                <label>Kg cinsinden ağırlık:</label>
                <input type="number" step="0.01" name="agirlik" required>

                <label>Gönderim Tarihi:</label>
                <input type="date" name="g_tarihi" required>

                <label>Tahmini Teslim Tarihi:</label>
                <input type="date" name="t_tarihi" required>

                <label>Adres:</label>
                <textarea name="adres" rows="3" required></textarea>

                <label>Takip Numarası:</label>
                <input type="text" name="takip_no" required>

                <label>Kargo Eni (cm):</label>
                <input type="number" step="0.01" name="en" required>

                <label>Kargo Boyu (cm):</label>
                <input type="number" step="0.01" name="boy" required>

                <label>Kargo Ücreti (₺):</label>
                <input type="text" name="ucret" required>

                <label>Varış Şubesi:</label>
              <select name="sube" required>
    <% for(String sube : subeListesi) { %>
        <option value="<%= sube %>"><%= sube %></option>
    <% } %>
    <option value="Belirtmek istemiyorum">-</option>
</select>


                <input type="submit" value="Kargo Kaydet">
            </form>
        </div>
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
