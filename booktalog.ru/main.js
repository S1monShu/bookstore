async function getBooks(){
    let res = await fetch ('http://api.bookstore.ru/books');
    let books = await res.json();

    document.querySelector('.card-list').innerHTML = '';
    document.querySelector('#book_container').innerHTML = '';

    books.forEach((book) => {
        document.querySelector('.card-list').innerHTML +=`
        <div class="card" onclick="getBook(${book.id})">
                <img src="${book.image}">
                <h1>${book.name}</h1>
                <a>${book.authors}</a>
            </div>`
    });
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
}

async function getBookByGenre(id){
    let res = await fetch (`http://api.bookstore.ru/books/genres/${id}`);
    let books = await res.json();

    document.querySelector('.card-list').innerHTML = '';
    document.querySelector('#book_container').innerHTML = '';

    books.forEach((book) => {
        document.querySelector('.card-list').innerHTML +=`
        <div class="card" onclick="getBook(${book.id})">
                <img src="${book.image}">
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
                    <img src="${book.image}">
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
                <img src="${info.image}">
            </div>
            <div id="full_discription">
                <h2>${info.name}</h2>
                <p id="author">${info.authorname}</p>
                <p id="rate"><img src="img/star.png">${info.rate}</p>
                <p class="type">Жанр: <span>${info.genres}</span></p>
                <p class="type">ID товара: <span>${id}</span></p>
                <p class="type">Дата выпуска: <span>${info.date}</span></p>
                <h3>Аннотация</h3>
                <p id="anno">${info.discription}</p>
            </div>
        </div>`
    })
}

async function getAdminForm(){
    document.getElementById('form-container').style.display = 'flex';
    document.querySelector('#form-container').innerHTML += `
        <div id='form'>
            <img src="../img/backgound_el_1.png" id="form-el_1">
            <button id="close-form" onclick="closeWindow()"><img src="../img/close_FILL0_wght400_GRAD0_opsz48.png"></button>
            <h3>Введите данные для входа</h3>
            <input id="login" placeholder="Логин"></br>
            <input type="password" id="password" placeholder="Пароль"></br>
            <button id="done_button" onclick="goToAdmin()">Подтвердить</button>
        </div>
    `;
}

async function goToAdmin(){
    $login = document.getElementById('login').value;
    $password = document.getElementById('password').value;

    if($login === 'admin' && $password === '1234'){
        window.location.assign("./admin/index.html");
    } else{
        alert("Введены неверные данные!");
    }

    $login = null;
    $password = null;
    document.getElementById('form-container').style.display = 'none';
    document.querySelector('#form').remove();
}

async function closeWindow(){
    document.getElementById('form-container').style.display = 'none';
    document.querySelector('#form').remove();
}

getGenres();
getBooks();