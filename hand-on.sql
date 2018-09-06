Q1/ 

(select c.Cname
from Customer c , Account a 
WHERE c.cname= a.cname AND 
Ccity='MPLS' and
bal>1200  
minus
select cname
from account 
where bname='France' )
union
select l.cname
from loan l ,customer c
where l.cname=c.cname and c.ccity='Edina'
group by l.cname
having count(l.cname)=1


----------------------------------------------------------------
Q2/ 

select distinct c.cname,c.ccity
from customer c ,account a, loan l 
where c.cname=a.cname and 
      c.cname=l.cname and 
      l.cname=a.cname and 	  
a.bal>=1800 and 
l.amt>=800 and 
c.cname not in ( select l.cname from loan l,account a  
where l.bname=a.bname and l.bname='Southdale')

----------------------------------------------------------------
q3/

select b.bname, b.assets
from branch b,account a   
where b.bname=a.bname and  
b.assets >any (select assets from branch where bcity='Edina')
and a.cname in (
select c.cname
from customer c ,account a 
where c.cname=a.cname and ccity='Minnetonka' 
group by c.cname 
having sum(a.bal)>1200 
)


---------------------------------------------------------------------------------------
Q4- 

select c.cname
from customer c,account a
where  (ccity='Minnetonka' OR ccity='Eden Prairie') 
and a.cname=c.cname and a.bname in (select bname from branch where bcity='Edina')

intersect
select l.cname
from loan l ,branch b 
where l.bname=b.bname and b.bcity='Minnetonka' and 
b.bname not in (Select bname from branch where assets>=125000)
group by cname
having count (distinct l.bname)=

(select count(bname) 
from branch 
where bcity='Minnetonka' and assets<125000)



-- Another solution

select distinct c.cname
from customer c,account a,loan l
where  (ccity='Minnetonka' OR ccity='Eden Prairie') 
and a.cname=c.cname and a.bname in (select bname from branch where bcity='Edina')
and l.cname=c.cname and l.bname not in (Select bname from branch where bcity='Minnetonka' and assets>=125000)
group by c.cname
having count (distinct l.bname)=
(select count(bname) 
from branch 
where bcity='Minnetonka' and assets<125000)








