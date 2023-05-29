import { Injectable, Inject } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from './users.entity';

@Injectable()
export class UsersService {

    constructor(@InjectRepository(User) private userRepository: Repository<User>) { 
    }

    async login(email: string, password: string): Promise<any> {
        let user= await this.userRepository.findOne({where: {email: email, password: password}});
        if(user){
            return user;
        }
        else{
            return 'false';
        }
    }

    async getAll(): Promise<User[]> {
        return await this.userRepository.find();
    }

    async create(name: string, surname: string, email: string, password: string): Promise<User> {
        return await this.userRepository.save({name: name, surname: surname, email: email, password: password});
    }

    async get(id: number): Promise<User> {
        return await this.userRepository.findOne({where : {id: id}});
    }

    async update(id: string, name: string, surname: string): Promise<User> {
        //Convertir id en number
        let test = Number(id);
        let user = await this.userRepository.findOne({where : {id: test}});
        user.name = name;
        user.surname = surname;
        return await this.userRepository.save(user);
    }
}
