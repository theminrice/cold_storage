import { Controller, Get, Param, ParseIntPipe } from '@nestjs/common';
import { StoragesService } from './storages.service';

@Controller('storages')
export class StoragesController {
  constructor(private readonly storagesService: StoragesService) {}

  @Get()
  findAll() {
    return this.storagesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.storagesService.findOne(id);
  }
}