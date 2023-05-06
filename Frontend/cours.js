function coordonnees(pos) {
    //Liste de 3 bars
    let bars = [
        {
            name: "Le point de départ",
            adresse: "48 Rue Solférino, 59000 Lille",
            image: "PDD.jpg",
            latitude: 50.634885,
            longitude: 3.04754
        },
        {
            name: "Tcha Tcha",
            adresse:"136 Rue Solférino, 59000 Lille",
            image: "TchaTcha.jpg",
            latitude: 50.631783,
            longitude: 3.053504
        },
        {
            name: "Delirium",
            adresse:"50 Rue Masséna, 59000 Lille",
            image: "Delirium.jpg",
            latitude:  50.632437,
            longitude: 3.054805
        },
        {
            name: "Le solférino",
            adresse: "156 Rue Solférino, 59000 Lille",
            image: "LeSolfe.jpg",
            latitude: 50.631181,
            longitude: 3.054603
        }
    ];

    //On récupère les coordonnées de l'utilisateur
    let crd = pos.coords;
    let latitude = crd.latitude;
    let longitude = crd.longitude;

    //On calcule la distance entre l'utilisateur et les bars
    for (let i = 0; i < bars.length; i++) {
        let distance = Math.sqrt(Math.pow(latitude - bars[i].latitude, 2) + Math.pow(longitude - bars[i].longitude, 2));
        //passer la distance en mètre
        distance = distance * 10000;
        bars[i].distance = distance;

    }

    //On trie les bars par distance
    bars.sort(function (a, b) {
        return a.distance - b.distance;
    }
    );

    //On affiche les 3 bars les plus proches
    for (let i = 0; i < 3; i++) {
        document.getElementById('i' + (i+1)).src = bars[i].image;
        document.getElementById('p' + (i+1)).innerHTML = bars[i].name;
        document.getElementById('a' + (i+1)).innerHTML = bars[i].adresse;
        document.getElementById('d' + (i+1)).innerHTML = bars[i].distance.toFixed(0) + ' mètres ';
        console.log(bars)
    }
}

navigator.geolocation.getCurrentPosition(coordonnees);