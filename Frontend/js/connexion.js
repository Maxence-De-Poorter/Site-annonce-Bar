function connexion(){
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;

    var data = {
        email: email,
        password: password
    };

    //Envoi de la requête
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:3000/users/login', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify(data));

    //Réception de la réponse du serveur
    xhr.onloadend = function () {
        try {
            let user = JSON.parse(xhr.responseText);

            //Création du cookie
            document.cookie = "loggedIn=true";
            document.cookie = "username=" + user.username;
            window.location.href = "accueil.html";
        }
        catch (e) {
            document.getElementById('error').innerHTML = '<p>Erreur de connexion</p>';
            
        }
    }
}

function test(){
    // Vérifier si le cookie "loggedIn" existe avec la valeur "true"
if (document.cookie.includes("loggedIn=true")) {
    // Redirection vers la page de profil
    window.location.href = "profil.html";
  }
}

test();