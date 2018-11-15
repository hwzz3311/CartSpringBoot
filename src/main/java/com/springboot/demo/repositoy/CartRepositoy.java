package com.springboot.demo.repositoy;

import com.springboot.demo.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepositoy extends JpaRepository<Cart , Integer> {

//    public Cart findById( Integer id);
}
