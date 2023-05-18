// Fonction pour récupérer les détails de l'annonce depuis l'API
function fetchAnnonceDetails() {
    const urlParams = new URLSearchParams(window.location.search);
    const annonceId = urlParams.get('id');
    const xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:3000/scrapping/getOne', true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({
        "id": annonceId
    }));
    xhr.onreadystatechange = function () {
        let bar = JSON.parse(xhr.responseText);
        console.log(bar);
        document.getElementById('barName').innerHTML = bar.name;
        document.getElementById('barAdresse').innerHTML = bar.adresse;
        document.getElementById('barImage').src = bar.image;
        document.getElementById('barDescription').innerHTML = bar.description;
        document.getElementById('barTelephone').innerHTML = bar.telephone;
        document.getElementById('barHoraire').innerHTML = bar.horaire;
    };
}

fetchAnnonceDetails();