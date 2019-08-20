const BASE_URL = 'http://localhost:3000'

function displayCreateForm(){
	document.querySelector('#comment-form').innerHTML = `
	<form onsubmit="createComment(); return false;">
	<label>Comment:</label>
	<input type="textarea" id="comments">
	<input type="submit" value="Create Comment"
	</form>
	`
}

function createComment(){
	const comt = {
		comment: document.getElementById("comment").value
	}
	fetch(BASE_URL + '/comments/', {
		method: "POST",
		body: JSON.stringify({comt}),
		headers: {
			'Content-Type': 'application/json',
			'Accept': 'application/json'
		}
	}).then(resp => resp.json())
	.then(comt => {
		alert("Comment Sucessfully Submitted!");
		let cmt = new Comment(comt);
		let newCmt = document.querySelector("#comment-form");
		display.innerHTML += `
		<ul>
			<li>Comment: ${comt.comment}</li>
		</ul>
		`
		displayComments();
	});
}


function displayComments(){
	fetch(BASE_URL + '/comments/all')
	.then(resp => resp.json())
	.then(comments => {
		comments.map(comment => {
			index.innerHTML+= `
			<h4>${comment.comment}</h4>
			`
		})
	})
}

class Comment{
	constructor(comment){
		this.id = comment.id
		this.comment = comment.comment
	}
	renderComments(){
		return `
			<div>
			<p>Comments: ${this.comment}</p>
			</div>
		`
	}
}
