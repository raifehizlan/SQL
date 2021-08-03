
/*Draw the Triangle 2 
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* 
* * 
* * * 
* * * * 
* * * * *
Write a query to print the pattern P(20).*/declare @row intset @row = 0;
while @row <20
begin
    set @row = @row + 1
    print(replicate('* ',@row))
end;