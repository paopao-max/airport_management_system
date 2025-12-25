package com.cafuc.controller;

import com.cafuc.pojo.PageResult;
import com.cafuc.pojo.Result;
import com.cafuc.pojo.User;
import com.cafuc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户管理控制器
 */
@Controller
@RequestMapping("/userManage")
public class UserManageController {
    
    @Autowired
    private UserService userService;
    
    /**
     * 跳转到用户列表页面
     */
    @RequestMapping("/list")
    public String list() {
        return "admin/user_list";
    }
    
    /**
     * 添加用户
     */
    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    @ResponseBody
    public Result addUser(@RequestBody User user) {
        try {
            userService.addUser(user);
            return new Result(true, "添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "添加失败：" + e.getMessage());
        }
    }
    
    /**
     * 查询用户列表（分页）
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    @ResponseBody
    public PageResult search(int page, int rows, String searchEntity) {
        try {
            List<User> userList;
            int total;
            
            if (searchEntity != null && !searchEntity.trim().equals("")) {
                // 条件查询
                User user = new User();
                user.setUserName(searchEntity);
                userList = userService.getAllUsers();
                total = userList.size();
            } else {
                // 分页查询所有
                userList = userService.getUsersByPage(page, rows);
                total = userService.getUserCount();
            }
            
            return new PageResult(total, userList);
        } catch (Exception e) {
            e.printStackTrace();
            return new PageResult(0, null);
        }
    }
    
    /**
     * 根据ID查询用户
     */
    @RequestMapping(value = "/getUserById", method = RequestMethod.GET)
    @ResponseBody
    public User getUserById(String userId) {
        return userService.findUserById(userId);
    }
    
    /**
     * 更新用户
     */
    @RequestMapping(value = "/updateUser", method = RequestMethod.POST)
    @ResponseBody
    public Result updateUser(@RequestBody User user) {
        try {
            userService.updateUser(user);
            return new Result(true, "更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "更新失败：" + e.getMessage());
        }
    }
    
    /**
     * 删除用户
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestBody String[] ids) {
        try {
            for (String id : ids) {
                userService.deleteUser(id);
            }
            return new Result(true, "删除成功");
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false, "删除失败");
        }
    }
}
