def consolidate_cart(cart)
  # code here
  final_hash = {}
  cart.each do |element_hash|
    element_name = element_hash.keys[0]
    
    if final_hash.has_key?(element_name)
      final_hash[element_name][:count] += 1 
    else 
      final_hash[element_name] = {
        count: 1,
        price: element_hash[element_name][:price],
        clearance: element_hash[element_name][:clearance]
      }
   end
 end
 final_hash
 end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    discount_item = "#{item} W/COUPON"
    if cart[item]
      if cart[item][:count] >= coupon[:num] && !cart.has_key?(discount_item)
        cart[discount_item] = {
          price: coupon[:cost] / coupon[:num],
          clearance: cart[item][:clearance],
          count: coupon[:num]
        }
        cart[item][:count] -= coupon[:num]
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?(discount_item)
          cart[discount_item][:count] += coupon[:num]
          cart[item][:count] -= coupon[:num]
        end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, item_hash|
    item_hash[:price] -= item_hash[:price] * 0.2 if item_hash[:clearance]
  end
  cart
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_discount = apply_clearance(apply_coupons)
  total = applied_discount.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count]}
  
end


