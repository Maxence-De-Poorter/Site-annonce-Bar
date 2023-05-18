import { Body, Controller, Get, Post} from '@nestjs/common';
import { BarService } from './bar.service';

@Controller('bar')
export class BarController {

    constructor(private readonly BarService: BarService) { }

    //Fonction qui renvoie les bars les plus proches en fonction de la position de l'utilisateur
    @Post('nearest')
    getNearestBars(
        @Body('latitude') latitude: number,
        @Body('longitude') longitude: number
        ):Promise<any> {
        return this.BarService.getNearestBars(latitude, longitude);
        }
}
