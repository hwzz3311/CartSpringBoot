package com.springboot.demo.service;
/*
@author:zhengzhao
@date: 2018/08/27 
@time：15:41
*/

import com.springboot.demo.entity.Cart;

import java.util.List;

public interface itemService {
    List<Cart> getAll();
}
