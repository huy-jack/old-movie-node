import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './modules/auth/auth.module';
import { UserModule } from './modules/user/user.module';
import { PrismaModule } from './prisma/prisma.module';
import { UserController } from './modules/user/user.controller';
import { MovieModule } from './modules/movie/movie.module';
import { BannerModule } from './modules/banner/banner.module';
import { ShowtimeModule } from './modules/showtime/showtime.module';
import { SeatModule } from './modules/seat/seat.module';
import { BookingModule } from './modules/booking/booking.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    AuthModule,
    UserModule,
    PrismaModule,
    MovieModule,
    BannerModule,
    ShowtimeModule,
    SeatModule,
    BookingModule,
  ],
  controllers: [UserController],
  providers: [],
})
export class AppModule {}
