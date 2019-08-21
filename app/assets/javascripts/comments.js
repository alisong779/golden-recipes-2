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
		comments: document.getElementById("comment").value
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
	$("#main").html(`<ul>`)
	// let main = document.getElementById("main")
	// main.innerHTML = `<ul>`
	fetch(BASE_URL + `/recipes/${id}.json`)
	.then(resp => resp.json())
	.then(comments => {
		document.getElementById("main").innerHTML += recipe.comments.map(comment => {
		let cmt = new Ct(comment)
		return cmt.renderCommentLink()
	}).join('')
	$("#main").append(`<ul>`)
	addListenersToLinks()
	})
}

function addListenersToLinks() {
    document.querySelectorAll("#comments-links").forEach(function(link) {
        link.addEventListener("click", displayComment)
    })
}

// function	displayComment(e){
// 	e.preventDefault();
// 	// let id = this.dataset.id
// 	// let main = document.getElementById('main')
// 	// main.innerHTML = ''
//
// 	fetch(BASE_URL + `/recipes/${this.dataset.recipeid}/comments/${this.dataset.id}`)
// 		.then(resp => resp.json())
// 		.then(comment =>{
// 			let cmt = new Ct(comment)
// 			document.querySelectorAll("#main-lis").forEach(function(li)){
// 				if(parseInt(li.dataset.id) === cmt.id){
// 					li.innerHTML += cmt.renderComment()
// 				}
// 			})
// 		})
// }


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
	renderCommentLink(){
		return `<li id="comments-lis" data-id="${this.id}"><a href="#" data-id="${this.id}" data-recipeid="${this.recipe_id}" id="comments-links">${this.comment}</a></li>`
	}
}
