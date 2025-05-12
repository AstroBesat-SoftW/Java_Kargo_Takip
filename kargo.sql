-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 12 May 2025, 16:46:09
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
  `durum` varchar(50) DEFAULT 'Hazırlanıyor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Tablo döküm verisi `kargo`
--

INSERT INTO `kargo` (`id`, `gonderici_adsoyad`, `gonderici_tel`, `alici_adsoyad`, `alici_tel`, `kargo_turu`, `agirlik`, `gonderim_tarihi`, `tahmini_teslim_tarihi`, `adres`, `takip_no`, `durum`) VALUES
(1, 'besat arasd', '05347018132', 'sdf', 'sdfsd', 'Ekspres', '23.00', '2025-05-12', '2025-05-12', 'sdfsdfsdfsdf', '12323', 'Hazırlanıyor'),
(3, 'fgdfg', 'dfgdfg', 'dfgdfg', 'dfsdf', 'Yurt DÄ±ÅÄ±', '12.00', '2002-12-12', '2025-05-14', 'dfsd', '1322', 'Hazırlanıyor');

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
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `kargo`
--
ALTER TABLE `kargo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
