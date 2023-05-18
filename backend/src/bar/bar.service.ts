import { Injectable } from '@nestjs/common';

@Injectable()
export class BarService {

    //Constructeur
    constructor( ) { }

    //Liste de 3 bars
    bars = [
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

    //Fonction qui renvoie les bars les plus proches en fonction de la position de l'utilisateur
    async getNearestBars(latitude: number, longitude: number): Promise<any> {
        //On récupère la liste des bars
        let bars = this.bars;

        //On crée une liste vide qui contiendra les bars les plus proches
        let nearestBars = [];

        //On parcourt la liste des bars
        for (let i = 0; i < bars.length; i++) {
            //On calcule la distance entre le bar et l'utilisateur
            let distance = Math.sqrt(Math.pow(latitude - bars[i].latitude, 2) + Math.pow(longitude - bars[i].longitude, 2));
            //On ajoute le bar à la liste des bars les plus proches avec la distance si la distance est inférieure à 1km
            if (distance < 1000) {
                nearestBars.push({ bar: bars[i], distance: distance });
            }
        }

        //On trie les bars par distance
        nearestBars.sort(function (a, b) {
            return a.distance - b.distance;
        }
        );
 
        //On renvoie la liste des bars les plus proches
        return nearestBars;
    }
}
