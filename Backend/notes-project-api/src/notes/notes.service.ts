import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateNoteDto } from './dto/create-note.dto';
import { UpdateNoteDto } from './dto/update-note.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Note } from './entities/note.entity';

@Injectable()
export class NotesService {

  constructor(
    @InjectRepository(Note) private noteRepository: Repository<Note>
  ){}

  async create(createNoteDto: CreateNoteDto){
    const newNote = this.noteRepository.create(createNoteDto);
    return this.noteRepository.save(newNote);
  }

  findAll() {
    return this.noteRepository.find();
  }

  findOne(id: number) {
    return this.noteRepository.findOne({
      where:{
        id:id
      }
    });
  }

  async update(id: number, updateNoteDto: UpdateNoteDto) {
    const notes = await this.noteRepository.findOne({
      where:{
        id:id
      }
    });
    this.noteRepository.merge(notes, updateNoteDto);
    return this.noteRepository.save(notes);
  }

  async remove(id: number) {
    const data = await this.noteRepository.findOne({where:{id}});
    if(!data) throw new HttpException('USER_NOT_FOUND', HttpStatus.NOT_FOUND);
    data.active = false;
    this.noteRepository.save(data);
    return data.active;
  }

  
}
