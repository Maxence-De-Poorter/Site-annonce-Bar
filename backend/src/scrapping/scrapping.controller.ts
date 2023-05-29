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

    @Post('search')
    search(
        @Body('barName') barName: string
        ): Promise<Scrapping[]> {
        return this.service.search(barName);
    }

    @Post('boisson')
    getBoisson(
        @Body('latitude') latitude: number ,
        @Body('longitude') longitude: number,
        @Body('page') page: number,
        @Body('resultsPerPage') resultsPerPage: number,
        @Body('sortBy') sortBy: string,
        @Body('boisson') boisson: string
        ): Promise<Scrapping[]> {
        return this.service.getBoisson(latitude, longitude, page, resultsPerPage, sortBy, boisson);
    }

    @Get('all')
    getAll2(): Promise<Scrapping[]> {
        return this.service.getAll2();
    }



    //Fonction qui renvoi les bars les plus proches
    @Post('nearest')
    getNearestBars(
        @Body('latitude') latitude: number,
        @Body('longitude') longitude: number
        ):Promise<any> {
        return this.service.getNearestBars(latitude, longitude);
    }

    @Post('getBoisson')
    getBoisson2(
        @Body('latitude') latitude: string,
        @Body('longitude') longitude: string,
        @Body('boisson') boisson: string
        ): Promise<Scrapping[]> {
        return this.service.getBoisson2(latitude, longitude, boisson);
    }

    @Post('getBars')
    get(
        @Body('latitude') latitude: number ,
        @Body('longitude') longitude: number
        ): Promise<Scrapping[]> {
        return this.service.get(latitude, longitude);
    }
}
