package com.springboot.demo.utils;
/*
@author:zhengzhao
@date: 2018/08/28 
@time：11:09
*/

import com.springboot.demo.domain.Result;

public class ResultUtil {

    /**
     * 这里声明了成功以后返回的数据结构
     * @param o "返回的信息"
     * @return
     */
    public static final Result success(Object o){
        Result result =new Result();
        result.setCode(0);
        result.setMsg("成功");
        result.setData(o);
        return result;
    }

    public static final Result error(Object o){
        Result result = new Result();
        result.setCode(1);
        result.setMsg("失败");
        result.setData(o);
        return result;
    }
}
