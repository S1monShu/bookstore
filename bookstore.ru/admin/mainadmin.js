async function getBooks(){
    let res = await fetch ('http://api.bookstore.ru/books');
    let books = await res.json();

    document.querySelector('.card-list').innerHTML = '';
    document.querySelector('#book_container').innerHTML = '';

    books.forEach((book) => {
        document.querySelector('.card-list').innerHTML +=`
        <div class="card" onclick="getBook(${book.id})">
                <button id="delete" onclick="deleteBookAlert(${book.id})"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
                <img src="../${book.image}">
                <h1>${book.name}</h1>
                <a>${book.authors}</a>
            </div>`
    });

    document.querySelector('.card-list').innerHTML +=`
        <div class="card" onclick="addBookForm()">
                <div id="add-book">
                    <img src="../img/add_FILL0_wght400_GRAD0_opsz48.png">
                </div>
            </div>`
}

async function getGenres(){
    let res = await fetch ('http://api.bookstore.ru/books/genres');
    let genres = await res.json();

    document.querySelector('#genre_container').innerHTML = '';
    document.querySelector('#book_container').innerHTML = '';

    document.querySelector('#genre_container').innerHTML += `
    <button onclick="getBooks()">Всё</button>`;

    genres.forEach((genre) => {
        document.querySelector('#genre_container').innerHTML +=`
        <button onclick="getBookByGenre(${genre.id})">${genre.genre}</button>`
    });

    document.querySelector('#genre_container').innerHTML += `
    <button onclick="addGenreForm()">+</button>`;
}

async function getBookByGenre(id){
    let res = await fetch (`http://api.bookstore.ru/books/genres/${id}`);
    let books = await res.json();

    document.querySelector('.card-list').innerHTML = '';
    document.querySelector('#book_container').innerHTML = '';

    books.forEach((book) => {
        document.querySelector('.card-list').innerHTML +=`
        <div class="card" onclick="getBook(${book.id})">
        <button id="delete" onclick="deleteBookAlert(${book.id})"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
                <img src="../${book.image}">
                <h1>${book.name}</h1>
                <a>${book.authors}</a>
            </div>`
    });
}

async function search(){
    let searchRes = document.getElementById('searchbar').value;
    
    let res = await fetch ('http://api.bookstore.ru/books');
    let books = await res.json();

    document.querySelector('.card-list').innerHTML = '';
    document.querySelector('#book_container').innerHTML = '';

    books.forEach((book) => {
        findBookNameSearch = book.name.indexOf(searchRes);
        findAuthorNameSearch = book.authors.indexOf(searchRes);
        findSearchBookName = searchRes.indexOf(book.name);
        findSearchAuthorName = searchRes.indexOf(book.authors);

        if(findSearchAuthorName != -1 || findSearchBookName != -1 || findBookNameSearch != -1 || findAuthorNameSearch != -1){
            document.querySelector('.card-list').innerHTML +=`
            <div class="card" onclick="getBook(${book.id})">
            <button id="delete" onclick="deleteBookAlert(${book.id})"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
                    <img src="../${book.image}">
                    <h1>${book.name}</h1>
                    <a>${book.authors}</a>
                </div>`;
        }
    })

    searchRes = 0;
}

async function getBook(id){
    let res = await fetch (`http://api.bookstore.ru/books/book/${id}`);
    let infos = await res.json();
    document.querySelector('.card-list').innerHTML = '';
    document.querySelector('#book_container').innerHTML = '';

    infos.forEach((info) => {
        document.querySelector('#book_container').innerHTML += `
        <div id="bookimage">
                <img src="../${info.image}">
            </div>
            <div id="full_discription">
                <h2>${info.name}</h2>
                <p id="author">${info.authorname}</p>
                <p id="rate"><img src="../img/star.png">${info.rate}</p>
                <p class="type">Жанр: <span>${info.genres}</span></p>
                <p class="type">ID товара: <span>${id}</span></p>
                <p class="type">Дата выпуска: <span>${info.date}</span></p>
                <h3>Аннотация</h3>
                <p id="anno">${info.discription}</p>
                <button id="update" onclick="updateBookForm(${id})"><img src="../img/refresh_FILL0_wght400_GRAD0_opsz48.png"></button>
            </div>
        </div>`
    })
}

async function closeWindow(){
    document.getElementById('form-container').style.display = 'none';
    document.querySelector('#form').remove();
}

async function addGenreForm(){
    document.getElementById('form-container').style.display = 'flex'
    document.querySelector('#form-container').innerHTML += `
        <div id='form'>
            <img src="../img/backgound_el_1.png" id="form-el_1">
            <button id="close-form" onclick="closeWindow()"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
            <h3>Введите жанр</h3>
            <input id="genre"></br>
            <button id="done_button" onclick="addGenre()">Подтвердить</button>
        </div>
    `;
}

async function updateBookForm(id){
    document.getElementById('form-container').style.display = 'flex'
    document.querySelector('#form-container').innerHTML += `
        <div id='form'>
            <img src="../img/backgound_el_1.png" id="form-el_1">
            <button id="close-form" onclick="closeWindow()"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
            <h3>Введите данные книги</h3>
            <input id="book_name" placeholder="Название книги"></br>
            <input id="author_name" placeholder="Автор(ы)"></br>
            <input id="rate" placeholder="Оценка"></br>
            <input id="date" placeholder="Дата выхода (xxxx-xx-xx)">></br>
            <input id="discription" placeholder="Описание">></br>
            <input id="genre" placeholder="Жанр(ы)"></br>
            <input type="file" id="image"></br>
            <button id="done_button" onclick="updateBook(${id})">Подтвердить</button>
        </div>
    `;
}

async function addBookForm(){
    document.getElementById('form-container').style.display = 'flex'
    document.querySelector('#form-container').innerHTML += `
        <div id='form'>
            <img src="../img/backgound_el_1.png" id="form-el_1">
            <button id="close-form" onclick="closeWindow()"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
            <h3>Введите данные книги</h3>
            <input id="book_name" placeholder="Название книги"></br>
            <input id="author_name" placeholder="Автор(ы)"></br>
            <input id="rate" placeholder="Оценка"></br>
            <input id="date" placeholder="Дата выхода (xxxx-xx-xx)">></br>
            <input id="discription" placeholder="Описание">></br>
            <input id="genre" placeholder="Жанр(ы)"></br>
            <input type="file" id="image"></br>
            <button id="done_button" onclick="addBook()">Подтвердить</button>
        </div>
    `;
}

async function deleteBookAlert(id){
    document.getElementById('form-container').style.display = 'flex'
    document.querySelector('#form-container').innerHTML += `
        <div id='form'>
            <img src="../img/backgound_el_1.png" id="form-el_1">
            <button id="close-form" onclick="closeWindow()"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
            <h3>Вы действительно хотите удалить эту книгу?</h3>
            <button id="done_button" onclick="deleteBook(${id})">Да</button>
        </div>
    `;
}

async function addGenre(){
    let genre = document.getElementById('genre').value;

    let formdata = new FormData();
    formdata.append('genre', genre);

    let res = await fetch('http://api.bookstore.ru/books/genres', {
        method: 'POST',
        body: formdata
    });
    
    let data = await res.json();
    
    if(data.status === true){
        await getGenres();
        document.getElementById('form-container').style.display = 'none';
        document.querySelector('#form').remove();
    }
}


async function updateBook(id){
    let book_name = document.getElementById('book_name').value;
    let author_name = document.getElementById('author_name').value;
    let rate = document.getElementById('rate').value;
    let date = document.getElementById('date').value;
    let discription = document.getElementById('discription').value;
    let genre = document.getElementById('genre').value;
    let image = document.getElementById('image').files[0];

    let formdata = new FormData();
    formdata.append('id', id);
    formdata.append('book_name', book_name);
    formdata.append('author_name', author_name);
    formdata.append('rate', rate);
    formdata.append('date', date);
    formdata.append('discription', discription);
    formdata.append('genre', genre);
    formdata.append('image', image);

    let res = await fetch(`http://api.bookstore.ru/books/book/${id}`, {
        method: 'POST',
        body: formdata
    });

    let data = await res.json();

    if(data.status === true){
        await getBook(id);
        document.getElementById('form-container').style.display = 'none';
        document.querySelector('#form').remove();
    }
}

async function addBook(){
    let book_name = document.getElementById('book_name').value;
    let author_name = document.getElementById('author_name').value;
    let rate = document.getElementById('rate').value;
    let date = document.getElementById('date').value;
    let discription = document.getElementById('discription').value;
    let genre = document.getElementById('genre').value;
    let image = document.getElementById('image').files[0];

    let formdata = new FormData();
    formdata.append('book_name', book_name);
    formdata.append('author_name', author_name);
    formdata.append('rate', rate);
    formdata.append('date', date);
    formdata.append('discription', discription);
    formdata.append('genre', genre);
    formdata.append('image', image);

    let res = await fetch('http://api.bookstore.ru/books/book', {
        method: 'POST',
        body: formdata
    });

    let data = await res.json();

    if(data.status === true){
        await getBooks();;
        document.getElementById('form-container').style.display = 'none';
        document.querySelector('#form').remove();
    }
}

async function deleteBook(id){

    let res = await fetch(`http://api.bookstore.ru/books/book/${id}`, {
        method: 'DELETE'
    });

    let data = await res.json();

    if(data.status === true){
        await getBooks();
        document.getElementById('form-container').style.display = 'none';
        document.querySelector('#form').remove();
    }
}

getGenres();
getBooks();