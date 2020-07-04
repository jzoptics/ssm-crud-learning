<%--
  Created by IntelliJ IDEA.
  User: pp
  Date: 2019/3/13
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <%--   web路径：
                不以/开始的相对路径，找资源是以当前资源的路径为基准，经常容易出问题
                而以/开始的相对路径，是以服务器的路径为标注的（http://localhost:3306），需要加上项目名
                        http://localhost:3306/crud
       --%>
    <script src="${APP_PATH}/static/js/vue.min.js"></script>
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div id="pageInfo">
    <!-- 员工新增 -->
    <div class="modal fade" id="empAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" v-model="inputForm.empName" placeholder="empName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" v-model="inputForm.email"  placeholder="email">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" v-model="inputForm.gender" value="M"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" v-model="inputForm.gender" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" v-model="inputForm.dId">
                                    <option v-bind:value="dept.deptId" v-for="dept in depts">{{dept.deptName}}</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" @click="saveEmp()">新增</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 员工修改 -->
    <div class="modal fade" id="empUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" v-model="inputForm.empName" placeholder="empName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" v-model="inputForm.email"  placeholder="email">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" v-model="inputForm.gender" value="M"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" v-model="inputForm.gender" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" v-model="inputForm.dId">
                                    <option v-bind:value="inputForm.department.deptId" v-for="dept in depts">{{dept.deptName}}</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" @click="empUpdate(vue.inputForm.empId)">修改</button>
                </div>
            </div>
        </div>
    </div>
                <%--bootstrap栅格系统--%>
                <div class="container">
                    <%--标题--%>
                    <div class="row">
                        <div class="col-md-12">
                            <h1>SSMCRUD系统</h1>
                        </div>
                    </div>
                    <%--按钮--%>
                    <div class="row">
                        <div class="col-md-4 col-md-offset-8">
                            <button class="btn btn-primary" @click="empAdd()">新增</button>
                            <button class="btn btn-danger">删除</button>
                        </div>
                    </div>
                    <%--表格--%>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table table-hover">
                                <tr>
                                    <th>
                                        <input type="checkbox" @click="deleteAll()">
                                    </th>
                                    <th>#</th>
                                    <th>empName</th>
                                    <th>gender</th>
                                    <th>email</th>
                                    <th>deptName</th>
                                    <th>操作</th>
                                </tr>
                                <tr v-for="(emp,index) in pageInfo.list">
                                    <th>
                                        <input type="checkbox" name="checkDelete">
                                    </th>
                                    <th>{{emp.empId}}</th>
                                    <th>{{emp.empName}}</th>
                                    <th>{{emp.gender}}</th>
                                    <th>{{emp.email}}</th>
                                    <th>{{emp.department.deptName}}</th>
                                    <th>
                                        <button class="btn btn-primary btn-sm" @click="empSave(emp.empId)">
                                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                            编辑
                                        </button>
                                        <button class="btn btn-danger btn-sm" @click="vue.delete(emp.empId)">
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                            删除
                                        </button>
                                    </th>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <%--分页信息--%>
                    <div class="row">
                        <div class="col-md-6">
                            当前页数{{pageInfo.pageNum}},总{{pageInfo.pages}}页,总记录数:{{pageInfo.total}}
                        </div>
                        <div class="col-md-6">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <li :class="{'disabled':pageInfo.isFirstPage}"><a href="javascript:;" @click="jump(1)">首页</a></li>
                                    <li :class="{'disabled':pageInfo.isFirstPage}">
                                        <a href="javascript:;" @click="jump(pageInfo.pageNum-1)" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <%--v-bind:class 同等于 :class--%>
                                    <li :class="{'active':(value==pageInfo.pageNum)}" v-for="value,index in pageInfo.navigatepageNums">
                                        <a href="javascript:;" @click="jump(value)">{{value}}</a>
                                    </li>
                                    <li :class="{'disabled':pageInfo.isLastPage}">
                                        <a href="javascript:;" @click="jump(pageInfo.pageNum+1)" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                    <li :class="{'disabled':pageInfo.isLastPage}"><a href="javascript:;" @click="jump(pageInfo.pages)">末页</a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
</div>
        <script>
            var vue=new Vue({
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
                            vue.pageInfo = result.extend.pageInfo;
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
                methods:{
                    jump:function (value) {
                        if(value<=0){
                            value=1;
                        }else if(value>=vue.pageInfo.pages){
                            value=vue.pageInfo.pages;
                        }
                        $.ajax({
                            type:"get",
                            url: "empss",
                            data:{pn:value},
                            success: function (result) {
                                //alert(data);
                                vue.pageInfo = result.extend.pageInfo;
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
                    empAdd:function () {
                        $(function () {
                            $('#empAdd').modal({
                                backdrop:false
                            })
                        });
                        //每次点击新增按钮要清除上一次的值
                        vue.inputForm={
                            empId:'',
                            empName:'',
                            email:'',
                            gender:'M',
                            dId:'1',
                            department:{
                                deptId:'1',
                                deptName:'开发部'
                            }
                        };
                        $.ajax({
                            type:"get",
                            url:"getDepts",
                            success:function (result) {
                                vue.depts=result;

                            }
                        })
                    },

                    empSave:function (id) {
                        $(function () {
                            $('#empUpdate').modal({
                                backdrop:false
                            })
                        });
                        //每次点击新增按钮要清除上一次的值
                        vue.inputForm={
                            empId:id,
                            empName:'',
                            email:'',
                            gender:'M',
                            dId:'1',
                            department:{
                                deptId:'1',
                                deptName:'开发部'
                            }
                        };
                        $.ajax({
                            type:"get",
                            url:"getDepts",
                            success:function (result) {
                                vue.depts=result;
                            }
                        })
                    },
                    saveEmp:function () {
                        //alert(JSON.stringify(vue.inputForm));
                        $('#empAdd').modal('hide');

                        $.ajax({
                            type:"post",
                            url:"saveEmp",
                            data:JSON.stringify(vue.inputForm),
                            contentType: "application/json",
                            success:function (result) {
                                vue.jump(1);
                            }
                        })
                    },
                    empUpdate:function (id) {

                        $.ajax({
                            type:"put",
                            url:"empUpdate/"+id,
                            data:JSON.stringify(vue.inputForm),
                            contentType: "application/json",
                            success:function (result) {
                                $('#empUpdate').modal('hide');
                                vue.jump(1);
                                //alert(result)
                                // vue.inputForm=result
                            }
                        })
                    },
                    delete:function (id) {

                        $.ajax({
                            type:"delete",
                            url:"delete/"+id,
                            data:{"id":id},
                            contentType: "application/json",
                            success:function (result) {

                                vue.jump(1);
                            }
                        })
                    }

                }
            })
        </script>
</body>
</html>