import { Injectable, NotFoundException } from '@nestjs/common'; // Import NotFoundException
import { SupabaseService } from '../../supabase/supabase.service';
import { UpdateProfileDto } from './dto/update-profile.dto';

@Injectable()
export class ProfileService {
  constructor(private readonly supabaseService: SupabaseService) {}

  async getUserProfile(userId: string) {
    const { data, error } = await this.supabaseService.client
      .from('users')
      .select('id, email, full_name, user_name')
      .eq('id', userId)
      .single();

    if (error) {
      throw new NotFoundException(`Profile not found for user ID: ${userId}`);
    }

    return data;
  }

  async updateUserProfile(userId: string, updateProfileDto: UpdateProfileDto) {
    // Prepare the update object
    const updateData: { [key: string]: any } = {};

    // Only include fields that are present in updateProfileDto and not null or undefined
    if (updateProfileDto.full_name !== undefined) {
      updateData.full_name = updateProfileDto.full_name;
    }
    if (updateProfileDto.user_name !== undefined) {
      updateData.user_name = updateProfileDto.user_name;
    }

    // Check if there's anything to update
    if (Object.keys(updateData).length === 0) {
      return { message: 'No fields to update.' };
    }

    // Update user profile in Supabase
    const { error } = await this.supabaseService.client
      .from('users')
      .update(updateData)
      .eq('id', userId);

    if (error) {
      throw new Error(`Error updating profile: ${error.message}`);
    }

    return { message: 'Profile updated successfully.' };
  }
}
