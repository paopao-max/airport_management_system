<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>机票管理系统 - 管理员登录</title>
    <link rel="stylesheet" href="/css/admin/login.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h2>机票管理系统</h2>
            <h3>管理员登录</h3>
            <form id="loginForm">
                <div class="form-group">
                    <label for="adminName">用户名：</label>
                    <input type="text" id="adminName" name="adminName" required>
                </div>
                <div class="form-group">
                    <label for="adminPwd">密码：</label>
                    <input type="password" id="adminPwd" name="adminPwd" required>
                </div>
                <button type="submit" class="login-btn">登录</button>
            </form>
        </div>
    </div>
    
    <script src="/js/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#loginForm').submit(function(e) {
                e.preventDefault();
                
                var adminName = $('#adminName').val();
                var adminPwd = $('#adminPwd').val();
                
                if (!adminName || !adminPwd) {
                    alert('请输入用户名和密码');
                    return;
                }
                
                // 模拟登录验证
                if (adminName === 'admin' && adminPwd === 'admin') {
                    alert('登录成功');
                    window.location.href = '/flightManage/list';
                } else {
                    alert('用户名或密码错误');
                }
            });
        });
    </script>
</body>
</html>
