import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { SupabaseService } from '../supabase/supabase.service';
import { AppService } from './app.service'; // Import AppService
import { AppController } from './app.controller'; // Import AppController
import { TypeOrmModule } from '@nestjs/typeorm';
import { Users } from './users/users.entity';
import { ProfileController } from './profile/profile.controller';
import { ProfileService } from './profile/profile.service';
import { UsersService } from './users/users.service';
import { UsersModule } from './users/users.module';
import { ProfileModule } from './profile/profile.module';
import { UsersController } from './users/users.controller';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true, // Makes config available across all modules
    }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST,
      port: +process.env.DB_PORT,
      username: process.env.DB_USERNAME,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_DATABASE,
      entities: [Users],
      synchronize: false, // Note: Set to false in production
    }),
    AuthModule,
    UsersModule,
    ProfileModule,
  ],
  providers: [AppService, SupabaseService, ProfileService, UsersService], // Include AppService here
  controllers: [AppController, ProfileController, UsersController], // Include AppController here
})
export class AppModule {}
