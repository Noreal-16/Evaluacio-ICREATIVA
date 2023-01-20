import { IsBoolean, IsNotEmpty } from "class-validator";

export class CreateNoteDto {
    @IsNotEmpty()
    description:string;
}
