-- BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[CustomerEnquiry] (
    [FirstName] VARCHAR(50) NOT NULL,
    [LastName] VARCHAR(50),
    [Email] VARCHAR(50) NOT NULL,
    [EnquirySubject] VARCHAR(50) NOT NULL,
    [EnquiryDescription] VARCHAR(max) NOT NULL
);

-- CreateTable
CREATE TABLE [dbo].[LoginDetails] (
    [UserId] INT NOT NULL,
    [Username] VARCHAR(100) NOT NULL,
    [Password] VARCHAR(50) NOT NULL,
    CONSTRAINT [PK__LoginDet__1788CC4C8B3260E4] PRIMARY KEY CLUSTERED ([UserId])
);

-- CreateTable
CREATE TABLE [dbo].[UserDetails] (
    [UserId] INT NOT NULL IDENTITY(1,1),
    [Title] VARCHAR(5) NOT NULL,
    [FirstName] VARCHAR(255) NOT NULL,
    [LastName] VARCHAR(255) NOT NULL,
    [Gender] VARCHAR(10) NOT NULL,
    [Email] VARCHAR(50) NOT NULL,
    [Dob] DATE NOT NULL,
    [MobileNumber] VARCHAR(15) NOT NULL,
    [CreatedAt] DATETIME NOT NULL CONSTRAINT [DF__UserDetai__Creat__73BA3083] DEFAULT CURRENT_TIMESTAMP,
    [UpdatedAt] DATETIME,
    CONSTRAINT [PK__UserDeta__1788CC4C4C60C617] PRIMARY KEY CLUSTERED ([UserId]),
    CONSTRAINT [UQ__UserDeta__A9D105344A206566] UNIQUE NONCLUSTERED ([Email]),
    CONSTRAINT [UQ__UserDeta__250375B13EBE4FE2] UNIQUE NONCLUSTERED ([MobileNumber])
);

-- AddForeignKey
ALTER TABLE [dbo].[LoginDetails] ADD CONSTRAINT [FK__LoginDeta__UserI__76969D2E] FOREIGN KEY ([UserId]) REFERENCES [dbo].[UserDetails]([UserId]) ON DELETE NO ACTION ON UPDATE NO ACTION;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
