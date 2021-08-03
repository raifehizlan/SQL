/*P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20). */

declare @row int
set @row = 21
while @row > 1
begin
    set @row = @row -1
    print(replicate('* ', @row))    
end;