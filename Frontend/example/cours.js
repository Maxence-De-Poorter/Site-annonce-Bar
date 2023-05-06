function coordonnees(pos) {
    //Liste de 3 bars
    let bars = [
        {
            name: "Le point de départ",
            latitude: 50.634885,
            longitude: 3.04754
        },
        {
            name: "Tcha Tcha",
            latitude: 50.631783,
            longitude: 3.053504
        },
        {
            name: "Delirium",
            latitude:  50.632437,
            longitude: 3.054805
        }
    ];

    //On récupère les coordonnées de l'utilisateur
    let crd = pos.coords;
    let latitude = crd.latitude;
    let longitude = crd.longitude;
    document.getElementById('p1').innerHTML= "Latitude de l'utilisateur: " + latitude.toFixed(2);
    document.getElementById('p2').innerHTML= "Longitude de l'utilisateur: " + longitude.toFixed(2);

    //On calcule la distance entre l'utilisateur et les bars
    for (let i = 0; i < 3; i++) {
        let distance = Math.sqrt(Math.pow(latitude - bars[i].latitude, 2) + Math.pow(longitude - bars[i].longitude, 2));
        bars[i].distance = distance;

    }

    //On trie les bars par distance
    bars.sort(function (a, b) {
        return a.distance - b.distance;
    }
    );

    //On affiche les 3 bars les plus proches
    for (let i = 0; i < 3; i++) {
        document.getElementById('p' + (i + 3)).innerHTML = bars[i].name + ' à ' + bars[i].distance.toFixed(2) + ' km';
        console.log(bars)
    }















}

navigator.geolocation.getCurrentPosition(coordonnees);