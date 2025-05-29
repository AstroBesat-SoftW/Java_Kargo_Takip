-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 29 May 2025, 19:28:53
-- Sunucu sürümü: 10.4.27-MariaDB
-- PHP Sürümü: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `kargosistemi`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kargo`
--

CREATE TABLE `kargo` (
  `id` int(11) NOT NULL,
  `gonderici_adsoyad` varchar(100) DEFAULT NULL,
  `gonderici_tel` varchar(20) DEFAULT NULL,
  `alici_adsoyad` varchar(100) DEFAULT NULL,
  `alici_tel` varchar(20) DEFAULT NULL,
  `kargo_turu` varchar(50) DEFAULT NULL,
  `agirlik` decimal(5,2) DEFAULT NULL,
  `gonderim_tarihi` date DEFAULT NULL,
  `tahmini_teslim_tarihi` date DEFAULT NULL,
  `adres` text DEFAULT NULL,
  `takip_no` varchar(30) DEFAULT NULL,
  `durum` varchar(50) DEFAULT 'Hazırlanıyor',
  `en` decimal(10,2) DEFAULT NULL,
  `boy` decimal(10,2) DEFAULT NULL,
  `ucret` decimal(10,2) DEFAULT NULL,
  `sube` varchar(255) DEFAULT NULL,
  `teslim_eden` varchar(255) DEFAULT NULL,
  `musteri_not` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `kargo`
--

INSERT INTO `kargo` (`id`, `gonderici_adsoyad`, `gonderici_tel`, `alici_adsoyad`, `alici_tel`, `kargo_turu`, `agirlik`, `gonderim_tarihi`, `tahmini_teslim_tarihi`, `adres`, `takip_no`, `durum`, `en`, `boy`, `ucret`, `sube`, `teslim_eden`, `musteri_not`) VALUES
(1, 'besat arasd', '05347018132', 'sdf', 'sdfsd', 'Ekspres', '23.00', '2025-05-12', '2025-05-12', 'sdfsdfsdfsdf', '12323', 'Teslim Edilmek Uzere Yola Cikti', NULL, NULL, NULL, 'Corlu', 'Cansu Karasu', 'Komsuya birak'),
(3, 'fgdfg', 'dfgdfg', 'dfgdfg', 'dfsdf', 'Yurt DÄ±ÅÄ±', '12.00', '2002-12-12', '2025-05-14', 'dfsd', '1322', 'Hazırlanıyor', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'besat arasd', '05347018188', 'dsfsd', 'sdfsdf', 'Standart', '45.00', '2025-05-12', '2025-05-22', 'dfgdf', '3423423423345', 'Hazırlanıyor', '12.00', '10.00', '1.00', NULL, NULL, NULL),
(6, 'besat arasd', '05344018132', 'dsfsd', 'sdfsdf', 'Standart', '45.00', '2025-05-12', '2025-05-22', 'sd', '3423423423342', 'Hazırlanıyor', '12.00', '10.00', '1.00', NULL, NULL, NULL),
(7, 'besat arasd', '05355518132', 'dsfsd', 'sdfsdf', 'Standart', '45.00', '2025-05-12', '2025-05-22', 'ef', '34234234233422', 'Teslim Edildi', '12.00', '10.00', '1.00', 'Corlu', 'Cansu Karasu', NULL),
(8, 'deneme', '05347013422', 'besat arasd', '05347018188', 'Standart', '12.00', '2025-05-13', '2025-05-22', 'sdfsdf', '121323234', 'Teslim Edildi', '23.00', '23.00', '23.00', 'Corlu', 'Elif Aydin', NULL),
(9, 'Cansu Kanici', '05344018130', 'Ahmet', '05347018188', 'Standart', '10.00', '2025-05-13', '2025-05-17', 'Kyk Erkek Yurdu CORLU', '456412456', 'Teslim Edilmek Uzere Yola Cikti', '12.00', '12.00', '0.00', 'Corlu', 'Besat', 'Komsuya birak');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kullanici`
--

CREATE TABLE `kullanici` (
  `id` int(11) NOT NULL,
  `eposta` varchar(100) NOT NULL,
  `pin` varchar(100) NOT NULL,
  `isim` varchar(255) DEFAULT NULL,
  `iletisim` varchar(20) DEFAULT NULL,
  `tc` varchar(11) DEFAULT NULL,
  `dogum_tarihi` date DEFAULT NULL,
  `adres` text DEFAULT NULL,
  `cinsiyet` varchar(10) DEFAULT NULL,
  `mevki` varchar(100) DEFAULT NULL,
  `sube` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `kullanici`
--

INSERT INTO `kullanici` (`id`, `eposta`, `pin`, `isim`, `iletisim`, `tc`, `dogum_tarihi`, `adres`, `cinsiyet`, `mevki`, `sube`) VALUES
(1, 'besat@gmail.com', '1234', 'Besat', '05347018131', '324234234', '2025-05-05', 'çorlu', 'Erkek', 'Kurye', 'Corlu'),
(2, 'dilan@example.com', 'abcd', NULL, NULL, NULL, NULL, NULL, NULL, 'Çalışan', 'Corlu'),
(3, 'cansu@gmail.com', '697021', 'Cansu Karasu', '3423423432', '2454325345', '2025-05-12', 'ankara', 'KadÄ±n', 'Kurye', 'Corlu'),
(5, 'elif11@gmail.com', '341730', 'Elif Aydin', '3423423456211', '2454324511', '2025-05-12', 'jldsfnlsdf11', 'Erkek', 'Kurye', 'Corlu'),
(14, 'elif222@gmail.com', '254476', 'Elif Ay 222', '342342343222', '34352342322', '2025-05-12', 'Corlu Tekirdag22', 'Kadın', 'Kurye', 'Tekirdag');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `musteriler`
--

CREATE TABLE `musteriler` (
  `id` int(11) NOT NULL,
  `isim` varchar(100) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `sifre` varchar(100) DEFAULT NULL,
  `dogum_tarihi` date DEFAULT NULL,
  `adres` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `musteriler`
--

INSERT INTO `musteriler` (`id`, `isim`, `telefon`, `email`, `sifre`, `dogum_tarihi`, `adres`) VALUES
(1, 'deneme', '0534707872', 'cansdsdsu@gmail.com', '1234', '2025-04-29', 'asasasasasas'),
(2, NULL, NULL, NULL, NULL, NULL, NULL),
(3, NULL, NULL, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'deneme', '05347018188', 'a@gmail.com', '1234', '2025-04-29', 'dfdf');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `subeler`
--

CREATE TABLE `subeler` (
  `id` int(11) NOT NULL,
  `sube_ad` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `subeler`
--

INSERT INTO `subeler` (`id`, `sube_ad`) VALUES
(1, 'Corlu'),
(2, 'Tekirdag'),
(3, 'Malkara'),
(4, 'Edirne');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yonetici`
--

CREATE TABLE `yonetici` (
  `id` int(11) NOT NULL,
  `eposta` varchar(100) NOT NULL,
  `pin` varchar(10) NOT NULL,
  `isim` varchar(100) DEFAULT NULL,
  `iletisim` varchar(20) DEFAULT NULL,
  `tc` varchar(11) DEFAULT NULL,
  `dogum_tarihi` date DEFAULT NULL,
  `adres` text DEFAULT NULL,
  `cinsiyet` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `yonetici`
--

INSERT INTO `yonetici` (`id`, `eposta`, `pin`, `isim`, `iletisim`, `tc`, `dogum_tarihi`, `adres`, `cinsiyet`) VALUES
(1, 'besatt@gmail.com', '1234', 'Besat', '05347018131', '35345345', '2025-05-05', 'Tekirdag', 'Erkek');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `kargo`
--
ALTER TABLE `kargo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `takip_no` (`takip_no`);

--
-- Tablo için indeksler `kullanici`
--
ALTER TABLE `kullanici`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `eposta` (`eposta`);

--
-- Tablo için indeksler `musteriler`
--
ALTER TABLE `musteriler`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `subeler`
--
ALTER TABLE `subeler`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `yonetici`
--
ALTER TABLE `yonetici`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `eposta` (`eposta`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `kargo`
--
ALTER TABLE `kargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `kullanici`
--
ALTER TABLE `kullanici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Tablo için AUTO_INCREMENT değeri `musteriler`
--
ALTER TABLE `musteriler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `subeler`
--
ALTER TABLE `subeler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Tablo için AUTO_INCREMENT değeri `yonetici`
--
ALTER TABLE `yonetici`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
