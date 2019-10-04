
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

def apply_coupons(cart, coupons)
  hash = cart
  coupons.each do |coupon_hash|
    # add coupon to cart
    item = coupon_hash[:item]

    if !hash[item].nil? && hash[item][:count] >= coupon_hash[:num]
      temp = {"#{item} W/COUPON" => {
        :price => coupon_hash[:cost],
        :clearance => hash[item][:clearance],
        :count => 1
        }
      }
      
      if hash["#{item} W/COUPON"].nil?
        hash.merge!(temp)
      else
        hash["#{item} W/COUPON"][:count] += 1
        #hash["#{item} W/COUPON"][:price] += coupon_hash[:cost]
      end
      
      hash[item][:count] -= coupon_hash[:num]
    end
  end
  hash
end
def apply_coupons(cart, coupons)
  coupons.each do |element|
    name= element[:item]
    amount= element[:num]
    
    if cart.has_key?(name) && cart[name][:count] >= element[:num] && cart[name][:clearance]
      puts "yes"
    end
    
  end
  
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

  
