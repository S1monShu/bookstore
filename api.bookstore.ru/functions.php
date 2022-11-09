<?php

function getBooks($connect){
    $books = mysqli_query($connect, "SELECT

    books.name AS 'Название',
    
    (SELECT GROUP_CONCAT(author.name SEPARATOR ', ') FROM author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id) AS 'Авторы',
    
    (SELECT GROUP_CONCAT(genres.genre SEPARATOR ', ') FROM genres, books_genres WHERE
    genres.id_genres = books_genres.id_genre AND
    books_genres.id_book = books.id) AS 'Жанры'
    
    FROM books");
    $booklist = [];
    while ($book = mysqli_fetch_assoc($books)){
        $booklist[] = $book;
    }
    echo json_encode($booklist);
}

function getBooksByGenre($connect, $id){
    $books = mysqli_query($connect, "SELECT

    books.name AS 'Название',
    books.image AS 'Изображение',
    
    (SELECT GROUP_CONCAT(author.name SEPARATOR ', ') FROM author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id) AS 'Авторы'
    
    FROM books, genres, books_genres
    
    WHERE genres.id_genres = books_genres.id_genre AND 
    books_genres.id_book = books.id AND
    genres.id_genres = '$id'");

    if(mysqli_num_rows($books) === 0){
        http_response_code(404);
        $res = [
            "status" => false,
            "message" => "Post not found"
        ];
        echo json_encode($res);
    } else {
        $booklist = [];
        while ($book = mysqli_fetch_assoc($books)){
        $booklist[] = $book;
    }
    echo json_encode($booklist);
    }
}

function getBooksByAuthor($connect, $id){
    $books = mysqli_query($connect, "SELECT

    books.name AS 'Название',
    books.image AS 'Изображение',
    
    (SELECT GROUP_CONCAT(author.name SEPARATOR ', ') FROM author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id) AS 'Авторы'
    
    FROM books, author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id AND 
    
    author.id_author = '$id'");

    if(mysqli_num_rows($books) === 0){
        http_response_code(404);
        $res = [
            "status" => false,
            "message" => "Post not found"
        ];
        echo json_encode($res);
    } else {
        $booklist = [];
        while ($book = mysqli_fetch_assoc($books)){
        $booklist[] = $book;
    }
    echo json_encode($booklist);
    }
}

function getBook($connect, $id){
    $book = mysqli_query($connect, "SELECT

    books.name AS 'Название',
    books.image AS 'Изображение',
    books.rate AS 'Оценка',
    books.date AS 'Дата выпуска',
    
    (SELECT GROUP_CONCAT(author.name SEPARATOR ', ') FROM author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id) AS 'Авторы',
    
    (SELECT GROUP_CONCAT(genres.genre SEPARATOR ', ') FROM genres, books_genres WHERE
    genres.id_genres = books_genres.id_genre AND
    books_genres.id_book = books.id) AS 'Жанры'
    
    FROM books
    
    WHERE books.id = '$id'");

    if(mysqli_num_rows($book) === 0){
        http_response_code(404);
        $res = [
            "status" => false,
            "message" => "Post not found"
        ];
        echo json_encode($res);
    } else {
        $bookinfo = [];
        while ($info = mysqli_fetch_assoc($book)){
        $bookinfo[] = $info;
    }
    echo json_encode($bookinfo);
    }
}

function addBook($connect, $data){
    $author_name = $data['author_name'];
    $book_name = $data['book_name'];
    $image = $data['image'];
    $rate = $data['rate'];
    $date = $data['date'];
    $genre = $data['genre'];
    $check_author = mysqli_query($connect, "SELECT * FROM author WHERE name = '$author_name'");

    if(mysqli_num_rows($check_author) > 0){
        mysqli_query($connect, "INSERT INTO books (name, image, rate, date) VALUES ('$book_name', '$image', '$rate', '$date')");
        mysqli_query($connect, "INSERT INTO books_author (id_author, id_book) SELECT id_author, id FROM author, books WHERE author.name LIKE '$author_name' AND books.name LIKE '$book_name'");
        mysqli_query($connect, "INSERT INTO books_genres (id_genre, id_book) SELECT id_genres, id FROM genres, books WHERE genres.genre LIKE '$genre' AND books.name LIKE '$book_name'");

        http_response_code(201);

        $res = [
            "status" => true,
            "book_id" => mysqli_fetch_assoc(mysqli_query($connect, "SELECT id FROM books WHERE name = '$book_name'")),
        ];

        echo json_encode($res);
    }
    else {
        mysqli_query($connect, "INSERT INTO author (name) VALUES ('$author_name');");
        mysqli_query($connect, "INSERT INTO books (name, image, rate, date) VALUES ('$book_name', '$image', '$rate', '$date')");
        mysqli_query($connect, "INSERT INTO books_author (id_author, id_book) SELECT id_author, id FROM author, books WHERE author.name LIKE '$author_name' AND books.name LIKE '$book_name'");
        mysqli_query($connect, "INSERT INTO books_genres (id_genre, id_book) SELECT id_genres, id FROM genres, books WHERE genres.genre LIKE '$genre' AND books.name LIKE '$book_name'");

        http_response_code(201);

        $res = [
            "status" => true,
            "book_id" => mysqli_fetch_assoc(mysqli_query($connect, "SELECT id FROM books WHERE name = '$book_name'")),
        ];

        echo json_encode($res);
    }
}

function updateBook($connect, $id, $data){

    $author_name = explode(', ',$data['author_name']);
    $book_name = $data['book_name'];
    $image = $data['image'];
    $rate = $data['rate'];
    $date = $data['date'];
    $genre = explode(', ',$data['genre']);

    http_response_code(200);

    $res = [
        "status" => true,
        "message" => "Post updated"
    ];

    echo json_encode($res);
}

function deletePost($connect, $id){
    mysqli_query( $connect, "DELETE FROM `posts` WHERE `posts`.`id` = $id");

    http_response_code(200);

    $res = [
        "status" => true,
        "message" => "Post deleted"
    ];

    echo json_encode($res);
}