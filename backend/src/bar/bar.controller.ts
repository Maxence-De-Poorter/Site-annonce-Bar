import { Body, Controller, Get} from '@nestjs/common';
import { BarService } from './bar.service';

@Controller('bar')
export class BarController {

    constructor(private readonly BarService: BarService) { }

    //Fonction qui renvoie les bars les plus proches en fonction de la position de l'utilisateur
    @Get('nearest')
    @Body('longitude')
    @Body('latitude')
    getNearestBars(): Promise<any> {
        return this.BarService.getNearestBars();
    }

}
