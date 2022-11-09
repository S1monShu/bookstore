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
                    getBooksByGenre($connect, $id);
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
                    addBook($connect, $_POST);
                }
            }
        }
    }
    elseif($method === 'PATCH'){
        if($type === 'books'){
            if(isset($identificator)){
                if($identificator === 'book') {
                    if(isset($id)) {
                        $data = file_get_contents('php://input');
                        $data = json_decode($data, true);
                        updatePost($connect, $id, $data);
                    }
                }
            }
        }
    }
    elseif($method === 'DELETE'){
        if($type === 'posts'){
            if(isset($id)){
                deletePost($connect, $id);
            }
        }
}