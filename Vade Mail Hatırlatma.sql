
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[vademail] as 

begin

declare @bodys nvarchar(max)
	declare @vade datetime
	declare @tutar float 
	declare @borclu nvarchar(100)
	declare @carikodu nvarchar(50) 
	declare @email nvarchar(50) 
	declare @poz nvarchar(100)
	declare @tip nvarchar(100)
	declare @tememail nvarchar(150)

declare dongu cursor for 

Select 
	convert(datetime, sck_vade,104) as [Vade Tarihi],
	sck_tutar as [Tutar],
	ca.cari_unvan1 as [Borçlu Adı],
	sck_sahip_cari_kodu as [Cari Kodu],
    ca.cari_EMail as [Cari EMail],
	[dbo].[fn_CekSenetPos](sck_sonpoz,0) as [Pozisyon],
    [dbo].[fn_CekSenetUzun] (sck_tip,0) as [Tip],
	cari_per_mail as [Temsilci Mail]
	from ODEME_EMIRLERI with (NOLOCK) 
	left join CARI_HESAPLAR as ca on sck_sahip_cari_kodu=cari_kod
	left join CARI_PERSONEL_TANIMLARI on cari_temsilci_kodu=cari_per_kod
		where sck_vade = dateadd(day,10,cast(getdate() as date))
	and sck_tip  in (0,1) 
	and sck_sonpoz not in (10 ,4) and ca.cari_EMail like '%@%'
	order by sck_vade

	open dongu 

	
	fetch next from dongu into @vade,@tutar, @borclu, @carikodu,@email, @poz, @tip,@tememail
	while @@FETCH_STATUS = 0
	begin
	
	
		set  
@bodys=

'
<html>
<body>
<div >
<table border=0 cellpadding=0 cellspacing=0 width=737 style=''border-collapse:
 collapse;table-layout:fixed;width:554pt''>
 
 <tr height=68 style=''mso-height-source:userset;height:51.0pt''>
  <td colspan=2 rowspan=2 height=151 style=''height:113.25pt;
  width:261pt'' align=left valign=top><span style=''mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:293px;
  height:122px''>
		  <img src="https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png" width=293 height=122  />
	  
	  </span><span
  style=''mso-ignore:vglayout2''>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 rowspan=2 height=151 class=xl6520851 width=348
    style=''height:113.25pt;width:261pt''></td>
   </tr>
  </table>
  </span></td>
  <td  width=87 style=''width:73pt''></td>
  <td colspan=2 rowspan=2 style=''width:220pt''>Ses
  Bla Bla Bla Bla<br>
    Bla Bla Bla Bla<br>
    Bla Bla Bla Bla<span style=''mso-spacerun:yes''> 
  </span>BlaL<br>
    Bla Bla Bla Bla<br>
    Bla Bla Bla Bla<br>
    Bla Bla Bla Bla</td>
 </tr>
 <tr height=83 style=''mso-height-source:userset;height:62.25pt''>
  <td height=83  style=''height:62.25pt''></td>
 </tr>
 <tr height=28 style=''mso-height-source:userset;height:21.0pt''>
  <td height=28  style=''height:21.0pt''><strong>Sayın,</strong></td>
  <td height=28  style=''height:21.0pt'' colspan=4 ><strong>'+@borclu+'</strong></td>
 </tr>
 <tr height=20 >
  <td height=20  style=''height:15.0pt''></td>
  <td ></td>
  <td ></td>
  <td ></td>
  <td ></td>
 </tr>
 <tr height=44 style=''mso-height-source:userset;height:33.0pt''>
  <td colspan=5 height=44 style=''height:33.0pt;
  width:554pt''>Vadesi yaklaşan ödenmemiş borcunuz bulunmakta olup bakiyenizin
  farklı olduğunu&nbsp;düşünüyorsanız 
   <br>
    Bla Bla Bla Bla</td>
	 </tr>
 <tr >
  <td ></td>
  <td ></td>
<td >
 <br> <br> <br>
</td>
  <td ></td>
  <td ></td>
 </tr>
 <tr height=21 style=''height:15.75pt''>
  <td height=21 style=''height:15.75pt''  align="right"><strong>Yaklaşan Vade Tarihi:</strong></td>
  <td height=21 style=''height:15.75pt''  align="right"><strong>'+format(@vade,'dd.MM.yyyy')+'</strong></td>
  <td ></td>
  <td ><strong>Durumu:</strong></td>
  <td ><strong>Tahsilde</strong></td>
 </tr>
 <tr height=9 >
  <td height=9 ></td>
  <td ></td>
  <td ></td>
  <td ></td>
  <td ></td>
 </tr>
 <tr height=21 style=''height:15.75pt''>
  <td height=21 class=xl7120851 style=''height:12.75pt''><strong>Yaklaşan
  Borcunuz:</strong></td>
  <td ><strong>'+cast(round (@tutar,2) as nvarchar(30)) +'  .TL</strong></td>
  <td ></td>
  <td ><strong>Tipi:</strong></td>
  <td ><strong>'+@tip+'</strong></td>
 </tr>
 <tr height=20 style=''height:15.0pt''>
  <td height=20  style=''height:15.0pt''></td>
  <td ></td>
  <td ></td>
  <td ></td>
  <td ></td>
 </tr>
 <tr height=20 style=''height:15.0pt''>
  <td height=20  style=''height:15.0pt''></td>
  <td ></td>
  <td ></td>
  <td ></td>
  <td ></td>
 </tr>
 <tr height=20 style=''height:15.0pt''>
  <td></td>
  <td></td>
  <BR>
 </tr>
 <tr height=20 style=''height:15.0pt''>
  <td colspan=5 height=20  style=''height:15.0pt''>Bu Mail
  Otomatik Olarak Sistem Tarafından Gönderilmiştir.<span
  style=''mso-spacerun:yes''> </span></td>
 </tr>
 <tr height=0 style=''display:none''>
  <td width=160 style=''width:138pt''></td>
  <td width=241 style=''width:123pt''></td>
  <td width=87 style=''width:73pt''></td>
  <td width=140 style=''width:110pt''></td>
  <td width=161 style=''width:110pt''></td>
 </tr>

</table>

</div>
</body>
</html>
'





	EXEC msdb.dbo.sp_send_dbmail  @profile_name='vademail',

	@recipients=@email,
	@subject='Bla Vade Hatırlatma',
	--@body='',
	@body=@bodys,
	@body_format='HTML',
 @copy_recipients=@tememail,
	@reply_to= 'bla@bla.com'
	

	insert into Emaillog values(@carikodu,@email,getdate(),@tutar)
		fetch next from dongu into  @vade,@tutar, @borclu, @carikodu,@email, @poz, @tip,@tememail
	end	
	

	close dongu
	deallocate dongu
	end

