package com.springboot.demo.controller;
/*
@author:zhengzhao
@date: 2018/08/27 
@time：9:42
*/

import com.springboot.demo.domain.Result;
import com.springboot.demo.entity.Cart;
import com.springboot.demo.entity.Items;
import com.springboot.demo.repositoy.CartRepositoy;
import com.springboot.demo.utils.DataFormat;
import com.springboot.demo.utils.ResultUtil;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RestController
public class CartController {
    private final static Logger logger = LoggerFactory.getLogger(CartController.class);
    @Autowired
    private CartRepositoy cartRepositoy;
    @Autowired
    private HttpServletRequest request;


    /**
     * 查看所有商品的信息
     * @return
     */
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public Result<Cart> index(){
        logger.info("首页被请求了");
        return ResultUtil.success(cartRepositoy.findAll());
    }

    /**
     * 查看指定商品的信息
     * @param id "商品id"
     * @return
     */
    @GetMapping(value = "/{id}")
    public Result<Cart> details(@PathVariable("id") Integer id){
        logger.info("请求某一个ID");
        Optional<Cart> cartResult = cartRepositoy.findById(id);
        if (cartResult.isPresent()) {
            return ResultUtil.success(cartRepositoy.findById(id));
        }
        return ResultUtil.error("ID未找到");
    }

    /**
     *  将商品添加到购物车中
     * @param id "商品的id"
     * @param number "购买的数量"
     * @return
     */
    @PostMapping(value = "/{id}")
    public Result addInCart(@PathVariable("id") Integer id , @RequestParam("num") Integer number){
        logger.info("session是"+request.getSession().getId());
        if (request.getSession().getAttribute("cart")==null){
            Items items = new Items();
            request.getSession().setAttribute("cart",items);
        }
            Items items = (Items) request.getSession().getAttribute("cart");
            Optional<Cart> cartResult = cartRepositoy.findById(id);
        if (cartResult.isPresent()) {
            Cart cart = cartResult.get();
            items.addGoodsInCart(cart,number);
            return ResultUtil.success("添加成功");
        }
        return ResultUtil.error("ID未找到");
    }
    /**
     * 显示购物车
     * @return
     */
    @GetMapping(value = "/show")
    public Result<Cart> show() {
        logger.info("session是"+request.getSession().getId());
        if (request.getSession().getAttribute("cart")==null){
            Items items = new Items();
            request.getSession().setAttribute("cart",items);
            return ResultUtil.success(items);
        }
        Items items = (Items) request.getSession().getAttribute("cart");
        DataFormat dataFormat =new DataFormat();
        List<HashMap<String,Object>> listCart = dataFormat.itemsFormat(items);
        return ResultUtil.success(listCart);
    }

    /**
     * 添加或者减少商品数量
     * @param id "要操作的商品ID"
     * @param action "[0,1] 0代表这减少 1代表增加"
     * @return "是否操作成功"
     */
    @PutMapping(value = "/{id}/{action}")
    public Result subOrAdd(@PathVariable("id") Integer id , @PathVariable("action") Integer action){
        Items items = (Items) request.getSession().getAttribute("cart");
        Optional<Cart> cartResult = cartRepositoy.findById(id);
        if (cartResult.isPresent()) {
            Cart idCart = cartResult.get();
            Set<Cart> carts = items.getGoods().keySet();
            Iterator<Cart> cartIterator= carts.iterator();
            while (cartIterator.hasNext()){
                Cart cart = cartIterator.next();
                if(cart.equals(idCart)){//找到对应id的商品
                    int i =items.getGoods().get(cart)-1;
                    if(action.equals(0)){
                        //执行减一操作
                        if(items.subGood(cart)){
                            return ResultUtil.success("减一成功");
                        }
                    }
                    if(action.equals(1)){
                        //执行加一操作
                       if(items.addGood(cart)){
                            return ResultUtil.success("加一成功");
                        }
                    }
                }
            }
            return ResultUtil.error("未知错误");
        }
        return ResultUtil.error("ID不存在");
    }

    /**
     * 从购物车中删除商品
     * @param id "商品的ID"
     * @return "是否操作成功"
     */
    @DeleteMapping(value = "/{id}")
    public Result delInCart(@PathVariable("id") Integer id ){
        Items items = (Items) request.getSession().getAttribute("cart");
        Optional<Cart> cartResult = cartRepositoy.findById(id);
        if (cartResult.isPresent()) {
            Cart idCart = cartResult.get();
            Set<Cart> carts = items.getGoods().keySet();
            Iterator<Cart> cartIterator= carts.iterator();
            while (cartIterator.hasNext()){
                Cart cart = cartIterator.next();
                if(cart.equals(idCart)) {//找到对应id的商品
                    if(items.removeGoodsInCart(cart)){
                        return ResultUtil.success("删除成功");
                    }
                }
            }
        }

        return ResultUtil.error("删除失败");
    }

}
