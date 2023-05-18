function coordonnees(pos) {
    //On récupère les coordonnées de l'utilisateur
    let crd = pos.coords;
    let latitude = crd.latitude;
    let longitude = crd.longitude;
    var bars = [];
     //Envoi de la requête au serveur
     const xhr = new XMLHttpRequest();
     xhr.open('POST', 'http://localhost:3000/scrapping/nearest', true);
     xhr.setRequestHeader('Content-Type', 'application/json');
     xhr.send(JSON.stringify({
            "latitude": 50.634204,
            "longitude": 3.04876
     }));

     //Réception de la réponse du serveur
     xhr.onloadend = function () {
       bars = JSON.parse(xhr.responseText);

       //On rend l'affichage des bars dynamique
        for (let i = 0; i < 3; i++) {
            document.getElementById('annonce').innerHTML +=
            '<div class="test"><img src="' +
            bars[i].bar.image +
            '"><a href="bar.html?id=' +
            bars[i].bar.id +
            '">' +
            bars[i].bar.name +
            '</a><p>' +
            bars[i].bar.adresse +
            '</p><p> A ' +
            bars[i].distance +
            ' mètres de vous !</p></div>';
        }
    }; 
}

navigator.geolocation.getCurrentPosition(coordonnees);