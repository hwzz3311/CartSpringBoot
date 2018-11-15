package com.springboot.demo.domain;
/*
@author:zhengzhao
@date: 2018/08/28 
@time：11:12
*/

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Result<T> {
    private Integer code;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }
    public T getData() {
        return data;
    }
    public void setData(T data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    private T data;
    private String msg;

}
