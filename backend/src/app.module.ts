import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { BarModule } from './bar/bar.module';

@Module({
  imports: [BarModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
