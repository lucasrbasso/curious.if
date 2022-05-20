import {
  Injectable,
  CanActivate,
  ExecutionContext,
  ForbiddenException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Permission } from './permission.enum';
import { PERMISSIONS_KEY } from './permissions.decorator';

@Injectable()
export class PermissionsGuard implements CanActivate {
  constructor(private reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredPermissions = this.reflector.getAllAndOverride<Permission[]>(
      PERMISSIONS_KEY,
      [context.getHandler(), context.getClass()],
    );

    if (!requiredPermissions) {
      throw new ForbiddenException('Not enough access permission!');
    }
    const request = context.switchToHttp().getRequest();

    if (
      !requiredPermissions.some((permission) =>
        request.user.permissions?.includes(permission),
      )
    ) {
      throw new ForbiddenException('Not enough access permission!');
    }

    return true;
  }
}
