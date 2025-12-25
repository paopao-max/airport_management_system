package com.cafuc.pojo;

import java.io.Serializable;

/**
 * 统一返回结果类
 */
public class Result implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private boolean success;  // 是否成功
    private String message;   // 返回消息
    
    public Result() {
    }
    
    public Result(boolean success, String message) {
        this.success = success;
        this.message = message;
    }
    
    public boolean isSuccess() {
        return success;
    }
    
    public void setSuccess(boolean success) {
        this.success = success;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    @Override
    public String toString() {
        return "Result{" +
                "success=" + success +
                ", message='" + message + '\'' +
                '}';
    }
}
