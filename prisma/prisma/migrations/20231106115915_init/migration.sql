-- CreateTable
CREATE TABLE "Users" (
    "id" TEXT NOT NULL,
    "user_name" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "phoneNo" INTEGER NOT NULL,
    "passout_year" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "activationKey" TEXT NOT NULL,
    "activationSentAt" TEXT NOT NULL,
    "verified" BOOLEAN NOT NULL DEFAULT false,
    "branchId" TEXT NOT NULL,
    "collegeId" TEXT NOT NULL,
    "branchesId" TEXT,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Products" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "description" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "categoryId" TEXT NOT NULL,
    "sellerId" TEXT NOT NULL,
    "sold" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cart" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Cart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Images" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "Images_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Categories" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Colleges" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Colleges_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Branches" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Branches_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_CartToProduct" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_CollegeBranch" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_user_name_key" ON "Users"("user_name");

-- CreateIndex
CREATE UNIQUE INDEX "Cart_userId_key" ON "Cart"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Images_url_key" ON "Images"("url");

-- CreateIndex
CREATE UNIQUE INDEX "Images_userId_key" ON "Images"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Categories_name_key" ON "Categories"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Colleges_name_key" ON "Colleges"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Branches_name_key" ON "Branches"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_CartToProduct_AB_unique" ON "_CartToProduct"("A", "B");

-- CreateIndex
CREATE INDEX "_CartToProduct_B_index" ON "_CartToProduct"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_CollegeBranch_AB_unique" ON "_CollegeBranch"("A", "B");

-- CreateIndex
CREATE INDEX "_CollegeBranch_B_index" ON "_CollegeBranch"("B");

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_collegeId_fkey" FOREIGN KEY ("collegeId") REFERENCES "Colleges"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_branchesId_fkey" FOREIGN KEY ("branchesId") REFERENCES "Branches"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cart" ADD CONSTRAINT "Cart_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Images" ADD CONSTRAINT "Images_productId_fkey" FOREIGN KEY ("productId") REFERENCES "Products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Images" ADD CONSTRAINT "Images_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CartToProduct" ADD CONSTRAINT "_CartToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES "Cart"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CartToProduct" ADD CONSTRAINT "_CartToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES "Products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CollegeBranch" ADD CONSTRAINT "_CollegeBranch_A_fkey" FOREIGN KEY ("A") REFERENCES "Branches"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_CollegeBranch" ADD CONSTRAINT "_CollegeBranch_B_fkey" FOREIGN KEY ("B") REFERENCES "Colleges"("id") ON DELETE CASCADE ON UPDATE CASCADE;
