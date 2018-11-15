package com.springboot.demo.utils;
/*
@author:zhengzhao
@date: 2018/08/29 
@time：11:09
*/
import com.springboot.demo.entity.Cart;
import com.springboot.demo.entity.Items;
import org.springframework.context.annotation.Configuration;

import java.util.*;

@Configuration
public class DataFormat {
    public DataFormat() {
    }
    public List<HashMap<String,Object>> itemsFormat(Items items) {
        List<HashMap<String,Object>> arrayList = new ArrayList<>();
        Set<Cart> carts = items.getGoods().keySet();
        Iterator<Cart> cartIterator= carts.iterator();
        //这里保持第一个总是为总价格，方便前端读取数据
        HashMap<String,Object> allPrice = new HashMap<>();
        allPrice.put("allPrice",items.calTotalPrice());
        arrayList.add(allPrice);
        while (cartIterator.hasNext()){
            Cart cart = cartIterator.next();
            HashMap<String,Object> stringObjectHashMap = new HashMap<>();
            stringObjectHashMap.put("id",cart.getId());
            stringObjectHashMap.put("name",cart.getName());
            stringObjectHashMap.put("price",cart.getPrice());
            stringObjectHashMap.put("city",cart.getCity());
            stringObjectHashMap.put("picture",cart.getPicture());
            stringObjectHashMap.put("BuyNumber",items.getGoods().get(cart));
            arrayList.add(stringObjectHashMap);
        }
        return arrayList;
    }
}
