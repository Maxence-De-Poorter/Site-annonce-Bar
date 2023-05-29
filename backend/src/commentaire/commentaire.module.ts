import { Module } from '@nestjs/common';
import { CommentaireService } from './commentaire.service';
import { CommentaireController } from './commentaire.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Commentaire } from './commentaire.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Commentaire])],
  providers: [CommentaireService],
  controllers: [CommentaireController]
})
export class CommentaireModule {}
