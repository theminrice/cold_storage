import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class StoragesService {
    constructor(private readonly prisma: PrismaService) { }

    async findAll() {
        const storages = await this.prisma.storage.findMany({
            select: {
                storage_id: true,
                name_storage: true,
                address_storage: true,
            },
            orderBy: {
                storage_id: 'asc',
            },
        });

        return {
            message: 'Data storages berhasil diambil',
            data: storages,
        };
    }

    async findOne(id: number) {
        const storage = await this.prisma.storage.findUnique({
            where: {
                storage_id: id,
            },
            select: {
                storage_id: true,
                name_storage: true,
                address_storage: true,
            },
        });

        if (!storage) {
            throw new NotFoundException('Data storage tidak ditemukan');
        }

        return {
            message: 'Detail storage berhasil diambil',
            data: storage,
        };
    }
}