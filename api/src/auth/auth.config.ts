import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AuthConfig {

  private COGNITO_USER_POOL_ID;
  private COGNITO_CLIENT_ID;
  private COGNITO_REGION;

  constructor(private configService: ConfigService) {
    this.COGNITO_USER_POOL_ID = this.configService.get('AUTH0_AUDIENCE') ?? '';
    this.COGNITO_CLIENT_ID = this.configService.get('AUTH0_DOMAIN') ?? '';
    this.COGNITO_REGION = this.configService.get('COGNITO_REGION') ?? '';
  }
  
  public userPoolId: string = process.env.COGNITO_USER_POOL_ID;
  public clientId: string = process.env.COGNITO_CLIENT_ID;
  public region: string = process.env.COGNITO_REGION;
  public authority = `https://cognito-idp.${process.env.COGNITO_REGION}.amazonaws.com/${process.env.COGNITO_USER_POOL_ID}`;
}
