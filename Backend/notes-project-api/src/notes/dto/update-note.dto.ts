import { PartialType } from '@nestjs/mapped-types';
import { CreateNoteDto } from './create-note.dto';

export class UpdateNoteDto extends PartialType(CreateNoteDto) {
    description:string;
    completed:boolean;
    active:boolean;
}
