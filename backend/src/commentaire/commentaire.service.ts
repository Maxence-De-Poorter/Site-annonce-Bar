import { Injectable, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Commentaire } from './commentaire.entity';

@Injectable()
export class CommentaireService {

    constructor(@InjectRepository(Commentaire) private commentaireRepository: Repository<Commentaire>) {}

    async getAll(barName: string): Promise<Commentaire[]> {
        return await this.commentaireRepository.find({where: {barName: barName}});
    }

    async getByUser(userEmail: string): Promise<Commentaire[]> {
        return await this.commentaireRepository.find({where: {userEmail: userEmail}});
    }

    async create(barName: string, userName: string, userEmail: string, commentaire: string, note: string, date: string): Promise<Commentaire> {
        return await this.commentaireRepository.save({barName: barName, userName: userName, userEmail: userEmail, commentaire: commentaire, note: note, date: date});
    }
}
