async function getBooks(){
    let res = await fetch ('http://api.bookstore.ru/books');
    let books = await res.json();

    document.querySelector('.card-list').innerHTML = '';

    books.forEach((book) => {
        document.querySelector('.card-list').innerHTML +=`
        <div class="card">
                <img src="${book.image}">
                <h1>${book.name}</h1>
                <a>${book.authors}</a>
            </div>`
    });
}

async function getGenre(id){
    let res = await fetch (`http://api.bookstore.ru/books/genres/${id}`);
    let books = await res.json();

    document.querySelector('.card-list').innerHTML = '';

    books.forEach((book) => {
        document.querySelector('.card-list').innerHTML +=`
        <div class="card">
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

    books.forEach((book) => {
        findSearchBookName = searchRes.indexOf(book.name);
        findSearchAuthorName = searchRes.indexOf(book.authors);

        if(findSearchAuthorName != -1 && findSearchBookName != -1){
            document.querySelector('.card-list').innerHTML +=`
                <div class="card">
                    <img src="${book.image}">
                    <h1>${book.name}</h1>
                    <a>${book.authors}</a>
                </div>`;
        }
        else if(findSearchAuthorName != -1 || findSearchBookName != -1){
            document.querySelector('.card-list').innerHTML +=`
                <div class="card">
                    <img src="${book.image}">
                    <h1>${book.name}</h1>
                    <a>${book.authors}</a>
                </div>`;
        }
    })
}

getBooks();