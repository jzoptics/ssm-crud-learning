<%--
  Created by IntelliJ IDEA.
  User: xz
  Date: 2020/7/2
  Time: 0:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>index</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <%--   web路径：
                不以/开始的相对路径，找资源是以当前资源的路径为基准，经常容易出问题
                而以/开始的相对路径，是以服务器的路径为标注的（http://localhost:3306），需要加上项目名
                        http://localhost:3306/crud
       --%>
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div id="pageInfo">
    <div class="container">
        <%--    标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>

        <%--    新增/删除 按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-info">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>

        <%--    显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <tr v-for="(emp,index) in pageInfo.list">
                        <th>{{emp.empId}}</th>
                        <th>{{emp.empName}}</th>
                        <th>{{emp.gender}}</th>
                        <th>{{emp.email}}</th>
                        <th>{{emp.department.deptName}}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
    <script>
        var vue = new Vue({
            el: '#pageInfo',
            data: {
                pageInfo: {},
                depts:{},
                inputForm:{
                    empId:'',
                    empName:'',
                    email:'',
                    gender:'M',
                    dId:'1',
                    department:{
                        deptId:'1',
                        deptName:'开发部'
                    }
                }
            },

            created: function () {
                $.ajax({
                    type:"get",
                    url: "empss/",
                    data:{pn:1},
                    success: function (result) {
                        //alert(data);
                        vue.pageInfo = result.pageInfo;
                        //判断json集合里面的每个对象的gender值 如果是M 就改成女 渲染在页面上 如果是F就改成男
                        for(var i=0;i<vue.pageInfo.list.length;i++){
                            if(vue.pageInfo.list[i].gender=='M'){
                                vue.pageInfo.list[i].gender='男';
                            }else if(vue.pageInfo.list[i].gender=='F'){
                                vue.pageInfo.list[i].gender='女';
                            }
                        }
                    },

                });
            },
        })
    </script>
</body>
</html>
