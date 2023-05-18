import { Injectable, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './users.entity';

@Injectable()
export class UsersService {

    constructor(@InjectRepository(User) private userRepository: Repository<User>) { 
    }

    async login(email: string, password: string): Promise<User> {
        return await this.userRepository.findOne({where: {email: email, password: password}});
    }

    async getAll(): Promise<User[]> {
        return await this.userRepository.find();
    }
}
