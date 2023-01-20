import { type } from "os";
import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";


@Entity()
export class Note {

    @PrimaryGeneratedColumn()
    id:number;

    @Column()
    description:string;
    @Column({default: false})
    completed:boolean;
    @Column({default:true})
    active:boolean;
    @Column({ type: 'timestamp' })
    date_creation:Date;
    @Column({ type: 'timestamp' })
    date_update:Date;

}
