import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable } from '@nestjs/common';
import { jwtConstants } from './constants';

interface PayloadProps {
  sub: string;
  email: string;
<<<<<<< HEAD
  roles: string[];
  permissions: string[];
=======
>>>>>>> 8a92927b268ada7b14101e1c4b3f59ca279180ca
}

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: jwtConstants.secret,
    });
  }

  async validate(payload: PayloadProps) {
<<<<<<< HEAD
    return {
      userId: payload.sub,
      email: payload.email,
      roles: payload.roles,
      permissions: payload.permissions,
    };
=======
    return { userId: payload.sub, email: payload.email };
>>>>>>> 8a92927b268ada7b14101e1c4b3f59ca279180ca
  }
}
