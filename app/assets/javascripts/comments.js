const BASE_URL = 'http://localhost:3000'
window.addEventListener('DOMContentLoaded', (event) => { 
	console.log('DOM fully loaded and parsed'); 

	let rootElement = document.querySelector('body'); 
	rootElement.addEventListener('submit', function(event){ 
		event.preventDefault();
		let value = document.getElementById('comment').value
		console.log(value);
	}, true)
});

function displayCreateForm(id){
	let commentFormDiv = document.getElementById('comment-form')
	let html =
	 ` <form onsubmit="createComment(${id}); return false;">
		<label>Comment: </label>
		<input type="text" id="comment"><br />
		<input type="submit" value="Create Comment"> 
		</form> `
	commentFormDiv.innerHTML = html;
	// console.log(document.querySelector("form"))
	addEventListener("submit", createComment, true)
}

function createComment(id){
	comt = {
		comment: document.getElementById("comment").value
	}

	fetch(BASE_URL + '/recipes/${id}/comments', {
		method: "POST",
		headers: {
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(comt)
	})
	.then(resp => resp.json())
	.then(comment => {
		let cmt = new Ct(comment)
		getComments(cmt.recipe_id)
	})
}


function getComments(id){
	let main = document.getElementById('main')
	main.innerHTML = '<ul>'
	fetch(BASE_URL + '/recipes/${id}/comments')
	.then(resp => resp.json())
	.then(comments => {
		main.innerHTML += comments.map(comment => {
		let cmt = new Ct(comment)
		return cmt.renderComment(comment)
	}).join('')
	main.innerHTML += '</ul>'
	})
}

function	displayComment(e){
	e.preventDefault();
	clearForm()
	let id = this.dataset.id
	let main = document.getElementById('main')
	main.innerHTML = ''

	fetch(BASE_URL + '/recipes/${this.dataset.recipeid}/comments/${this.dataset.id}')
		.then(resp => resp.json())
		.then(comment =>{
			main.innerHTML += '<h3>${comment.comment}</h3>'
		})
}


function clearForm(){
	let commentFormDiv = document.getElementById('comment-form')
	commentFormDiv.innerHTML = ''
}


class Ct{
	constructor(comment){
		this.id = comment.id
		this.comment = comment.comment
		this.recipe_id = comment.recipe_id
	}
	renderComment(){
		return `<li id="comments-lis" data-id="${this.id}"><a href="#" data-id="${this.id}" data-recipeid="${this.recipe_id}" id="comments-links">${this.comment}</a></li>`
	}
}
