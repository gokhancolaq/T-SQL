SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[Silme_Engelleme] ON [dbo].[SERVIS_ISEMIRLERI] 
AFTER  DELETE
AS
DECLARE 
            
             @ModelYon  NVARCHAR(MAX),
			 @Aciklama NVARCHAR(MAX),
			 @Sonuc NVARCHAR(Max)
			 
			
SELECT @ModelYon=Kulak_Yonu,@Aciklama=Aciklama FROM DELETED
LEFT JOIN [SERVIS_ISEMIRLERI_USER] WITH(NOLOCK)  ON Record_uid=sis_Guid

IF ISNULL(@ModelYon,'')!='' AND ISNULL(@Aciklama,'')!='Sil'
BEGIN

raiserror('Modelleme Olduğu İçin Silme Yetkiniz Yoktur..!  Lütfen Modellemeci Arkadaşlarımızla Görüşünüz',16,1)
	RETURN
	   
END





