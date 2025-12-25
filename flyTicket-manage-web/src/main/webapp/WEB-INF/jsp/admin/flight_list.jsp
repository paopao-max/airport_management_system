<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>航班管理 - 机票管理系统</title>
    <link rel="stylesheet" href="/css/admin/common.css">
    <link rel="stylesheet" href="/css/admin/flight_list.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>机票管理系统</h1>
            <div class="user-info">
                <span>管理员</span>
                <a href="/admin/login.jsp">退出</a>
            </div>
        </header>
        
        <nav class="sidebar">
            <ul>
                <li><a href="/flightManage/list">航班管理</a></li>
                <li><a href="/userManage/list">用户管理</a></li>
                <li><a href="/orderManage/list">订单管理</a></li>
            </ul>
        </nav>
        
        <main class="content">
            <div class="toolbar">
                <button class="btn btn-primary" onclick="showAddDialog()">添加航班</button>
                <button class="btn btn-danger" onclick="deleteSelected()">删除选中</button>
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="搜索航班...">
                    <button onclick="searchFlights()">搜索</button>
                </div>
            </div>
            
            <table class="data-table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll"></th>
                        <th>航班号</th>
                        <th>出发城市</th>
                        <th>到达城市</th>
                        <th>出发时间</th>
                        <th>到达时间</th>
                        <th>经济舱价格</th>
                        <th>商务舱价格</th>
                        <th>头等舱价格</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="flightTableBody">
                    <!-- 数据将通过JavaScript动态加载 -->
                </tbody>
            </table>
            
            <div class="pagination">
                <button onclick="prevPage()">上一页</button>
                <span id="pageInfo">第 1 页，共 1 页</span>
                <button onclick="nextPage()">下一页</button>
            </div>
        </main>
    </div>
    
    <!-- 添加/编辑航班对话框 -->
    <div id="flightDialog" class="dialog" style="display: none;">
        <div class="dialog-content">
            <h3 id="dialogTitle">添加航班</h3>
            <form id="flightForm">
                <input type="hidden" id="flightId">
                <div class="form-group">
                    <label>航班号：</label>
                    <input type="text" id="flightNumber" required>
                </div>
                <div class="form-group">
                    <label>出发城市：</label>
                    <input type="text" id="flightStartPlace" required>
                </div>
                <div class="form-group">
                    <label>到达城市：</label>
                    <input type="text" id="flightEndPlace" required>
                </div>
                <div class="form-group">
                    <label>出发机场：</label>
                    <input type="text" id="flightStartAirport" required>
                </div>
                <div class="form-group">
                    <label>到达机场：</label>
                    <input type="text" id="flightEndAirport" required>
                </div>
                <div class="form-group">
                    <label>出发时间：</label>
                    <input type="datetime-local" id="flightStartTime" required>
                </div>
                <div class="form-group">
                    <label>到达时间：</label>
                    <input type="datetime-local" id="flightEndTime" required>
                </div>
                <div class="form-group">
                    <label>经济舱价格：</label>
                    <input type="number" id="flightBasePrice" step="0.01">
                </div>
                <div class="form-group">
                    <label>商务舱价格：</label>
                    <input type="number" id="flightMiddlePrice" step="0.01">
                </div>
                <div class="form-group">
                    <label>头等舱价格：</label>
                    <input type="number" id="flightHighPrice" step="0.01">
                </div>
                <div class="form-group">
                    <label>经济舱座位数：</label>
                    <input type="number" id="flightBaseNumber">
                </div>
                <div class="form-group">
                    <label>商务舱座位数：</label>
                    <input type="number" id="flightMiddleNumber">
                </div>
                <div class="form-group">
                    <label>头等舱座位数：</label>
                    <input type="number" id="flightHighNumber">
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-secondary" onclick="hideDialog()">取消</button>
                </div>
            </form>
        </div>
    </div>
    
    <script src="/js/jquery.min.js"></script>
    <script>
        let currentPage = 1;
        let pageSize = 10;
        let totalPages = 1;
        let selectedIds = [];
        
        $(document).ready(function() {
            loadFlights();
            
            $('#selectAll').change(function() {
                $('input[name="flightCheck"]').prop('checked', $(this).prop('checked'));
                updateSelectedIds();
            });
            
            $('#flightForm').submit(function(e) {
                e.preventDefault();
                saveFlight();
            });
        });
        
        function loadFlights() {
            const searchKey = $('#searchInput').val();
            $.get('/flightManage/search', {
                page: currentPage,
                rows: pageSize,
                searchEntity: searchKey
            }, function(data) {
                if (data.total > 0) {
                    renderFlightTable(data.rows);
                    totalPages = Math.ceil(data.total / pageSize);
                    updatePageInfo();
                } else {
                    $('#flightTableBody').html('<tr><td colspan="10">暂无数据</td></tr>');
                }
            });
        }
        
        function renderFlightTable(flights) {
            let html = '';
            flights.forEach(flight => {
                html += `
                    <tr>
                        <td><input type="checkbox" name="flightCheck" value="${flight.flightId}"></td>
                        <td>${flight.flightNumber}</td>
                        <td>${flight.flightStartPlace}</td>
                        <td>${flight.flightEndPlace}</td>
                        <td>${formatDateTime(flight.flightStartTime)}</td>
                        <td>${formatDateTime(flight.flightEndTime)}</td>
                        <td>¥${flight.flightBasePrice || '-'}</td>
                        <td>¥${flight.flightMiddlePrice || '-'}</td>
                        <td>¥${flight.flightHighPrice || '-'}</td>
                        <td>
                            <button class="btn btn-sm btn-primary" onclick="editFlight('${flight.flightId}')">编辑</button>
                            <button class="btn btn-sm btn-danger" onclick="deleteFlight('${flight.flightId}')">删除</button>
                        </td>
                    </tr>
                `;
            });
            $('#flightTableBody').html(html);
            
            $('input[name="flightCheck"]').change(function() {
                updateSelectedIds();
            });
        }
        
        function updateSelectedIds() {
            selectedIds = [];
            $('input[name="flightCheck"]:checked').each(function() {
                selectedIds.push($(this).val());
            });
        }
        
        function formatDateTime(dateStr) {
            if (!dateStr) return '-';
            const date = new Date(dateStr);
            return date.toLocaleString('zh-CN');
        }
        
        function showAddDialog() {
            $('#dialogTitle').text('添加航班');
            $('#flightForm')[0].reset();
            $('#flightId').val('');
            $('#flightDialog').show();
        }
        
        function editFlight(flightId) {
            $.get('/flightManage/getFlightById', {flightId: flightId}, function(flight) {
                $('#dialogTitle').text('编辑航班');
                $('#flightId').val(flight.flightId);
                $('#flightNumber').val(flight.flightNumber);
                $('#flightStartPlace').val(flight.flightStartPlace);
                $('#flightEndPlace').val(flight.flightEndPlace);
                $('#flightStartAirport').val(flight.flightStartAirport);
                $('#flightEndAirport').val(flight.flightEndAirport);
                $('#flightStartTime').val(formatDateTimeForInput(flight.flightStartTime));
                $('#flightEndTime').val(formatDateTimeForInput(flight.flightEndTime));
                $('#flightBasePrice').val(flight.flightBasePrice);
                $('#flightMiddlePrice').val(flight.flightMiddlePrice);
                $('#flightHighPrice').val(flight.flightHighPrice);
                $('#flightBaseNumber').val(flight.flightBaseNumber);
                $('#flightMiddleNumber').val(flight.flightMiddleNumber);
                $('#flightHighNumber').val(flight.flightHighNumber);
                $('#flightDialog').show();
            });
        }
        
        function formatDateTimeForInput(dateStr) {
            if (!dateStr) return '';
            const date = new Date(dateStr);
            return date.toISOString().slice(0, 16);
        }
        
        function saveFlight() {
            const flightData = {
                flightId: $('#flightId').val(),
                flightNumber: $('#flightNumber').val(),
                flightStartPlace: $('#flightStartPlace').val(),
                flightEndPlace: $('#flightEndPlace').val(),
                flightStartAirport: $('#flightStartAirport').val(),
                flightEndAirport: $('#flightEndAirport').val(),
                flightStartTime: $('#flightStartTime').val(),
                flightEndTime: $('#flightEndTime').val(),
                flightBasePrice: parseFloat($('#flightBasePrice').val()) || null,
                flightMiddlePrice: parseFloat($('#flightMiddlePrice').val()) || null,
                flightHighPrice: parseFloat($('#flightHighPrice').val()) || null,
                flightBaseNumber: parseInt($('#flightBaseNumber').val()) || 0,
                flightMiddleNumber: parseInt($('#flightMiddleNumber').val()) || 0,
                flightHighNumber: parseInt($('#flightHighNumber').val()) || 0
            };
            
            const url = flightData.flightId ? '/flightManage/updateFlight' : '/flightManage/addFlight';
            
            $.ajax({
                url: url,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(flightData),
                success: function(response) {
                    if (response.success) {
                        alert(response.message);
                        hideDialog();
                        loadFlights();
                    } else {
                        alert(response.message);
                    }
                },
                error: function() {
                    alert('操作失败');
                }
            });
        }
        
        function deleteFlight(flightId) {
            if (confirm('确定要删除这个航班吗？')) {
                $.ajax({
                    url: '/flightManage/delete',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify([flightId]),
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            loadFlights();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('删除失败');
                    }
                });
            }
        }
        
        function deleteSelected() {
            if (selectedIds.length === 0) {
                alert('请选择要删除的航班');
                return;
            }
            
            if (confirm('确定要删除选中的航班吗？')) {
                $.ajax({
                    url: '/flightManage/delete',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(selectedIds),
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            loadFlights();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert('删除失败');
                    }
                });
            }
        }
        
        function searchFlights() {
            currentPage = 1;
            loadFlights();
        }
        
        function prevPage() {
            if (currentPage > 1) {
                currentPage--;
                loadFlights();
            }
        }
        
        function nextPage() {
            if (currentPage < totalPages) {
                currentPage++;
                loadFlights();
            }
        }
        
        function updatePageInfo() {
            $('#pageInfo').text(`第 ${currentPage} 页，共 ${totalPages} 页`);
        }
        
        function hideDialog() {
            $('#flightDialog').hide();
        }
    </script>
</body>
</html>
