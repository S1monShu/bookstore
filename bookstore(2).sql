-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 15 2022 г., 19:17
-- Версия сервера: 8.0.24
-- Версия PHP: 7.1.33

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
  `date` date NOT NULL,
  `discription` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`id`, `name`, `image`, `rate`, `date`, `discription`) VALUES
(2, 'Гарри Поттер и Филосовский Камень', 'uploads/6373af37ca7d2.png', 4.6, '1997-06-26', 'Книга, покорившая мир, эталон литературы для читателей всех возрастов, синоним успеха. Книга, сделавшая Дж.К. Роулинг самым читаемым писателем современности. Книга, ставшая культовой уже для нескольких поколений. «Гарри Поттер и орден Феникса» – история продолжается.'),
(6, 'Ужас Данвича', 'uploads/35428.png', 4.1, '1929-04-12', 'Второго февраля 1913 года у Лавинии Уэйтли родился сын Уилбур. Странный мальчик, который рос не по дням, а по часам, внушал страх жителям Данвича. Его деда считали колдуном, а сам он пропадал в библиотеке Мискатоникского университета, где выискивал в черных книгах сведения о магических формулах и заклинаниях. Однако все это — только пролог к ужасу Данвича. Одна из самых страшных повестей Г. Ф. Лавкрафта — истинный шедевр хоррора. Воображаемые картины классика оживают на страницах этой книги благодаря потрясающим иллюстрациям Сантьяго Карузо.'),
(8, 'Блич. Том 57', 'uploads/0ba2d5193ccd94cae5613f9163a8b20f.png', 4.2, '2012-12-04', 'С Ичиго, запертым в Уэко Мундо, Общество Душ подвергается нападению таинственной группы воинов, называющих себя Ванденрайхами. Капитаны Жнецов душ доблестно противостоят захватчикам, но это битва, в которой они, возможно, не смогут победить...'),
(12, 'ОНО', 'uploads/11296.png', 4.8, '1986-09-15', 'В маленьком провинциальном городке Дерри много лет назад семерым подросткам пришлось столкнуться с кромешным ужасом - живым воплощением ада. Прошли годы... Подростки повзрослели, и ничто, казалось, не предвещало новой беды. Но кошмар прошлого вернулся, неведомая сила повлекла семерых друзей назад, в новую битву со Злом. Ибо в Дерри опять льется кровь и бесследно исчезают люди. '),
(13, 'Сияние', 'uploads/2421774_detail.jpg', 4.3, '1977-01-28', '…Проходят годы, десятилетия, но потрясающая история писателя Джека Торранса, его сынишки Дэнни, наделенного необычным даром, и поединка с темными силами, обитающими в роскошном отеле \"Оверлук\", по-прежнему завораживает и держит в неослабевающем напряжении читателей самого разного возраста…'),
(15, 'Властелин Колец', 'uploads/2423346_detail.jpg', 4.9, '1954-07-29', 'Трилогия «Властелин Колец» бесспорно возглавляет список «культовых» книг ХХ века. Ее автор, Дж. Р.Р. Толкин, профессор Оксфордского университета, специалист по древнему и средневековому английскому языку, создал удивительный мир — Средиземье, который вот уже без малого пятьдесят лет неодолимо влечет к себе миллионы читателей. Великолепная кинотрилогия, снятая Питером Джексоном, в десятки раз увеличила ряды поклонников как Толкина, так и самого жанра героического фэнтези. '),
(16, 'Сами Боги', 'uploads/2951031_detail.jpg', 4.1, '1972-11-16', 'В 2100 изобретение \"электронного насоса\" спасло планету от энергетического кризиса. Источник бесконечной и бесплатной энергии решил практически все проблемы цивилизации. \"Насос\" работал на принципе обмена с параллельной вселенной, и настал момент, когда равновесие было нарушено, а до космической катастрофы остались считанные часы… '),
(17, 'Стальной Алхимик. Книга 17', 'uploads/2913283_detail.jpg', 4.7, '2010-08-12', 'Эмоциональный накал происходящих в Централе событий достигает наивысшей точки. Сможет ли полковник Рой Мустанг принять труднейшее решение в своей жизни? Воспользуется ли Альфонс шансом наконец вернуть себе тело, даже если придется пожертвовать ради этого очень многим? Время получать ответы на непростые вопросы, стоя перед вратами Истины в центре мира… '),
(19, 'Приключения Шерлока Холмса', 'uploads/43502.png', 4.4, '1892-10-14', 'Перу английского писателя, публициста и журналиста Артура Конан Дойла принадлежат исторические, приключенческие, фантастические романы и труды по спиритизму, но в мировую литературу он вошел как создатель самого Великого Сыщика всех времен и народов - Шерлока Холмса. Благородный и бесстрашный борец со Злом, обладатель острого ума и необыкновенной наблюдательности, с помощью своего дедуктивного метода сыщик решает самые запутанные головоломки, зачастую спасая этим человеческие жизни. Он гениально перевоплощается, обладает актерским даром и умеет поставить эффектную точку в конце каждого блестяще проведенного им расследования. Неутомимый Шерлок Холмс и его легко увлекающийся друг доктор Ватсон дороги сердцу читателей всего мира. В это издание вошли романы \"Этюд в багровых тонах\" и \"Знак четырех\", а также цикл рассказов \"Приключения Шерлока Холмса\".'),
(20, 'Мастер и Маргарита', 'uploads/2936965_detail.png', 4.7, '1967-01-17', '«Мастер и Маргарита» – культовый роман, ярчайший шедевр русской литературы, так до конца и не понятый, загадочный и манящий. Нечистая сила во главе с самим Дьяволом Воландом однажды весенним днем появляется в Москве, чтобы навести порядок. Именно так начинается полная приключений и иронии история, в которой в конце концов побеждают любовь и верность. ');

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
(2, 20, 11),
(4, 12, 6),
(5, 13, 6),
(7, 8, 4),
(8, 8, 5),
(12, 19, 10),
(13, 15, 7),
(14, 6, 3),
(16, 17, 9),
(19, 16, 8),
(101, 2, 2);

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
(31, 2, 1);

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
(7, 'Детектив'),
(15, 'Романтика'),
(17, 'Роман');

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
  MODIFY `id_author` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT для таблицы `books`
--
ALTER TABLE `books`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT для таблицы `books_author`
--
ALTER TABLE `books_author`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT для таблицы `books_genres`
--
ALTER TABLE `books_genres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `genres`
--
ALTER TABLE `genres`
  MODIFY `id_genres` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
