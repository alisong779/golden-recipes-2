const BASE_URL = 'http://localhost:3000'

function displayCreateForm(id){
	document.querySelector('#comment-form').innerHTML = `
	<form onsubmit="createComment(${id}); return false;">
	<label>Comment:</label>
	<input type="textarea" id="comments">
	<input type="submit" value="Create Comment"
	</form>
	`
}

function getComments(id){
	$("#comments").html(`<ul>`)
	fetch(BASE_URL + '/recipes/${id}.json')
	.then(resp => resp.json())
	.then(recipes => {
		document.getElementById("comments").innerHTML += recipe.comments.map(cmt => {
			let ct = new Comment(cmt)
			return ct.renderCommentLink()
		}).join('')
		$("#comments").append(`<ul>`)
		addListenersToLinks()
	})
}

function addListenersToLinks(){
	document.querySelectorAll("#comments-links").forEach(function(link) {
		link.addEventListener("click", displayComment)
	})
}

function displayComment(e){
	e.preventDefault();
	fetch(BASE_URL + '/recipes/${this.dataset.recid}/comments/${this.dataset.id}')
	.then(resp => resp.json())
	.then(comment => {
		let ct = new Comment(cmt)
		document.querySelectorAll("#recipes-lis").forEach(function(li){
			if(parseInt(li.dataset.id) === ct.id){
				li.innerHTML += ct.renderComment()
			}
		})
	})
}

function createComment(id){
	const comment = {
		comment: document.getElementById("comment").value
	}
	fetch(BASE_URL + '/recipes/${id}/comments', {
		method: "POST",
		headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json'
		},
		body: JSON.stringify(comment)
	})
	.then(resp => resp.json())
	.then(comment => {
		let cmt = new Comment(comment)
		document.querySelector("#comment-form").innerHTML = `
			<p>Comment has been added!</p><br>
			<button onclick='displayCreateForm(${cmt.recipe_id})'>Add Comment</button>
		`
		getComments(cmt.recipe_id)
	})
}

class Comment{
	constructor(comment){
		this.id = comment.id
		this.comment = comment.comment
	}
	renderCommentLink(){
		return `
		<li id="comments-lis" data-id="${this.id}"><a href="#" data-id="${this.id}" data-recid="${this.recipe_id}" id="comments-links">${this.comment}</a></li>
		`
	}
	renderComment(){
		return `
			<div>
			<p>Comments: ${this.comments}</p>
			</div>
		`
	}
}
