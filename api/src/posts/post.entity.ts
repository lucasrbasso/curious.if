import {
    Entity,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    Column,
} from 'typeorm';
  
@Entity('Post')
export class Post {
    @PrimaryGeneratedColumn()
    id: string;
  
    @CreateDateColumn()
    createdDate: Date;
  
    @Column({ length: 512 })
    text: string;
}