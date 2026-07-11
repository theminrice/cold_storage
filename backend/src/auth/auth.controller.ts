import { Body, Controller, Post, Res } from '@nestjs/common';
import type { Response } from 'express';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  async login(
    @Body()
    body: {
      email: string;
      password: string;
    },
    @Res({ passthrough: true }) response: Response,
  ) {
    const result = await this.authService.login(body);

    response.cookie('access_token', result.token, {
      httpOnly: true,
      sameSite: 'lax',
      secure: false,
      maxAge: 24 * 60 * 60 * 1000,
    });

    return {
      message: result.message,
      data: result.data,
    };
  }

  @Post('logout')
  logout(@Res({ passthrough: true }) response: Response) {
    response.clearCookie('access_token');

    return {
      message: 'Logout berhasil',
    };
  }
}