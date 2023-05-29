import { Controller, Post, Body, Get} from '@nestjs/common';
import { UsersService } from './users.service';
import { User } from './users.entity';

@Controller('users')
export class UsersController {

constructor(private UsersService: UsersService) { }

    @Post('login')
    login(
        @Body('name') email: string,
        @Body('password') password: string
        ): Promise<any> {
        return this.UsersService.login(email, password);
    }

    @Post('get')
    get(
        @Body('id') id: number
        ): Promise<User> {
        return this.UsersService.get(id);
    }

    @Post('update')
    update(
        @Body('id') id: string,
        @Body('name') name: string,
        @Body('surname') surname: string
        ): Promise<User> {
        return this.UsersService.update(id, name, surname);
    }







    @Get('all')
    getAll(): Promise<User[]> {
        return this.UsersService.getAll();
    }

    @Post('create')
    create(
        @Body('name') name: string,
        @Body('surname') surname: string,
        @Body('email') email: string,
        @Body('password') password: string
        ): Promise<User> {
        return this.UsersService.create(name, surname, email, password);
        }
}

