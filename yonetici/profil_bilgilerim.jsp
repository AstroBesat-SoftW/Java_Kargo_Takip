<%-- 
    Document   : readme.md
    Created on : 20 Nisan 2025, 20:07:41
    Author     : Besat Çıngar
--%>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="VeritabaniBaglanti.VeritabaniBaglanti" %>
<%
    String kullanici = (String) session.getAttribute("yonetici");
    if (kullanici == null) {
        response.sendRedirect("../yonetici_giris.jsp");
        return;
    }

    String dbname = "kargosistemi";

    // Formdan güncelleme talebi geldiyse işle
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String isim = request.getParameter("isim");
        String iletisim = request.getParameter("iletisim");
        String tc = request.getParameter("tc");
        String dogum_tarihi = request.getParameter("dogum_tarihi");
        String adres = request.getParameter("adres");
        String cinsiyet = request.getParameter("cinsiyet");

        try {
            Connection conn = VeritabaniBaglanti.getConnection(dbname);
            String sql = "UPDATE yonetici SET isim=?, iletisim=?, tc=?, dogum_tarihi=?, adres=?, cinsiyet=? WHERE eposta=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, isim);
            stmt.setString(2, iletisim);
            stmt.setString(3, tc);
            stmt.setString(4, dogum_tarihi);
            stmt.setString(5, adres);
            stmt.setString(6, cinsiyet);
            stmt.setString(7, kullanici);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            request.setAttribute("basarili", true);
        } catch (Exception e) {
            request.setAttribute("hata", e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Profil Bilgilerim</title>
    <style>
        /* Stil kodları aynı */
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
            z-index: 999;
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
            transition: background 0.3s;
        }
        .sidebar a:hover {
            background-color: #1abc9c;
        }
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
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .bilgi, .form-grup {
            margin-bottom: 15px;
        }
        .etiket {
            font-weight: bold;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .buton {
            padding: 10px 20px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .buton:hover {
            background-color: #1abc9c;
        }
        .mesaj {
            padding: 10px;
            background-color: #dff0d8;
            color: #3c763d;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .mesaj.hata {
            background-color: #f2dede;
            color: #a94442;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="sol">📋 Profil Bilgilerim - <%= kullanici %></div>
    <div class="sag">
        <select onchange="secimYap(this.value)">
            <option disabled selected>Menü</option>
            <option value="profil_bilgilerim.jsp">Profilim</option>
            <option value="../index.jsp">Çıkış Yap</option>
        </select>
    </div>
</div>

<div class="sidebar">
    <a href="anasayfa.jsp">🏠 Ana Sayfa</a>
    <a href="calisan_ekle.jsp">➕ Ekip Çalışanı Ekle</a>
    <a href="kargo_takip.jsp">🔍 Kargo Takip</a>
    <a href="kargolar.jsp">📦 Kargolar</a>
    <a href="ekip.jsp">👤 Ekip Çalışanları</a>
    <a href="profil_bilgilerim.jsp" style="background: red">👤 Profilim</a>
</div>

<div class="main">
    <div class="card">
        <h2>👤 Profil Bilgileriniz</h2>

        <%
            if (request.getAttribute("basarili") != null) {
        %>
        <div class="mesaj">Bilgileriniz başarıyla güncellendi.</div>
        <%
            } else if (request.getAttribute("hata") != null) {
        %>
        <div class="mesaj hata">Hata oluştu: <%= request.getAttribute("hata") %></div>
        <%
            }

            Connection conn = VeritabaniBaglanti.getConnection(dbname);
            String sql = "SELECT * FROM yonetici WHERE eposta = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, kullanici);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
        %>

        <form method="post">
            <div class="form-grup">
                <label class="etiket">İsim:</label>
                <input type="text" name="isim" value="<%= rs.getString("isim") %>" required>
            </div>
            <div class="form-grup">
                <label class="etiket">İletişim:</label>
                <input type="text" name="iletisim" value="<%= rs.getString("iletisim") %>">
            </div>
            <div class="form-grup">
                <label class="etiket">T.C. No:</label>
                <input type="text" name="tc" value="<%= rs.getString("tc") %>">
            </div>
            <div class="form-grup">
                <label class="etiket">Doğum Tarihi:</label>
                <input type="date" name="dogum_tarihi" value="<%= rs.getString("dogum_tarihi") %>">
            </div>
            <div class="form-grup">
                <label class="etiket">Adres:</label>
                <textarea name="adres"><%= rs.getString("adres") %></textarea>
            </div>
            <div class="form-grup">
                <label class="etiket">Cinsiyet:</label>
                <select name="cinsiyet">
                    <option value="Erkek" <%= "Erkek".equals(rs.getString("cinsiyet")) ? "selected" : "" %>>Erkek</option>
                    <option value="Kadın" <%= "Kadın".equals(rs.getString("cinsiyet")) ? "selected" : "" %>>Kadın</option>
                </select>
            </div>
            <div style="text-align:center;">
                <button type="submit" class="buton">Bilgileri Güncelle</button>
            </div>
        </form>

        <%
            } else {
        %>
        <p>Bilgiler bulunamadı.</p>
        <%
            }
            rs.close();
            stmt.close();
            conn.close();
        %>
    </div>
</div>

<script>
    function secimYap(deger) {
        if (deger) window.location.href = deger;
    }
</script>

</body>
</html>
