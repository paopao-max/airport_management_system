/**
 * 预订页面AngularJS控制器
 */
var app = angular.module('portalApp', []);

app.controller('bookController', function($scope, $http, $window) {
    $scope.flight = null;
    $scope.grade = '3';
    $scope.order = {
        passengerName: '',
        passengerId: '',
        contactName: '',
        contactPhone: ''
    };
    
    // 获取URL参数
    $scope.getUrlParam = function(name) {
        var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)');
        var r = window.location.search.substr(1).match(reg);
        if (r != null) return decodeURIComponent(r[2]);
        return null;
    };
    
    // 加载航班信息
    $scope.loadFlight = function() {
        var flightId = $scope.getUrlParam('flightId');
        var grade = $scope.getUrlParam('grade');
        
        if (grade) {
            $scope.grade = grade;
        }
        
        if (!flightId) {
            alert('航班ID不能为空');
            $window.location.href = '/flyTicket-portal-web/portal/index';
            return;
        }
        
        $http.get('/flyTicket-portal-web/portal/getFlightById?flightId=' + flightId).then(
            function(response) {
                if (response.data.success) {
                    $scope.flight = response.data.data;
                } else {
                    alert('加载航班信息失败：' + response.data.message);
                    $window.location.href = '/flyTicket-portal-web/portal/index';
                }
            },
            function(error) {
                console.log('加载航班信息失败', error);
                alert('加载航班信息失败');
                $window.location.href = '/flyTicket-portal-web/portal/index';
            }
        );
    };
    
    // 获取舱位名称
    $scope.getGradeName = function(grade) {
        var gradeMap = {
            '1': '头等舱',
            '2': '商务舱',
            '3': '经济舱'
        };
        return gradeMap[grade] || '经济舱';
    };
    
    // 获取舱位价格
    $scope.getGradePrice = function(flight, grade) {
        if (grade === '1') return flight.flightHighPrice;
        if (grade === '2') return flight.flightMiddlePrice;
        if (grade === '3') return flight.flightBasePrice;
        return 0;
    };
    
    // 格式化时间
    $scope.formatTime = function(dateStr) {
        if (!dateStr) return '';
        var date = new Date(dateStr);
        var year = date.getFullYear();
        var month = (date.getMonth() + 1).toString().padStart(2, '0');
        var day = date.getDate().toString().padStart(2, '0');
        var hours = date.getHours().toString().padStart(2, '0');
        var minutes = date.getMinutes().toString().padStart(2, '0');
        return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
    };
    
    // 提交订单
    $scope.submitOrder = function() {
        // 验证乘客姓名
        if (!$scope.order.passengerName) {
            alert('请输入乘客姓名');
            return;
        }
        
        // 验证身份证号
        if (!$scope.order.passengerId) {
            alert('请输入乘客身份证号');
            return;
        }
        
        var idCardRegex = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
        if (!idCardRegex.test($scope.order.passengerId)) {
            alert('身份证号格式不正确');
            return;
        }
        
        // 验证联系人姓名
        if (!$scope.order.contactName) {
            alert('请输入联系人姓名');
            return;
        }
        
        // 验证联系人电话
        if (!$scope.order.contactPhone) {
            alert('请输入联系人电话');
            return;
        }
        
        var phoneRegex = /^1[3-9]\d{9}$/;
        if (!phoneRegex.test($scope.order.contactPhone)) {
            alert('联系人电话格式不正确');
            return;
        }
        
        // 构建订单数据
        var orderData = {
            flightId: $scope.flight.flightId,
            flightNumber: $scope.flight.flightNumber,
            grade: $scope.grade,
            price: $scope.getGradePrice($scope.flight, $scope.grade),
            passengerName: $scope.order.passengerName,
            passengerId: $scope.order.passengerId,
            contactName: $scope.order.contactName,
            contactPhone: $scope.order.contactPhone
        };
        
        // 保存订单到Session
        $http.post('/flyTicket-portal-web/portal/saveOrder', orderData).then(
            function(response) {
                if (response.data.success) {
                    // 跳转到支付页面
                    $window.location.href = '/flyTicket-portal-web/portal/toPay';
                } else {
                    alert('提交订单失败：' + response.data.message);
                }
            },
            function(error) {
                console.log('提交订单失败', error);
                alert('提交订单失败，请稍后重试');
            }
        );
    };
    
    // 返回首页
    $scope.backToIndex = function() {
        $window.location.href = '/flyTicket-portal-web/portal/index';
    };
    
    // 初始化
    $scope.loadFlight();
});
