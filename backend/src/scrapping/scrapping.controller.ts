import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { ScrappingService } from './scrapping.service';
import { Scrapping } from './scrapping.entity';

@Controller('scrapping')
export class ScrappingController {

    constructor(private service: ScrappingService) { }

    @Post('getOne')
    getOne(
        @Body('id') id: number
        ): Promise<Scrapping> {
        return this.service.getOne(id);
    }

    @Post('all')
    getAll(
        @Body('latitude') latitude: number ,
        @Body('longitude') longitude: number,
        @Body('page') page: number,
        @Body('resultsPerPage') resultsPerPage: number,
        @Body('sortBy') sortBy: string
        ): Promise<Scrapping[]> {
        return this.service.getAll(latitude, longitude, page, resultsPerPage, sortBy);
    }

    @Post('get')
    get(
        @Body('latitude') latitude: number ,
        @Body('longitude') longitude: number
        ): Promise<Scrapping[]> {
        return this.service.get(latitude, longitude);
    }

    //Fonction qui renvoi les bars les plus proches
    @Post('nearest')
    getNearestBars(
        @Body('latitude') latitude: number,
        @Body('longitude') longitude: number
        ):Promise<any> {
        return this.service.getNearestBars(latitude, longitude);
    }

    @Post('search')
    search(
        @Body('barName') barName: string
        ): Promise<Scrapping[]> {
        return this.service.search(barName);
    }
}
