select category.name Kategori, count(category.name) 'Antal produkter' from category
join categoryBelonging on categoryBelonging.categoryId = category.id
group by category.name;


select customer.name Namn, sum(product.price) Summa from customer
join orders on orders.customerId = customer.id
join cart on cart.ordersId = orders.id
join product on product.id = cart.productId
group by customer.id;

select customer.name Name
from customer 
join orders on orders.customerId = customer.id
join cart on cart.ordersId = orders.id
join product on product.id = cart.productId
join brand on brand.id = product.brandId
join categoryBelonging on categoryBelonging.id = product.id
join category on category.id = categoryBelonging.categoryId
where product.colour = 'svart' and product.euSizing = 38 and brand.name like 'ecco' and category.name like 'sommarsko';

select distinct address.state Ort, sum(product.price) Summa
from customer 
left join orders on orders.customerId = customer.id
left join cart on cart.ordersId = orders.id
left join product on product.id = cart.productId
left join address on customer.addressId = address.id  
group by address.state
having Summa > 1000;

select brand.name Märke, product.colour Färg, product.euSizing Storlek, count(product.id) Antal from product
join cart on cart.productId = product.id
join orders on orders.id = cart.ordersId
join brand on brand.id = product.brandId
group by product.id
order by antal desc
limit 5;

select customer.name Namn, sum(product.price) Summa from customer
join orders on orders.customerId = customer.id
join cart on cart.ordersId = orders.id
join product on product.id = cart.productId
group by customer.id;


select month(dateOfOrder) Månad, sum(product.price) Summa from orders
join cart on cart.ordersId = orders.id
join product on product.id = cart.productId
group by month(dateOfOrder)
order by Summa desc
limit 1;

create index IX_customerName on customer(name);
