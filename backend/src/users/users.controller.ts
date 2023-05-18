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
        ): Promise<User> {
        return this.UsersService.login(email, password);
    }

    @Get('all')
    getAll(): Promise<User[]> {
        return this.UsersService.getAll();
    }

}

