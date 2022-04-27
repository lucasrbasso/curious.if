export class GetUserDTO {
  id: string;
  name: string;
  email: string;
  permissions: string[];
  roles: string[];
  createdAt: Date;
  updatedAt: Date;
}
