const BASE_URL = 'http://localhost:3000'

function displayCreateForm(){
	let commentFormDiv = document.getElementById('comment-form')
	let html = `
		<form onsubmit="createComment(); return false;">
		<label>Comment:</label>
		<input type="textarea" id="comment">
		<input type="submit" value="Create Comment"
		</form>
		`
	commentFormDiv.innerHTML = html;
}

function getComments(){
	clearForm()
	let main = document.getElementById('main')
	main.innerHTML = '<ul>'
	fetch(BASE_URL + '/comments')
	.then(resp => resp.json())
	.then(comments => {
		main.innerHTML += comments.map(comment => {
		const cmt = new Ct(comment)
		return cmt.renderComment()
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

	fetch(BASE_URL + '/comments/' + id)
		.then(resp => resp.json())
		.then(comment =>{
			main.innerHTML += '<h3>${comment.comment}</h3>'
		})
}


function createComment(){
	const comt = {
		comment: document.getElementById('comment').value
	}
	fetch(BASE_URL + '/comments', {
		method: 'POST',
		body: JSON.stringify({ comt }),
		headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json'
		}
	}).then(resp => resp.json())
	.then(comt => {
		alert("Comment Sucessfully Submitted!")
		let cmt = new Ct(comt);
		document.querySelector("#main ul").innerHTML += cmt.renderComment()
		let commentFormDiv = document.getElementById('comment-form')
		commentFormDiv.innerHTML = ''
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
	}
	renderComment(){
		return `<li><a href="#" data-id="${this.id}">${this.comment}</a></li>`
	}
}
