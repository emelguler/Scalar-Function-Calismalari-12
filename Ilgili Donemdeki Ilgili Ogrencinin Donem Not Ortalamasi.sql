USE [Okul]




--Ilgili Donemdeki Ilgili Ogrencinin Donem Not Ortalamasi:
--girdiler: Ogrenci_Id ,Donem_Id 
---cıkti: DonemNotOrtalamasi


alter function [dbo].[DonemNotOrtalamasi](@Ogrenci_Id int,@Donem_Id int)
returns int
as
begin
declare @sonuc  int
set @sonuc= (select a.DonemNotOrtalamasi
from

(select o.Id as Ogrenci_Id, 
og.Donem_Id , (([dbo].[FN$IlgiliDonemdekiOgrencininSayiDegerleriToplami](@Donem_Id,@Ogrenci_Id)) /(dbo.FN$OgrencininAldigiToplamKrediSayisi(@Ogrenci_Id,@Donem_Id)))
 as DonemNotOrtalamasi
from dbo.OgrenciOgretmenDers as ood
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.OgretmenDers  as og on og.Id=ood.OgretmenDers_Id and og.Statu=1
inner join dbo.Donem as do on do.Id=og.Donem_Id and do.Statu=1
where ood.Statu=1
and o.Id = @Ogrenci_Id
and do.Id = @Donem_Id
group by  o.Id,
          og.Donem_Id 
       	     
) A
)
 return @sonuc
 end




--cagiralim:

 select [dbo].[DonemNotOrtalamasi](2,1)







 --where clause kontrolu:

 declare @Ogrenci_Id int=2,
        @Donem_Id int=1

select o.Id as Ogrenci_Id, 
og.Donem_Id , (([dbo].[FN$IlgiliDonemdekiOgrencininSayiDegerleriToplami](@Donem_Id,@Ogrenci_Id)) /(dbo.FN$OgrencininAldigiToplamKrediSayisi(@Ogrenci_Id,@Donem_Id)))
 as DonemNotOrtalaması
from dbo.OgrenciOgretmenDers as ood
inner join dbo.Ogrenci as o on o.Id=ood.Ogrenci_Id and o.Statu=1
inner join dbo.OgretmenDers  as og on og.Id=ood.OgretmenDers_Id and og.Statu=1
inner join dbo.Donem as do on do.Id=og.Donem_Id and do.Statu=1
where ood.Statu=1
and o.Id = @Ogrenci_Id
and do.Id = @Donem_Id
group by  o.Id,
          og.Donem_Id  	 