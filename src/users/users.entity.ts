import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
} from 'typeorm';

@Entity('users')
export class Users {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  email: string;

  @Column({ name: 'password' })
  password: string;

  @Column({ name: 'fullname', nullable: true }) // Full name, optional
  fullName: string;

  @Column({ name: 'username', nullable: true }) // User name, optional
  userName: string;
}
