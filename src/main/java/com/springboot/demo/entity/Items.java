package com.springboot.demo.entity;

/*
@author:zhengzhao
@time: 2018/08/20 
*/

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class Items {
    public Items(){
        goods = new HashMap<Cart,Integer>();
		totalPrice = 0.0;
    }
    private HashMap<Cart,Integer> goods;//商品信息作为key,商品数量作为value
    private double totalPrice;

    public HashMap<Cart, Integer> getGoods() {
        return goods;
    }

    public void setGoods(HashMap<Cart, Integer> goods) {
        this.goods = goods;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    /**
     * @param "商品的信息集合"
     * @param "添加的商品数量"
     * @return "是否添加成功"
     */
    public boolean addGoodsInCart(Cart cart, int num){
        if (goods.containsKey(cart)){
            goods.put(cart,goods.get(cart)+num);
        }
        else {
            goods.put(cart,num);
        }

        calTotalPrice();
        return true;
    }

    /**
     * @param "要删除的商品信息集合"
     * @return "是否删除成功"
     */
    public boolean removeGoodsInCart(Cart cart){
        if(goods.get(cart)>0){
            goods.remove(cart);
            calTotalPrice();
            return true;
        }else {
            return false;
        }
    }

    /**
     * @param "要减少的商品信息集合"
     * @return "是否减少成功"
     */
    public boolean subGood(Cart cart){
        if(goods.get(cart)-1>0){
            goods.put(cart,goods.get(cart)-1);
            calTotalPrice();
            return true;
        }else {
            return false;
        }
    }

    public boolean addGood(Cart cart){
        if(goods.get(cart)+1<999){
            goods.put(cart,goods.get(cart)+1);
            calTotalPrice();
            return true;
        }else {
            return false;
        }
    }

    public double calTotalPrice(){
        double sum = 0.0;
        Set<Cart> keys = this.goods.keySet();//获得所有商品信息集合
        Iterator<Cart> it = keys.iterator();
        while (it.hasNext()){
            Cart i = it.next();
            sum += i.getPrice() * goods.get(i);
        }
        setTotalPrice(sum);
        return getTotalPrice();
    }

    public static void main(String[] args) throws IOException {
        Cart cart = new Cart();
        cart.setId(1);
        cart.setName("李宁男鞋");
        cart.setCity("江苏");
        cart.setPrice(300);
        cart.setNumber(50);
        cart.setPicture("/images/0001.jpg");
//        Items id1 = new Items(1,"李宁男鞋","江苏",300,50,"/images/0001.jpg");

        Items items = new Items();
        items.addGoodsInCart(cart,2);
        items.addGoodsInCart(cart,2);

        Set<Map.Entry<Cart,Integer>> item = items.getGoods().entrySet();
        for (Map.Entry<Cart,Integer> obj :item){
            System.out.println(obj.toString());
        }
        System.out.println("总价格为  "+items.calTotalPrice());
//        JSONObject jsonObject = new JSONObject();
//        jsonObject.put("error","dadsadas");
    }
}
