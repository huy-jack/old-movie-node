-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL DEFAULT uuid_generate_v4(),
    "user_name" VARCHAR(50) NOT NULL,
    "email" VARCHAR(50) NOT NULL,
    "phone_number" VARCHAR(50) NOT NULL,
    "dob" VARCHAR(50) NOT NULL,
    "hash" VARCHAR(255) NOT NULL,
    "first_name" VARCHAR(50) NOT NULL,
    "last_name" VARCHAR(50) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "movie" (
    "id" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "trailer" TEXT NOT NULL,
    "ongoing" BOOLEAN NOT NULL,
    "rating" DECIMAL(3,1) NOT NULL,
    "release_date" DATE NOT NULL,
    "poster" TEXT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "genre" VARCHAR(255) NOT NULL,

    CONSTRAINT "movie_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cinema" (
    "id" VARCHAR(50) NOT NULL,
    "cinema_number" VARCHAR(50) NOT NULL,

    CONSTRAINT "cinema_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "seat" (
    "id" VARCHAR(255) NOT NULL,
    "seat_number" VARCHAR(255) NOT NULL,
    "is_available" TEXT NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "cinemaId" TEXT NOT NULL,

    CONSTRAINT "seat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "showtime" (
    "id" VARCHAR(255) NOT NULL,
    "start_time" TIMESTAMPTZ NOT NULL,
    "end_time" TIMESTAMPTZ NOT NULL,
    "cinemaId" TEXT NOT NULL,
    "movieId" TEXT NOT NULL,

    CONSTRAINT "showtime_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "showtime_seat" (
    "is_available" TEXT NOT NULL,
    "showtimeId" TEXT NOT NULL,
    "seatId" TEXT NOT NULL,

    CONSTRAINT "showtime_seat_pkey" PRIMARY KEY ("showtimeId","seatId")
);

-- CreateTable
CREATE TABLE "ticket" (
    "id" TEXT NOT NULL DEFAULT uuid_generate_v4(),
    "userName" TEXT NOT NULL,
    "seatId" TEXT NOT NULL,
    "showtimeId" TEXT NOT NULL,

    CONSTRAINT "ticket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "banner" (
    "id" VARCHAR(255) NOT NULL,
    "url" VARCHAR(500) NOT NULL,

    CONSTRAINT "banner_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_user_name_key" ON "user"("user_name");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_phone_number_key" ON "user"("phone_number");

-- AddForeignKey
ALTER TABLE "seat" ADD CONSTRAINT "seat_cinemaId_fkey" FOREIGN KEY ("cinemaId") REFERENCES "cinema"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "showtime" ADD CONSTRAINT "showtime_cinemaId_fkey" FOREIGN KEY ("cinemaId") REFERENCES "cinema"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "showtime" ADD CONSTRAINT "showtime_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES "movie"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "showtime_seat" ADD CONSTRAINT "showtime_seat_showtimeId_fkey" FOREIGN KEY ("showtimeId") REFERENCES "showtime"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "showtime_seat" ADD CONSTRAINT "showtime_seat_seatId_fkey" FOREIGN KEY ("seatId") REFERENCES "seat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ticket" ADD CONSTRAINT "ticket_userName_fkey" FOREIGN KEY ("userName") REFERENCES "user"("user_name") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ticket" ADD CONSTRAINT "ticket_seatId_fkey" FOREIGN KEY ("seatId") REFERENCES "seat"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ticket" ADD CONSTRAINT "ticket_showtimeId_fkey" FOREIGN KEY ("showtimeId") REFERENCES "showtime"("id") ON DELETE CASCADE ON UPDATE CASCADE;
