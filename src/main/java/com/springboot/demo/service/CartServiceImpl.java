package com.springboot.demo.service;
/*
@author:zhengzhao
@date: 2018/08/27 
@time：15:43
*/

import com.springboot.demo.entity.Cart;
import com.springboot.demo.repositoy.CartRepositoy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements itemService {
    @Autowired
    private CartRepositoy cartRepositoy;

    @Override
    public List<Cart> getAll() {
        return cartRepositoy.findAll();
    }
}
