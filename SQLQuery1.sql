use [hospital managment system]
go
        ----------Table creation---------------

create table patient_info(
patient_id int Primary key,
  [ patient name] NVARCHAR(50),
    [contact number] bigint ,
    e_mail NVARCHAR(150),
    [ patient address] nvarchar(150),
    gender char(20),
    [ patient entry date] date
)

create table doctor_info(
   [doctor id] int PRIMARY key,
   [doctor name] nvarchar(50),
    [doctor contact_No] bigint
)
create table PatientsAttendbydoc(
patient_id int,
  [doctor id] int ,
    disease_detect NVARCHAR(50),
    check_date DATE,
   ckeck_day  VARCHAR(20)
	foreign key (patient_id) references patient_info(patient_id),
	foreign key ([doctor id]) references doctor_info([doctor id])
	)

create table start_treatment_of_pateient(
    start_check date,
   patient_id int,
    [doctor id] int ,
    tretment_start date,
    complete_treatment date,
    FOREIGN key (patient_id) REFERENCES patient_info(patient_id),
    FOREIGN key ([doctor id]) REFERENCES doctor_info([doctor id])
)

create  table patteint_discharge_info(
   discharge_date date,
    [ patient name] NVARCHAR(50),
     patient_id int,
FOREIGN key (patient_id) REFERENCES patient_info(patient_id)
)
select * from patient_info

--insert into patient_info( patient_id ,[ patient name],[contact number],e_mail,[ patient address],gender ,[ patient entry date] )

--VALUES(6821,'surya',8823123423,'surya23@gmail.com','wz-d-65 nagli najafghar,delhi','male','2014-01-24'),
--(5821,'seeta',6823123423,'seeta@gmail.com','wz-d-61 dawarka ,delhi','female','2014-02-01'),
--(6453,'geet',4523123423,'geet23@gmail.com','wz-d-61 najafghar,delhi','male','2014-01-12')
--insert into patient_info values(9821,'suman',4637280473,'suman@gmail.com','wz-bihar 5 gali number 1000','female','2014-02-26')
--update patient_info set gender='male' where [ patient name]='geet'

select * from doctor_info

--insert into doctor_info VALUES(2132,'Dr Rakesh',9821074705)
--insert into doctor_info VALUES(2154,'Dr mohit',8210734305)
--insert into doctor_info VALUES(2111,'Dr Preeti',2210734305)
--insert into doctor_info VALUES(2122,'Dr srya',5621073435)

--insert  into PatientsAttendbydoc(patient_id ,[doctor id]  ,disease_detect ,check_date ,ckeck_day) 
--values(6453,2111,'fever','2014-01-12','friday'),
--(6821,2111,'losse motion','2014-01-25','mondat'),
--(5821,2122,'cancer','2014-02-02','friday'),
--(9821,2154,'losse motion','2014-01-25','wednesday')

select * from doctor_info
select * from patient_info
select *from PatientsAttendbydoc

--insert into start_treatment_of_pateient(start_check,patient_id,[doctor id],tretment_start,complete_treatment) 
---values
--('2014-01-12',6453,2111,'2014-01-12','2014-01-15'),
--('2014-01-25',6821,2111,'2014-01-25','2014-01-29'),
--('2014-01-25',5821,2122,'2014-02-10','2015-01-12'),
--('2014-01-25',9821,2154,'2014-01-25','2014-01-28')

--select query

select * from doctor_info
select * from patient_info
select *from PatientsAttendbydoc
select*from start_treatment_of_pateient

update PatientsAttendbydoc set check_date='2014-02-26' where patient_id=9821


---Store procedure for patient informatition

--create procedure sp_patient_info
--@patient_id int
--as 
--begin 
--     select * from patient_info where patient_id=@patient_id
--end

sp_patient_info 9821

--Store procedure for check disease by patint id



--create procedure sp_patient_disease_ckeck
--@patient_id int
--as
--begin
 --  select * from PatientsAttendbydoc where patient_id=@patient_id
--end

sp_patient_disease_ckeck 9821

------stored procedure for check doc detail by doc  id
--create proc sp_doc_detail
--@doc_id INT
--as
--begin
 -- select *from doctor_info where [doctor id]=@doc_id
--end

sp_doc_detail 2154


--select * from patient_info as p
--join PatientsAttendbydoc as pa
--on p.patient_id=pa.patient_id 
--join doctor_info as d
--on d.[doctor id]=pa.[doctor id]



create proc sp_all_detail
@patient_id int
as
begin
select * from PatientsAttendbydoc 
 join doctor_info
 on doctor_info.[doctor id]=PatientsAttendbydoc.[doctor id] where patient_id=@patient_id
end

sp_all_detail 9821

CREATE table new_patient_infomation(
    id int identity,
    Audit_Info NVARCHAR(200)
)

alter TRIGGER tr_enter_new_info
on patient_info
for INSERT
AS BEGIN
       declare @id INT
       select @id=patient_id from inserted
       insert into new_patient_infomation values('new patient with patient_number='+ CAST(@id as nvarchar(5))+'is added at'+ cast(GETDATE() as nvarchar(20)))
end


--insert into patient_info( patient_id ,[ patient name],[contact number],e_mail,[ patient address],gender ,[ patient entry date] )

--VALUES(9999,'rohan',8823212345,'rohan23@gmail.com','wz-d-65 nagli najafghar,delhi','male','2014-01-21')

--select * from new_patient_infomation 

--select * from patient_info

--new patient with patient_number=9999is added atFeb 11 2024  4:36PM


CREATE table new_doctor_infomation(
    id int identity,
    Audit_Info NVARCHAR(200)
)

CREATE table leave_doctor_infomation(
    id int identity,
    Audit_Info NVARCHAR(200)
)


-----create insert triggrer
create TRIGGER new_doc_info
on doctor_info
for insert 
as BEGIN
  DECLARE @id INT
  SELECT @id= [doctor id] from inserted
  INSERT into new_doctor_infomation values('new doctor id =' + cast(@id as nvarchar(5)) + 'on date is ' + cast(GETDATE() as nvarchar(20)))

end

insert into doctor_info values(2229,'Dr vipul',12343134455)

---doctor leave firm delete trigger
create TRIGGER leave_firm_doc_info
on doctor_info
for delete 
as BEGIN
  DECLARE @id INT
  SELECT @id= [doctor id] from deleted
  INSERT into leave_doctor_infomation values('new doctor id = ' + cast(@id as nvarchar(5))  + ' leave on date is ' +  cast(GETDATE() as nvarchar(20)))

end



select *from doctor_info
select * from  new_doctor_infomation
select * from leave_doctor_infomation

