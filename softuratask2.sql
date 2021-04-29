select * from authors
select * from titles
select * from titleauthor
select * from publishers
select * from sales


//1.city name and count of authors from every city

select city,count(au_fname)author_count from authors group by city


//2.authors who are not from city in which publisher "New Moon Books' is from

select au_fname,au_lname from authors where au_fname not in (select city from publishers where pub_name='New Moon Books')


//3.create a procedure that will take author first name last name and updated price .The procedure should update the price of books written by author with given name.

create proc proc_UpdatePrice(@fname varchar(50),@lname varchar(50),@UpdatePrice float)
as
begin
update titles 
set price= @UpdatePrice
where title_id =(select title_id from titleauthor where au_id =(select au_id from authors where au_fname =@fname and au_lname=@lname))
end
exec proc_UpdatePrice 'Johnson','White',20.05


//4.Create a function that will calculate tax for the sale of every book.If quantity <10 tax is 2%
10 -20 tax is 5%
20 - 50 tax is 6%
above 30 tax is 7.5%
The fuction should take quantity and return tax

create function fn_CalculateTaxSales(@quantity int)
returns float
as
begin
declare
@tax int
if(@quantity < 10)
set @tax=2
else if(@quantity>10 and @quantity<=20)
set @tax=5
else if(@quantity>20 and @quantity<=50)
set @tax=6
else
set @tax=7.5
return @tax
end

select qty,dbo. fn_CalculateTaxSales(qty) 'Tax' from sales











