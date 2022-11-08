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

function addPost($connect, $data){
    $title = $data['title'];
    $body = $data['body'];
    $post = mysqli_query($connect, "INSERT INTO `posts` (`id`, `title`, `body`) VALUES (NULL, '$title', '$body')");

    http_response_code(201);

    $res = [
        "status" => true,
        "post_id" => mysqli_insert_id($connect),
    ];
    
    echo json_encode($res);
}

function updatePost($connect, $id, $data){
    $title = $data['title'];
    $body = $data['body'];
    $post = mysqli_query($connect, "UPDATE `posts` SET `title` = '$title', `body` = '$body' WHERE `posts`.`id` = $id ");

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