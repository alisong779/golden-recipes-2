const BASE_URL = 'http://localhost:3000'

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
    constructor(obj) {
        this.id = obj.id
        this.comment = obj.comment
        this.recipe_id = obj.recipe_id
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
    .then(comment => {
      let c = new Comment(comment);
      document.querySelector("#comment-form").innerHTML = `
        <p>Comment has been added</p><br>
      `;
      getComments(c.recipe_id);
    });
  }
