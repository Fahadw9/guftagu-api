// src/profile/profile.controller.ts

import {
  Controller,
  Get,
  UseGuards,
  Request,
  Put,
  UseInterceptors,
  UploadedFile,
  Body,
} from '@nestjs/common';
import { ProfileService } from './profile.service';
import { JwtAuthGuard } from '../auth/jwt-auth.guard'; // Adjust the path as needed
import { FileInterceptor } from '@nestjs/platform-express';
import { UpdateProfileDto } from './dto/update-profile.dto';
import * as Multer from 'multer';
@Controller('profile')
export class ProfileController {
  constructor(private readonly profileService: ProfileService) {}

  @UseGuards(JwtAuthGuard)
  @Get('myprofile')
  async getMyProfile(@Request() req) {
    const userId = req.user?.id?.trim();
    return this.profileService.getUserProfile(userId);
  }

  @UseGuards(JwtAuthGuard)
  @Put('update')
  async updateProfile(
    @Request() req,
    @Body() updateProfileDto: UpdateProfileDto,
  ) {
    const userId = req.user?.id?.trim();
    return this.profileService.updateUserProfile(userId, updateProfileDto);
  }
}
