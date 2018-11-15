package com.springboot.demo.entity;
/*
@author:zhengzhao
@date: 2018/08/27 
@time：14:19
*/

import org.json.JSONObject;

import javax.persistence.*;

@Entity
@Table(name = "goods")
public class Cart {
    public Cart() {
    }
    @Id
    @GeneratedValue
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    @Override
    public String toString() {
//        JSONObject jsonObject = new JSONObject();
//        return jsonObject;
        return  "{"+"id:" + id +","+
                "price:" + price +","+
                "number:" + number +","+
                "name:" + name  +","+
                "city:" + city  +"}";
    }

    private Integer number;
    private Integer price;
    private String name;
    private String city;
    private String picture;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o instanceof Cart) {
            Cart i = (Cart) o;
            if (this.getId()==i.getId()&&this.getName().equals(i.getName())){
                return true;
            }
            else {
                return false;
            }
        }
        else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return this.getId()+this.getName().hashCode();
    }

}
