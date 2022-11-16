<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: *');
header('Access-Control-Allow-Methods: *');
header('Access-Control-Allow-Credentials: true');
header('Content-type: json/application');

require 'connect.php';
require 'functions.php';

$method = $_SERVER['REQUEST_METHOD'];
$q = $_GET['q'];
$params = explode('/', $q);
$type = $params[0];

if(isset($params[1])){
    $identificator = $params[1];
    $id = $params[2];
}

if($method === 'GET'){
        if($type === 'books'){
            if(isset($identificator)){
                if($identificator === 'book'){
                    getBook($connect, $id);
                }
                elseif($identificator === 'genres'){
                    if(isset($id)){
                    getBooksByGenre($connect, $id);
                    } else {
                    getGenres($connect);  
                }
                } elseif($identificator === 'author'){
                    getBooksByAuthor($connect, $id);
                }
            } else {
                getBooks($connect);
            } 
        }
    }
    elseif($method === 'POST'){
        if($type === 'books'){
            if(isset($identificator)) {
                if ($identificator === 'book') {
                    if(isset($id)){
                        updateBook($connect, $id, $_POST, $_FILES);
                    }
                    else {
                        addBook($connect, $_POST, $_FILES);
                    }
                }
                if ($identificator === 'genres') {
                    addGenre($connect, $_POST);
                }
            }
        }
    }
    elseif($method === 'DELETE'){
        if($type === 'books'){
            if(isset($identificator)){
                if($identificator === 'book'){
                    if(isset($id)){
                        deleteBook($connect, $id);
                    }
                }
            }
        }
}