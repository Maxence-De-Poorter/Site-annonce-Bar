import { Module } from '@nestjs/common';
import { ScrappingController } from './scrapping.controller';
import { ScrappingService } from './scrapping.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Scrapping } from './scrapping.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Scrapping])],
  controllers: [ScrappingController],
  providers: [ScrappingService]
})
export class ScrappingModule {}
