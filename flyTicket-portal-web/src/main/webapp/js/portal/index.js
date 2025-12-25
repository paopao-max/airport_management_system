/**
 * 首页AngularJS控制器
 */
var app = angular.module('portalApp', []);

app.controller('indexController', function($scope, $http, $window) {
    $scope.currentUser = null;
    $scope.flights = [];
    $scope.searchParams = {
        startPlace: '',
        endPlace: '',
        startTime: ''
    };
    
    // 检查登录状态
    $scope.checkLogin = function() {
        $http.get('/flyTicket-portal-web/portal/checkLogin').then(
            function(response) {
                if (response.data.success) {
                    $scope.currentUser = response.data.data;
                }
            },
            function(error) {
                console.log('检查登录状态失败', error);
            }
        );
    };
    
    // 加载所有航班
    $scope.loadAllFlights = function() {
        $http.get('/flyTicket-portal-web/portal/getAllFlights').then(
            function(response) {
                if (response.data.success) {
                    $scope.flights = response.data.data;
                } else {
                    console.log('加载航班失败：' + response.data.message);
                }
            },
            function(error) {
                console.log('加载航班失败', error);
            }
        );
    };
    
    // 搜索航班
    $scope.searchFlights = function() {
        var params = [];
        
        if ($scope.searchParams.startPlace) {
            params.push('startPlace=' + encodeURIComponent($scope.searchParams.startPlace));
        }
        
        if ($scope.searchParams.endPlace) {
            params.push('endPlace=' + encodeURIComponent($scope.searchParams.endPlace));
        }
        
        if ($scope.searchParams.startTime) {
            params.push('startTime=' + $scope.searchParams.startTime);
        }
        
        var url = '/flyTicket-portal-web/portal/searchFlights';
        if (params.length > 0) {
            url += '?' + params.join('&');
        }
        
        $http.get(url).then(
            function(response) {
                if (response.data.success) {
                    $scope.flights = response.data.data;
                    if ($scope.flights.length === 0) {
                        alert('没有找到符合条件的航班');
                    }
                } else {
                    alert('搜索失败：' + response.data.message);
                }
            },
            function(error) {
                console.log('搜索失败', error);
                alert('搜索失败，请稍后重试');
            }
        );
    };
    
    // 预订航班
    $scope.bookFlight = function(flightId, grade) {
        if (!$scope.currentUser) {
            alert('请先登录');
            $window.location.href = '/flyTicket-portal-web/portal/toLogin';
            return;
        }
        
        $window.location.href = '/flyTicket-portal-web/portal/toBook?flightId=' + flightId + '&grade=' + grade;
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
    
    // 获取舱位座位数
    $scope.getGradeSeats = function(flight, grade) {
        if (grade === '1') return flight.flightHighNumber;
        if (grade === '2') return flight.flightMiddleNumber;
        if (grade === '3') return flight.flightBaseNumber;
        return 0;
    };
    
    // 检查舱位是否有票
    $scope.hasSeats = function(flight, grade) {
        return $scope.getGradeSeats(flight, grade) > 0;
    };
    
    // 初始化
    $scope.checkLogin();
    $scope.loadAllFlights();
});
