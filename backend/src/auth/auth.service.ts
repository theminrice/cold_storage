import {
  BadRequestException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';

type LoginBody = {
  email: string;
  password: string;
};

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async login(body: LoginBody) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const passwordRegex = /^.{6,}$/;

    if (!body.email || !emailRegex.test(body.email)) {
      throw new BadRequestException('Format email tidak valid');
    }

    if (!body.password || !passwordRegex.test(body.password)) {
      throw new BadRequestException('Password minimal 6 karakter');
    }

    const user = await this.prisma.users_auth.findUnique({
      where: {
        email: body.email,
      },
      select: {
        auth_id: true,
        user_id: true,
        email: true,
        password: true,
        users_profile: {
          select: {
            username: true,
            role: true,
            phone: true,
            photo: true,
            storage_id: true,
          },
        },
      },
    });

    if (!user) {
      throw new UnauthorizedException('Email atau password salah');
    }

    if (user.password !== body.password) {
      throw new UnauthorizedException('Email atau password salah');
    }

    const payload = {
      auth_id: user.auth_id,
      user_id: user.user_id,
      email: user.email,
      username: user.users_profile.username,
      role: user.users_profile.role,
      storage_id: user.users_profile.storage_id,
    };

    const token = await this.jwtService.signAsync(payload);

    return {
      message: 'Login berhasil',
      token,
      data: {
        auth_id: user.auth_id,
        user_id: user.user_id,
        email: user.email,
        profile: user.users_profile,
      },
    };
  }
}