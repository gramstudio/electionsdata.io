-- CreateEnum
CREATE TYPE "ElectionType" AS ENUM ('PRESIDENTIAL', 'PARLIAMENTARY');

-- CreateTable
CREATE TABLE "Country" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "isoCode" TEXT NOT NULL,

    CONSTRAINT "Country_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Election" (
    "id" TEXT NOT NULL,
    "countryId" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "pollClose" TIMESTAMP(3) NOT NULL,
    "type" "ElectionType" NOT NULL,
    "notes" TEXT,
    "eta" TEXT,
    "dataSource" TEXT NOT NULL,
    "dataUrl" TEXT NOT NULL,

    CONSTRAINT "Election_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ElectionResult" (
    "id" TEXT NOT NULL,
    "electionId" TEXT NOT NULL,
    "candidate" TEXT,
    "party" TEXT,
    "votes" INTEGER NOT NULL,
    "percentage" DOUBLE PRECISION,

    CONSTRAINT "ElectionResult_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Country_name_key" ON "Country"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Country_isoCode_key" ON "Country"("isoCode");

-- AddForeignKey
ALTER TABLE "Election" ADD CONSTRAINT "Election_countryId_fkey" FOREIGN KEY ("countryId") REFERENCES "Country"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ElectionResult" ADD CONSTRAINT "ElectionResult_electionId_fkey" FOREIGN KEY ("electionId") REFERENCES "Election"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
