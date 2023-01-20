import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { hash, compare } from 'bcrypt';
import { User } from 'src/users/entities/user.entity';
import { Repository } from 'typeorm';
import { LoginAuthDto } from './dto/login-auth.dto';
import { RegisterAuthDto } from './dto/register-auth.dto';

@Injectable()
export class AuthService {

  constructor(
    @InjectRepository(User) private userRepository: Repository<User>,
    private jwtAuthService:JwtService
  ){}

  public async register(userBody: RegisterAuthDto){
    const {password, ...user} = userBody;
    const plainToHash = await hash(password, 10);
    userBody = {...userBody, password:plainToHash};
    return this.userRepository.save(userBody);

  }

  public async login (userObjectLogin:LoginAuthDto){
    const {email, password} = userObjectLogin;
    const findUser = await this.userRepository.findOne({where:{email}})
    if (!findUser) throw new HttpException('USER_NOT_FOUND', HttpStatus.NOT_FOUND);
    const checkPassword = await compare(password, (await findUser).password);
    if (!checkPassword) throw new HttpException('PASSWORD_INCORRECT', HttpStatus.FORBIDDEN);


    const payload = {id:findUser.id, name:findUser.name}
    const token = await this.jwtAuthService.sign(payload);

    const dataUser = {
      user:findUser,
      token,

    }

    return dataUser;
  }

}
