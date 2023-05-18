let page = 1; // Page courante
const resultsPerPage = 5; // Nombre de résultats par page
let sortBy = 'distance'; // Default sorting option: 'distance'

function updateBars(xhr, latitude, longitude, sortBy) {
  document.getElementById('bars').innerHTML = ''; // Efface les bars actuellement affichés
  xhr.open('POST', 'http://localhost:3000/scrapping/all', true);
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.send(
    JSON.stringify({
      latitude: 50.634204,
      longitude: 3.04876,
      page: page,
      resultsPerPage: resultsPerPage,
      sortBy: sortBy // Include the sortBy parameter in the request payload
    })
  );
}

function coordonnees(pos) {
  // On récupère les coordonnées de l'utilisateur
  let crd = pos.coords;
  let latitude = crd.latitude;
  let longitude = crd.longitude;

  console.log('Votre position actuelle est :', latitude, longitude);

  const xhr = new XMLHttpRequest();

  xhr.onload = function () {
    let bars = JSON.parse(xhr.responseText);
    for (let i = 0; i < bars.length; i++) {
      document.getElementById('bars').innerHTML +=
        '<div class="bar"><img class="" src="' +
        bars[i].bar.image +
        '" alt=""><a class="card-title" href="bar.html?id=' +
        bars[i].bar.id +
        '">' +
        bars[i].bar.name +
        '</a><p class="card-text">' +
        bars[i].bar.adresse +
        '</div>';
    }

    // Met à jour l'état des boutons de pagination
    document.getElementById('prevBtn').disabled = page === 1;
    document.getElementById('nextBtn').disabled = bars.length < resultsPerPage;
  };

  // Affiche dynamiquement les bars, pass the sortBy variable to the updateBars function
  updateBars(xhr, latitude, longitude, sortBy);
}

function previousPage() {
  if (page > 1) {
    page--;
    navigator.geolocation.getCurrentPosition(coordonnees);
  }
}

function nextPage() {
  page++;
  navigator.geolocation.getCurrentPosition(coordonnees);
}

function selectSortOption() {
  let selectElement = document.getElementById('sortOption');
  sortBy = selectElement.value;
  navigator.geolocation.getCurrentPosition(coordonnees);
}

function search(){
  //Cherche le bar tapé dans la abrre de recherche dans la base de données
  //Si il existe, on affiche la page du bar
  //Sinon on affiche un message d'erreur
  //On récupère le nom du bar tapé dans la barre de recherche
  let barName = document.getElementById('searchBar').value;
  console.log(barName);
  if(barName == ''){
    return;
  }
  //Envoi de la requête au serveur
  const xhr = new XMLHttpRequest();
  xhr.open('POST', 'http://localhost:3000/scrapping/search', true);
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.send(JSON.stringify({
    "barName": barName
  }));

  //Réception de la réponse du serveur
  xhr.onloadend = function () {
    try {
      let bar = JSON.parse(xhr.responseText);
      window.location.href = "bar.html?id=" + bar.id;
    }
    catch (e) {
      document.getElementById('error').innerHTML = '<p>Aucun bar trouvé</p>';
    }
  };

}

navigator.geolocation.getCurrentPosition(coordonnees);

