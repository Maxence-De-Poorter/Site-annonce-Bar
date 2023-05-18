import {Column, Entity, PrimaryGeneratedColumn} from 'typeorm';

@Entity()
export class Scrapping {
 
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    name: string;

    @Column()
    adresse: string;

    @Column()
    description: string;

    @Column()
    horaire: string;

    @Column()
    telephone: string;

    @Column()
    image: string;

    @Column('decimal', { precision: 7, scale: 15, nullable: true })
    latitude: number

    @Column('decimal', { precision: 7, scale: 15, nullable: true })
    longitude: number
} 