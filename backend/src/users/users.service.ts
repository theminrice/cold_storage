import {
    ConflictException,
    Injectable,
    NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

type CreateUserBody = {
    storage_id: number;
    username: string;
    role: string;
    email: string;
    password: string;
    phone?: string | null;
    photo?: string | null;
};

type UpdateUserBody = {
    storage_id?: number;
    username?: string;
    role?: string;
    email?: string;
    password?: string;
    phone?: string | null;
    photo?: string | null;
};

@Injectable()
export class UsersService {
    constructor(private readonly prisma: PrismaService) { }

    async findAll() {
        const users = await this.prisma.users_auth.findMany({
            select: {
                auth_id: true,
                user_id: true,
                email: true,
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
            orderBy: {
                auth_id: 'asc',
            },
        });

        return {
            message: 'Data users berhasil diambil',
            data: users,
        };
    }

    async findOne(id: number) {
        const user = await this.prisma.users_auth.findUnique({
            where: {
                auth_id: id,
            },
            select: {
                auth_id: true,
                user_id: true,
                email: true,
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
            throw new NotFoundException('Data user tidak ditemukan');
        }

        return {
            message: 'Detail user berhasil diambil',
            data: user,
        };
    }

    async create(body: CreateUserBody) {
        const storage = await this.prisma.storage.findUnique({
            where: {
                storage_id: body.storage_id,
            },
            select: {
                storage_id: true,
            },
        });

        if (!storage) {
            throw new NotFoundException('Storage tidak ditemukan');
        }

        const existingEmail = await this.prisma.users_auth.findUnique({
            where: {
                email: body.email,
            },
            select: {
                auth_id: true,
            },
        });

        if (existingEmail) {
            throw new ConflictException('Email sudah digunakan');
        }

        const user = await this.prisma.$transaction(async (tx) => {
            const profile = await tx.users_profile.create({
                data: {
                    storage_id: body.storage_id,
                    username: body.username,
                    role: body.role,
                    phone: body.phone ?? null,
                    photo: body.photo ?? null,
                },
            });

            const auth = await tx.users_auth.create({
                data: {
                    user_id: profile.user_id,
                    email: body.email,
                    password: body.password,
                },
                select: {
                    auth_id: true,
                    user_id: true,
                    email: true,
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

            return auth;
        });

        return {
            message: 'Data user berhasil ditambahkan',
            data: user,
        };
    }

    async update(id: number, body: UpdateUserBody) {
        const currentUser = await this.prisma.users_auth.findUnique({
            where: {
                auth_id: id,
            },
            select: {
                auth_id: true,
                user_id: true,
            },
        });

        if (!currentUser) {
            throw new NotFoundException('Data user tidak ditemukan');
        }

        if (body.storage_id !== undefined) {
            const storage = await this.prisma.storage.findUnique({
                where: {
                    storage_id: body.storage_id,
                },
                select: {
                    storage_id: true,
                },
            });

            if (!storage) {
                throw new NotFoundException('Storage tidak ditemukan');
            }
        }

        if (body.email !== undefined) {
            const existingEmail = await this.prisma.users_auth.findUnique({
                where: {
                    email: body.email,
                },
                select: {
                    auth_id: true,
                },
            });

            if (existingEmail && existingEmail.auth_id !== id) {
                throw new ConflictException('Email sudah digunakan');
            }
        }

        const updatedUser = await this.prisma.$transaction(async (tx) => {
            await tx.users_profile.update({
                where: {
                    user_id: currentUser.user_id,
                },
                data: {
                    storage_id: body.storage_id,
                    username: body.username,
                    role: body.role,
                    phone: body.phone,
                    photo: body.photo,
                },
            });

            if (body.email !== undefined || body.password !== undefined) {
                await tx.users_auth.update({
                    where: {
                        auth_id: id,
                    },
                    data: {
                        email: body.email,
                        password: body.password,
                    },
                });
            }

            const user = await tx.users_auth.findUnique({
                where: {
                    auth_id: id,
                },
                select: {
                    auth_id: true,
                    user_id: true,
                    email: true,
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

            return user;
        });

        return {
            message: 'Data user berhasil diupdate',
            data: updatedUser,
        };
    }

    async remove(id: number) {
        const currentUser = await this.prisma.users_auth.findUnique({
            where: {
                auth_id: id,
            },
            select: {
                auth_id: true,
                user_id: true,
                email: true,
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

        if (!currentUser) {
            throw new NotFoundException('Data user tidak ditemukan');
        }

        const transactionCount = await this.prisma.transactions.count({
            where: {
                user_id: currentUser.user_id,
            },
        });

        if (transactionCount > 0) {
            throw new ConflictException(
                'User tidak bisa dihapus karena sudah memiliki transaksi',
            );
        }

        await this.prisma.users_profile.delete({
            where: {
                user_id: currentUser.user_id,
            },
        });

        return {
            message: 'Data user berhasil dihapus',
            data: currentUser,
        };
    }
}