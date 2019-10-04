
def consolidate_cart(cart)
    new_cart = {} 
    cart.each do |items| 
      items.each do |item, new_pair| 
        new_cart[item] ||= new_pair 
        new_cart[item][:count] ? new_cart[item][:count] += 1 :   
        new_cart[item][:count] = 1 
      end 
    end 
    new_cart 
end

# def apply_coupons(cart, coupons)
# coupons.each do |coupon|
# item = coupon[:item] 
# if cart.has_key?("item")
# if cart[item][count] >= coupon[:num] && !cart.has_key?("#{item} W/COUPON")
# cart["#{item} W/COUPON"] = {price:coupon[:cost]/ coupon[num], clearance: cart[item][:clearance], count:coupon[:num]}

# elsif cart[item][count] >= coupon[:num] && cart.has_key?("#{item} W/COUPON")
# cart["#{item} W/COUPON"][:count] += coupon[:num]
# end
# cart[item][:count] -= coupon[:num]
# end
# end
# cart
# end

def apply_coupons(cart:[], coupons:[])
  # code here	  # code here
  # cart_cons = consolidate_cart(cart: cart)
  cart_cons = cart
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart_cons.keys.include?(item_name)
      cart_count = cart_cons[item_name][:count]
      if cart_count >= coupon[:num]
        item_coup = {"#{item_name} W/COUPON" => {price: coupon[:cost], clearance: cart_cons[item_name][:clearance], count: cart_count/coupon[:num]}}
        cart_cons[item_name][:count] %= coupon[:num]
        cart_cons = cart_cons.merge(item_coup)
      end
    end
  end
  return cart_cons
end

     
def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, hash|
      if hash[:clearance] 
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
      end
  end
  new_cart
end



def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = 0
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

  if total >= 100
      total *= 0.9
  end
  total
end

  
