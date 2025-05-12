<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giriş Yap</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: url('gorsel/kargo.png') no-repeat center center fixed;
            background-size: cover;
        }

        .form-container {
            width: 400px;
            margin: 80px auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
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
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #aaa;
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
        }

        .form-group button:hover {
            background-color: #bf171c;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <!-- Yuvarlak gif -->
        <img src="https://media1.tenor.com/m/G9osTS-lbSIAAAAd/aircargo-cargo-ship.gif" alt="Giriş Animasyonu">
        <h2>Giriş Yap</h2>
        <form action="giris_kontrol.jsp" method="post">
            <div class="form-group">
                <label for="email">E-Posta</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="sifre">Şifre</label>
                <input type="password" id="sifre" name="sifre" required>
            </div>
            <div class="form-group">
                <button type="submit">Giriş Yap</button>
            </div>
        </form>
        <a href="yonetici_giris.jsp">Yönetici Giriş </a>
    </div>
</body>
</html>
