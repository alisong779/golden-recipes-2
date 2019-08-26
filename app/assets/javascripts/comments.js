const BASE_URL = "http://localhost:3000"

function displayCreateForm(id){
  document.querySelector("#comment-form").innerHTML = `
    <form onsubmit="createComment(${id}); return false;">
      <label>Comment </label>
      <input type="textarea" id="comment"> <br>
      <input type="submit" value="Create Comment">
    </form>
    `;
	}

  class Comment {
    constructor(ct) {
        this.id = ct.id
        this.comment = ct.comment
        this.recipe_id = ct.recipe_id
    }

    renderComment(){
      return `
        <div>
          <p>${this.comment}</p>
        </div>
      `
    }
  }

  function createComment(id){
    comment = {
      comment: document.getElementById("comment").value
    };
    fetch(BASE_URL + `/recipes/${id}/comments`, {
      method: "POST",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(comment)
    })
    .then(resp => resp.json())
    .then(cmt => {
      let c = new Comment(cmt);
      document.querySelector("#comment-form").innerHTML = `
        <p>Comment has been added</p><br>
      `;
      getComments(c.recipe_id);
    });
  }

  function getComments(id){
    $("#comments").html(`<ul>`)
    fetch(BASE_URL + `/recipes/${id}.json`)
    .then(resp => resp.json())
    .then(recipe => {
      document.getElementById("comments").innerHTML += recipe.comments.map(cmt => {
        let c = new Comment(cmt)
        return c.renderComment()
      }).join('')
      $("#comments").append(`</ul>`)
    })
  }
