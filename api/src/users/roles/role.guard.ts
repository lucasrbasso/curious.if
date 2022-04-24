import {
  Injectable,
  CanActivate,
  ExecutionContext,
  ForbiddenException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Role } from './role.enum';
import { ROLES_KEY } from './roles.decorator';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (!requiredRoles) {
      throw new ForbiddenException('Not enough access role!');
    }
    const request = context.switchToHttp().getRequest();

    if (!requiredRoles.some((role) => request.user.roles?.includes(role))) {
      throw new ForbiddenException('Not enough access role!');
    }

    return true;
  }
}
