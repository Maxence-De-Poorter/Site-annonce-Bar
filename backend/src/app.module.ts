import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ScrappingModule } from './scrapping/scrapping.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Scrapping } from './scrapping/scrapping.entity';
import { UsersModule } from './users/users.module';
import { CommentaireModule } from './commentaire/commentaire.module';

@Module({
  imports: [ScrappingModule, TypeOrmModule.forRoot({
    "type": "mysql",
    "host": "localhost",
    "port": 3306,
    "username": "root",
    "password": "root",
    "database": "siteannoncebar",
    "synchronize": false,
    "entities": [Scrapping, "dist/**/*.entity{.ts,.js}"]
}), UsersModule, CommentaireModule], 
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
