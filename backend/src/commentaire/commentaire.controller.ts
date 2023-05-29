import { Body, Controller, Post } from '@nestjs/common';
import { CommentaireService } from './commentaire.service';
import { Commentaire } from './commentaire.entity';

@Controller('commentaire')
export class CommentaireController {

    constructor(private commentaireService: CommentaireService) { }

    @Post('getAll')
    getAll(
        @Body('barName') barName: string,
        ): Promise<Commentaire[]> {
        return this.commentaireService.getAll(barName);
    }

    @Post('getByUser')
    getByUser(
        @Body('userEmail') userEmail: string,
        ): Promise<Commentaire[]> {
        return this.commentaireService.getByUser(userEmail);
    }

    @Post('create')
    create(
        @Body('barName') barName: string,
        @Body('userName') userNale: string,
        @Body('userEmail') userEmail: string,
        @Body('commentaire') commentaire: string,
        @Body('note') note: string,
        @Body('date') date: string,
        ): Promise<Commentaire> {
        return this.commentaireService.create(barName, userNale, userEmail, commentaire, note, date);
    }
}
