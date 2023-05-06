import { Injectable } from '@nestjs/common';

@Injectable()
export class BarService {

    //Constructeur
    constructor() { }

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
}
