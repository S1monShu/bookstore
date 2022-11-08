-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 08 2022 г., 12:10
-- Версия сервера: 8.0.24
-- Версия PHP: 8.0.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bookstore`
--

-- --------------------------------------------------------

--
-- Структура таблицы `author`
--

CREATE TABLE `author` (
  `id_author` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `author`
--

INSERT INTO `author` (`id_author`, `name`) VALUES
(1, 'Ф. Герберт'),
(2, 'Дж. К. Роулинг'),
(3, 'Г. Ф. Лавкрафт'),
(4, 'Т. Кубо'),
(5, ' Jump Comics'),
(6, 'С. Кинг'),
(7, 'Джон. Р. Р. Толкин'),
(8, 'А. Азимов'),
(9, 'Х. Аракава'),
(10, 'А. К. Дойл'),
(11, 'М. Булгаков'),
(12, 'А. Кристи');

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` double NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`id`, `name`, `image`, `rate`, `date`) VALUES
(1, 'Дюна', '', 4.4, '1965-08-01'),
(2, 'Гарри Поттер И Филосовский Камень', '', 4.7, '1997-06-26'),
(6, 'Ужас Данвича', '', 4.1, '1929-04-12'),
(8, 'Блич. Том 57', '', 4.2, '2012-12-04'),
(12, 'ОНО', '', 4.8, '1986-09-15'),
(13, 'Сияние', '', 4.3, '1977-01-28'),
(15, 'Властелин Колец', '', 4.9, '1954-07-29'),
(16, 'Сами Боги', '', 4.1, '1972-11-16'),
(17, 'Стальной Алхимик. Книга 17', '', 4.7, '2010-08-12'),
(19, 'Приключения Шерлока Холмса', '', 4.4, '1892-10-14'),
(20, 'Мастер и Маргарита', '', 4.7, '1967-01-17'),
(21, 'Убийство в \"Восточном Экспрессе\"', '', 4.8, '1934-01-01');

-- --------------------------------------------------------

--
-- Структура таблицы `books_author`
--

CREATE TABLE `books_author` (
  `id` int NOT NULL,
  `id_book` int NOT NULL,
  `id_author` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books_author`
--

INSERT INTO `books_author` (`id`, `id_book`, `id_author`) VALUES
(1, 1, 1),
(2, 20, 11),
(3, 21, 12),
(4, 12, 6),
(5, 13, 6),
(7, 8, 4),
(8, 8, 5),
(11, 2, 2),
(12, 19, 10),
(13, 15, 7),
(14, 6, 3),
(16, 17, 9),
(19, 16, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `books_genres`
--

CREATE TABLE `books_genres` (
  `id` int NOT NULL,
  `id_book` int NOT NULL,
  `id_genre` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books_genres`
--

INSERT INTO `books_genres` (`id`, `id_book`, `id_genre`) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 6, 6),
(4, 6, 5),
(5, 8, 4),
(6, 8, 3),
(7, 12, 5),
(8, 13, 6),
(9, 13, 5),
(10, 15, 1),
(11, 16, 2),
(12, 17, 4),
(13, 17, 3),
(14, 19, 7),
(15, 20, 6),
(16, 21, 7);

-- --------------------------------------------------------

--
-- Структура таблицы `genres`
--

CREATE TABLE `genres` (
  `id_genres` int NOT NULL,
  `genre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `genres`
--

INSERT INTO `genres` (`id_genres`, `genre`) VALUES
(1, 'Фэнтэзи'),
(2, 'Научная фантастика'),
(3, 'Манга'),
(4, 'Боевик'),
(5, 'Триллер/Ужасы'),
(6, 'Мистика'),
(7, 'Детектив');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id_author`);

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `books_author`
--
ALTER TABLE `books_author`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_author` (`id_author`),
  ADD KEY `id_book` (`id_book`);

--
-- Индексы таблицы `books_genres`
--
ALTER TABLE `books_genres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_book` (`id_book`),
  ADD KEY `id_genre` (`id_genre`);

--
-- Индексы таблицы `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id_genres`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `author`
--
ALTER TABLE `author`
  MODIFY `id_author` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `books`
--
ALTER TABLE `books`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `books_author`
--
ALTER TABLE `books_author`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT для таблицы `books_genres`
--
ALTER TABLE `books_genres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `genres`
--
ALTER TABLE `genres`
  MODIFY `id_genres` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `books_author`
--
ALTER TABLE `books_author`
  ADD CONSTRAINT `books_author_ibfk_1` FOREIGN KEY (`id_author`) REFERENCES `author` (`id_author`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `books_author_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `books` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `books_genres`
--
ALTER TABLE `books_genres`
  ADD CONSTRAINT `books_genres_ibfk_1` FOREIGN KEY (`id_book`) REFERENCES `books` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `books_genres_ibfk_2` FOREIGN KEY (`id_genre`) REFERENCES `genres` (`id_genres`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
