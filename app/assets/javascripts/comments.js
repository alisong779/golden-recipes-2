const BASE_URL = "http://localhost:3000"

// Display Form
function displayCreateForm(id){
  let form = document.querySelector("#comment-form");
  let html = `
    <form id="comment-form">
    <label>Title:</label>
    <input type="text" class="form-control" id="title"><br>
    <label>Comment:</label>
    <textarea class="form-control" rows="5" id="comment"></textarea> <br>
    <input type="submit" value="Submit" class="btn btn-primary" id="button">
    </form>
  `
  form.innerHTML = html

  document.getElementById("comment-form").addEventListener('submit', function (event){
    event.preventDefault()
    createComment(`${id}`)
  })
	}

// Comment class constructor with methods on prototype
  class Comment {
    constructor(ct) {
        this.id = ct.id
        this.title = ct.title
        this.comment = ct.comment
        this.recipe_id = ct.recipe_id
    }

    renderComment(){
      return `
        <div>
          <p>${this.title}</p>
          <p>${this.comment}</p>
        </div>
      `
    }
    renderCommentLink() {
        return `
            <li id="comments-lis" data-id="${this.id}"><a href="#" data-id="${this.id}" data-rec_id="${this.recipe_id}" id="comments-links">${this.title}</a></li>
        `
    }
  }

// Create Comment
  function createComment(id){
    comment = {
      comment: document.getElementById("comment").value,
      title: document.getElementById("title").value
    };
    fetch(BASE_URL + `/recipes/${id}/comments`, {
      method: "POST",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({comment})
    })
    .then(resp => resp.json())
    .then(resp => {
      let c = new Comment(resp);
      document.querySelector("#comment-form").innerHTML = `
        <p>Your comment has been added!</p>
        <h4>${c.title}</h4>
        <button class="btn btn-primary" onclick='getComments(${c.recipe_id})'>See All Comments</button>
      `;
    });
  }

// Comments Index with Links
  function getComments(id){
    $("#comments").html(`<ul>`)
    fetch(BASE_URL + `/recipes/${id}/comments`)
    .then(resp => resp.json())
    .then(comments => {
      document.getElementById("comment-form").innerHTML += comments.map(cmt => {
        let c = new Comment(cmt)
        return c.renderCommentLink()
      }).join('')
      $("#comment-form").append(`</ul>`)
      addListenersToLinks()
    })
  }

// Comment Link Listeners
  function addListenersToLinks() {
    document.querySelectorAll("#comments-links").forEach(function(link) {
        link.addEventListener("click", displayComment)
    })
}

// Show Comment
function displayComment(e) {
    e.preventDefault()
    let id = this.dataset.id
    let main = document.getElementById('main')
    main.innerHTML = ''

    fetch(BASE_URL + `/recipes/${this.dataset.rec_id}/comments/${id}`)
    .then(resp => resp.json())
    .then(comment => {
        main.innerHTML += `<br><h4>${comment.title}</h4>`
        main.innerHTML += `<p>${comment.comment}</p>`
    })
}
