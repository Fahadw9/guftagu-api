import { Module } from '@nestjs/common';
import { ProfileController } from './profile.controller'; // Adjust the import path as necessary
import { ProfileService } from './profile.service'; // Adjust the import path as necessary
import { ConfigModule } from '@nestjs/config';
import { SupabaseService } from 'supabase/supabase.service';

@Module({
  imports: [ConfigModule],
  controllers: [ProfileController],
  providers: [ProfileService, SupabaseService],
  exports: [ProfileService, SupabaseService], // Export the service if it needs to be used in other modules
})
export class ProfileModule {}
