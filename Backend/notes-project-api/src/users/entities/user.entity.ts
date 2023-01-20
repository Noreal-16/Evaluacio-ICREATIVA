import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity()
export class User {

    @PrimaryGeneratedColumn()
    id:number;

    @Column()
    name:string;
    @Column()
    email:string;
    @Column()
    password:string;
    
    @Column({ type: 'timestamp' })
    date_creation:Date;
    @Column({ type: 'timestamp' })
    date_update:Date; 
}
