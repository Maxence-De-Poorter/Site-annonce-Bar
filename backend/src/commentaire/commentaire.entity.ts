import {Column, Entity, PrimaryGeneratedColumn} from 'typeorm';

@Entity()
export class Commentaire {
 
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    barName: string;

    @Column()
    userName: string;

    @Column()
    userEmail: string;

    @Column()
    commentaire: string;

    @Column()
    note: string;

    @Column()
    date: string;
} 