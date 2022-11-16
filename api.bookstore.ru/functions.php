<?php

function getBooks($connect){
    $books = mysqli_query($connect, "SELECT

    books.name AS 'name',
    books.image AS 'image',
    books.id AS 'id',
    
    (SELECT GROUP_CONCAT(author.name SEPARATOR ', ') FROM author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id) AS 'authors'
    
    FROM books");
    $booklist = [];
    while ($book = mysqli_fetch_assoc($books)){
        $booklist[] = $book;
    }
    echo json_encode($booklist);
}

function getGenres($connect){
    $genres = mysqli_query($connect, "SELECT id_genres AS id, genre FROM genres");
    $genrelist = [];
    while ($genre = mysqli_fetch_assoc($genres)){
        $genrelist[] = $genre;
    }
    echo json_encode($genrelist);
}

function getBooksByGenre($connect, $id){
    $books = mysqli_query($connect, "SELECT

    books.name AS 'name',
    books.image AS 'image',
    books.id AS 'id',
    
    (SELECT GROUP_CONCAT(author.name SEPARATOR ', ') FROM author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id) AS 'authors'
    
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

    books.name AS 'name',
    books.image AS 'image',
    books.rate AS 'rate',
    books.date AS 'date',
    books.discription AS 'discription',
    
    (SELECT GROUP_CONCAT(author.name SEPARATOR ', ') FROM author, books_author WHERE
    author.id_author = books_author.id_author AND
    books_author.id_book = books.id) AS 'authorname',
    
    (SELECT GROUP_CONCAT(genres.genre SEPARATOR ', ') FROM genres, books_genres WHERE
    genres.id_genres = books_genres.id_genre AND
    books_genres.id_book = books.id) AS 'genres'
    
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


function addBook($connect, $data, $file){
    
    $extention = pathinfo($file['image']['name'], PATHINFO_EXTENSION);
    $filename = uniqid().".".$extention;
    move_uploaded_file($file['image']['tmp_name'], "../booktalog.ru/uploads/".$filename);
    $filename = 'uploads/'.$filename;

    $author_name = explode(', ', $data['author_name']);
    $book_name = $data['book_name'];
    $rate = $data['rate'];
    $date = $data['date'];
    $genre = explode(', ',$data['genre']);
    $discription = $data['discription'];
    
    mysqli_query($connect, "INSERT INTO books (name, image, rate, date, discription) VALUES ('$book_name', '$filename', '$rate', '$date', '$discription')");    
    
    for ($i = 0; $i < count($author_name); $i++){
        if(!mysqli_num_rows(mysqli_query($connect, "SELECT * FROM author WHERE name = '$author_name[$i]'"))){
            mysqli_query($connect, "INSERT INTO author (name) VALUES ('$author_name[$i]');");
        }
        mysqli_query($connect, "INSERT INTO books_author (id_author, id_book) SELECT id_author, id FROM author, books WHERE author.name LIKE '$author_name[$i]' AND books.name LIKE '$book_name'");
    }

    for ($i = 0; $i < count($genre); $i++){
        if(!mysqli_num_rows(mysqli_query($connect, "SELECT * FROM genres WHERE genre = '$genre[$i]'"))){
            mysqli_query($connect, "INSERT INTO genres (genre) VALUES ('$genre[$i]');");
        }
        mysqli_query($connect, "INSERT INTO books_genres (id_genre, id_book) SELECT id_genres, id FROM genres, books WHERE genres.genre LIKE '$genre[$i]' AND books.name LIKE '$book_name'");
    }

        http_response_code(201);

        $res = [
            "status" => true,
            "book_id" => mysqli_fetch_assoc(mysqli_query($connect, "SELECT id FROM books WHERE name = '$book_name'")),
        ];

        echo json_encode($res);
    
}

function addGenre($connect, $data){
    $genre = $data['genre'];
    $check_genre = mysqli_query($connect, "SELECT * FROM genres WHERE genre LIKE '$genre'");
    if(mysqli_num_rows($check_genre) === 0){
        mysqli_query($connect, "INSERT INTO genres (genre) VALUES ('$genre');");

        http_response_code(201);

        $res = [
            "status" => true,
            "book_id" => mysqli_fetch_assoc(mysqli_query($connect, "SELECT id_genres FROM genres WHERE genre = '$genre'")),
        ];

        echo json_encode($res);
    } else{
        http_response_code(409);

        $res = [
            "status" => false,
            "genre_id" => mysqli_fetch_assoc(mysqli_query($connect, "SELECT id_genres FROM genres WHERE genre = '$genre'")),
        ];

        echo json_encode($res);
    }
}

function updateBook($connect, $id, $data, $file){

    $image = $file['image'];
    $author_name = explode(', ',$data['author_name']);
    $book_name = $data['book_name'];
    $rate = $data['rate'];
    $date = $data['date'];
    $discription = $data['discription'];
    $genre = explode(', ',$data['genre']);

    if($author_name[0] != ''){
            mysqli_query($connect, "DELETE FROM books_author WHERE id_book = $id");
            for($i = 0; $i < count($author_name); $i++) {
                mysqli_query($connect, "INSERT INTO books_author (id_author, id_book) VALUES ((SELECT id_author FROM author WHERE name = '$author_name[$i]'), '$id')");
            }
    }

    if($book_name != null){
        mysqli_query($connect, "UPDATE books SET name = '$book_name' WHERE id = '$id'");
    }

    if ($image != null){
        $extention = pathinfo($image['name'], PATHINFO_EXTENSION);
        $filename = uniqid().".".$extention;
        move_uploaded_file($image['tmp_name'], "../booktalog.ru/uploads/".$filename);
        $filename = 'uploads/'.$filename;
        mysqli_query($connect, "UPDATE books SET image = '$filename' WHERE id = '$id'");
    }

    if($rate != null){
        mysqli_query($connect, "UPDATE books SET rate = '$rate' WHERE id = '$id'");
    }

    if($date != null){
        mysqli_query($connect, "UPDATE books SET date = '$date' WHERE id = '$id'");
    }

    if($discription != null){
        mysqli_query($connect, "UPDATE books SET discription = '$discription' WHERE id = '$id'");
    }

    if($genre[0] != ''){
        mysqli_query($connect, "DELETE FROM books_genres WHERE id_book = $id");
        for($i = 0; $i < count($genre); $i++) {
            mysqli_query($connect, "INSERT INTO books_genres (id_genre, id_book) VALUES ((SELECT id_genres FROM genres WHERE genre = '$genre[$i]'), '$id')");
        }
    }

    http_response_code(200);

    $res = [
        "status" => true,
        "message" => "Book updated"
    ];

    echo json_encode($res);
}

function deleteBook($connect, $id){
    mysqli_query($connect, "DELETE FROM books_author WHERE id_book = '$id'");
    mysqli_query($connect, "DELETE FROM books_genres WHERE id_book = '$id'");
    mysqli_query($connect, "DELETE FROM books WHERE id = '$id'");

    http_response_code(200);

    $res = [
        "status" => true,
        "message" => "Book deleted"
    ];

    echo json_encode($res);
}