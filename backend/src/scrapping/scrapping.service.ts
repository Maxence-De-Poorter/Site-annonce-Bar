import { Injectable, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Scrapping } from './scrapping.entity';

@Injectable()
export class ScrappingService {

    constructor(@InjectRepository(Scrapping) private scrappingRepository: Repository<Scrapping>) { 
    }

    //On récupère l'annonce correspondant à l'id passé en paramètre
    async getOne(id: number): Promise<Scrapping> {
        return await this.scrappingRepository.findOne({where : {id : id}});
    }

    async getAll(latitude: number, longitude: number, page: number, resultsPerPage: number, sortBy: string): Promise<Scrapping[]> {
        //On récupère la liste des bars
        let bars = await this.scrappingRepository.find();
        //On initialise la liste des bars les plus proches
        let nearestBars = [];

        //On parcourt la liste des bars
        for (let i = 0; i < bars.length; i++) {
            //Si le bar n'a pas de coordonnées, on passe au bar suivant
            if (bars[i].latitude != null || bars[i].longitude != null) {
            //On calcule la distance entre le bar et la position de l'utilisateur
            const R = 6371; // Rayon moyen de la Terre en kilomètres

            // Conversion des degrés en radians
            const radLat1 = latitude * (Math.PI / 180);
            const radLong1 = longitude * (Math.PI / 180);
            const radLat2 = bars[i].latitude * (Math.PI / 180);
            const radLong2 = bars[i].longitude * (Math.PI / 180);
          
            // Calcul des différences de latitude et de longitude
            const deltaLat = radLat2 - radLat1;
            const deltaLong = radLong2 - radLong1;
          
            // Calcul de la distance haversine
            const a = Math.sin(deltaLat / 2) ** 2 + Math.cos(radLat1) * Math.cos(radLat2) * Math.sin(deltaLong / 2) ** 2;
            const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            const distance = R * c*100;
            nearestBars.push({ bar: bars[i], distance: distance.toFixed(0) });
            console.log(bars[i].name, distance.toFixed(0));
            }
        }

        console.log(latitude, longitude);

        //sortBy
        if (sortBy == "distance") {
            //On trie les bars par distance
            nearestBars.sort(function (a, b) {
                return a.distance - b.distance;
            }
            );
        }
        else if (sortBy == "name") {
            //On trie les bars par nom
            nearestBars.sort(function (a, b) {
                if (a.bar.name < b.bar.name) { return -1; }
                if (a.bar.name > b.bar.name) { return 1; }
                return 0;
            }
            );

        }

        //On renvoie la liste des bars les plus proches
        return nearestBars.slice((page-1)*resultsPerPage, page*resultsPerPage);
    }

    async get(latitude: number, longitude: number): Promise<Scrapping[]> {
        //On récupère la liste des bars
        let bars = await this.scrappingRepository.find();
        //On initialise la liste des bars les plus proches
        let nearestBars = [];

        //On parcourt la liste des bars
        for (let i = 0; i < bars.length; i++) {
            //Si le bar n'a pas de coordonnées, on passe au bar suivant
            if (bars[i].latitude != null || bars[i].longitude != null) {
            //On calcule la distance entre le bar et la position de l'utilisateur
            const R = 6371; // Rayon moyen de la Terre en kilomètres

            // Conversion des degrés en radians
            const radLat1 = latitude * (Math.PI / 180);
            const radLong1 = longitude * (Math.PI / 180);
            const radLat2 = bars[i].latitude * (Math.PI / 180);
            const radLong2 = bars[i].longitude * (Math.PI / 180);
          
            // Calcul des différences de latitude et de longitude
            const deltaLat = radLat2 - radLat1;
            const deltaLong = radLong2 - radLong1;
          
            // Calcul de la distance haversine
            const a = Math.sin(deltaLat / 2) ** 2 + Math.cos(radLat1) * Math.cos(radLat2) * Math.sin(deltaLong / 2) ** 2;
            const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            const distance = R * c*100;
            nearestBars.push({ bar: bars[i], distance: distance.toFixed(0) });
            console.log(bars[i].name, distance.toFixed(0));
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



    async getNearestBars(latitude: number, longitude: number): Promise<any> {
         //On récupère la liste des bars
            let bars = await this.scrappingRepository.find();
            //On initialise la liste des bars les plus proches
            let nearestBars = [];
            //On initialise le compteur de kilomètres
            let mètre = 50;

        //Tant qu'il n'y a pas au moins 5 bars dans la liste des bars les plus proches
        while (nearestBars.length < 5) {
            //On parcourt la liste des bars
            for (let i = 0; i < bars.length; i++) {
                //Si le bar n'a pas de coordonnées, on passe au bar suivant
                if (bars[i].latitude != null || bars[i].longitude != null) {
                //On calcule la distance entre le bar et la position de l'utilisateur
                const R = 6371; // Rayon moyen de la Terre en kilomètres

                // Conversion des degrés en radians
                const radLat1 = latitude * (Math.PI / 180);
                const radLong1 = longitude * (Math.PI / 180);
                const radLat2 = bars[i].latitude * (Math.PI / 180);
                const radLong2 = bars[i].longitude * (Math.PI / 180);
              
                // Calcul des différences de latitude et de longitude
                const deltaLat = radLat2 - radLat1;
                const deltaLong = radLong2 - radLong1;
              
                // Calcul de la distance haversine
                const a = Math.sin(deltaLat / 2) ** 2 + Math.cos(radLat1) * Math.cos(radLat2) * Math.sin(deltaLong / 2) ** 2;
                const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
                const distance = R * c*100;
                if (distance < mètre) {
                    //Vérifie que le bar n'est pas déjà dans la liste des bars les plus proches
                    let alreadyIn = false;
                    for (let j = 0; j < nearestBars.length; j++) {
                        if (nearestBars[j].bar.id == bars[i].id) {
                            alreadyIn = true;
                        }
                    }
                    if (!alreadyIn) {
                        nearestBars.push({ bar: bars[i], distance: distance.toFixed(0) });
                        console.log(bars[i].name, distance.toFixed(0));
                    }
                }
                }
            }
            mètre = mètre + 50;
        }
  
         //On trie les bars par distance
         nearestBars.sort(function (a, b) {
             return a.distance - b.distance;
         }
         );
         //On renvoie la liste des bars les plus proches
         return nearestBars;
        }
    
        async search(search: string): Promise<Scrapping[]> {
            //Cette fonction renvoi le bar correspondant à la recherche
            //Si le bar existe, on renvoie le bar
            //Sinon, on renvoie null

            //On récupère la liste des bars
            let bars = await this.scrappingRepository.find();
            //On initialise le bar
            let bar = null;

            //On parcourt la liste des bars
            for (let i = 0; i < bars.length; i++) {
                //On vérifie si le nom du bar correspond à la recherche
                if (bars[i].name.toLowerCase().includes(search.toLowerCase())) {
                    bar = bars[i];
                }
            }

            //On renvoie le bar
            return bar;
        }

} 