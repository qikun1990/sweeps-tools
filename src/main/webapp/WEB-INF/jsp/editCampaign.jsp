<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Campaign管理</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<style type="text/css">
table {
	table-layout: fixed;
}

td {
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

.container{
	width:1850px;
}
</style>

<style>
table{
    display: table;
}

table{
    table-layout:fixed;
}


        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 6;
            background: rgba(0, 0, 0, 0.7);
        }
        .overlay td:first-child {
            width: 120px;
        }
        .overlay .con {
            position: absolute;
            width: 1800px;
            min-height: 300px;
            background: #fff;
            left: 50%;
            top: 50%;
            -webkit-transform: translate3d(-50%, -50%, 0);
            transform: translate3d(-50%, -50%, 0);
            /*margin-top: -150px;*/
            padding: 20px;
        }
        
        .con{
        	height:700px;
        	overflow: scroll;
        }
        
        ::-webkit-scrollbar {
			/*隐藏滚轮*/
			display: none;
		}
		
		.table-float{
			float:left;
			//margin-top:30px;
			margin-bottom:30px;
			margin-right:30px;
			//margin-left:30px;
		}
		
</style>


</head>
<body>
	<div class="st">
		<h1>Campaign管理</h1>
	</div>
	<div class="container" id="app">
		<div>
			<input type="text" placeholder="search" @input="search" list="cars"
				class="search">
			<datalist id="cars">
				<option v-for="item in searchlist" :value="item"></option>
			</datalist>
			<input type="button" class="add" @click="add" value="新增">
		</div>

		
<table v-cloak v-for="(item, index) of slist" class="table " style="word-break:break-all; word-wrap:break-all;">

  <thead>
    <tr>
		<th width="5%">ID</th>
		<th width="5%">状态</th>
		<th width="25%">名称</th>
		<th width="15%">国家</th>
		<th width="15%">表达式</th>
		<th width="6%">新鲜度</th>
		<th width="5%">单位</th>
		<th width="15%">是否使用</th>
		<th width="15%">用户意向</th>
		<th width="8%">转化路径</th>
		<th width="12%">追踪CampaignID</th>
		<th width="15%">路径</th>
		<th width="15%">操作</th>
	</tr>
  </thead>
<!-- TODO  把定义的所有值都给出来就不会报错了，不要定义的5个creative，只给了2个creative的值，这样肯定会报错！！！ -->
  <tbody>
    <tr>
		<td>{{index+1}}</td>
		<td>{{item.status}}</td>
		<td>{{item.name}}</td>
		<td>{{item.country}}</td>
		<td>{{item.cronExpression}}</td>
		<td>{{item.interval}}</td>
		<td>{{item.unit}}</td>
		<td>{{item.useIntent}}</td>
		<td>{{item.intent}}</td>
		<td>{{item.convBranch}}</td>
		<td>{{item.trackerCampaignId}}</td>
		<td>{{item.targetUrl}}</td>
		
		<td width="990px"><a href="javascript:;" @click="showOverlay(index)">修改</a> | <a href="javascript:;" @click="del(index)">删除</a> | <a href="javascript:;" @click="copyCampaign(index)">复制</a> | <a href="javascript:;" @click="testCampaign(index)">测试</a></td>
	</tr>
	

	<tr style="color:green;">
	<td></td>
	<td>状态</td>
	<td>名称</td>
	<td>标题</td>
	<td>描述</td>
	<td>图标</td>
	<td>图片</td>
	<td>按钮1</td>
	<td>按钮2</td>
	<tr/>
	<tr v-cloak v-for="(item, index) of item.creatives" style="color:green;">
			<!-- TODO  这里需要记录所有的值 -->
			<td></td>
		<td>{{item.status}}</td>
		<td>{{item.name}}</td>
		<td>{{item.title}}</td>
		<td>{{item.description}}</td>
		<td>{{item.icon}}</td>
		<td>{{item.image}}</td>
		<td>{{item.buttons[0]}}</td>
		<td>{{item.buttons[1]}}</td>
	<tr/>
  </tbody>

</table>
		<model :list='selectedlist' :isactive="isActive" v-cloak
			@change="changeOverlay" @modify="modify"></model>
	</div>
</body>
<script type="text/javascript"
	src="https://unpkg.com/vue@2.3.4/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script type="text/javascript">
    Vue.component('model', {
        props: ['list', 'isactive'],
        template: `<div class="overlay" v-show="isactive">
                        <div class="con">
                        <h2 class="title">Creative编辑</h2>
                        <div class="content">
                        <table>
                        
                        <tr>
                        <td>状态</td>
                        <td>
                        <label><input type="radio" name="status" value="1" v-model="modifylist.status">启动</label>
                        <label><input type="radio" name="status" value="0" v-model="modifylist.status">停止</label>
                        </td>
                        </tr>
                        
                        <tr>
                        <td>名称</td>
                        <td><input type="text" v-model="modifylist.name"></td>
                        </tr>
                        <tr>

                        <tr>
                        <td>国家</td>
                        <td><input type="text" v-model="modifylist.country"></td>
                        </tr>
                        
                        <tr>
                        <td>表达式</td>
                        <td><input type="text" v-model="modifylist.cronExpression"></td>
                        </tr>
                        
                        <tr>
                        <td>新鲜度</td>
                        <td><input type="number" v-model="modifylist.interval"></td>
                        </tr>

                        <tr>
                        <td>单位</td>
                        <td>
                        <select name="unit" v-model="modifylist.unit">
                        	<option value="">===选择时间单位===</option>
	                        <option value="DAY">DAY</option>
	                        <option value="MIN">MIN</option>
                    	</select>
                        <td/>
                        </tr>
                        
                        <tr>
                        <td>是否使用</td>
                        <td>
                        <label><input type="radio" name="useIntent" value="1" v-model="modifylist.useIntent">是</label>
                        <label><input type="radio" name="useIntent" value="0" v-model="modifylist.useIntent">否</label>
                        </td>
                        </tr>
                        
                        <tr>
                        <td>用户意向</td>
                        <td><input type="text" v-model="modifylist.intent"></td>
                        </tr>
                        
                        
                        <tr>
                        <td>转化路径</td>
                        <td>
                        <label><input type="radio" name="convBranch" value="0" v-model="modifylist.convBranch">不使用</label>
                        <label><input type="radio" name="convBranch" value="1" v-model="modifylist.convBranch">本地数据</label>
                        <label><input type="radio" name="convBranch" value="2" v-model="modifylist.convBranch">追踪系统数据</label>
                        </td>
                        </tr>
                        
                        <tr>
                        <td>追踪CampaignID</td>
                        <td><input type="text" v-model="modifylist.trackerCampaignId"></td>
                        </tr>
                        
                        <tr>
                        <td>链接</td>
                        <td><input type="text" v-model="modifylist.targetUrl"></td>
                        </tr>
                        </table>
                        <hr>
                        <table class="table-float">
                        <H1>Creative1</H1>
                        <tr>
                        <td>状态</td>
                        <td>
                        <label><input type="radio" name="status1" value="1" v-model="modifylist.creatives[0].status">启动</label>
                        <label><input type="radio" name="status1" value="0" v-model="modifylist.creatives[0].status">停止</label>
                        </td>
                        </tr>
                        <tr>
                        <td>名称</td>
                        <td><input type="text" v-model="modifylist.creatives[0].name"></td>
                        </tr>
                        <tr>
                        <td>标题</td>
                        <td><input type="text" v-model="modifylist.creatives[0].title"></td>
                        </tr>
                        <tr>
                        <td>描述</td>
                        <td><input type="text" v-model="modifylist.creatives[0].description"></td>
                        </tr>
                        <tr>
                        <td>图标</td>
                        <td><input type="text" v-model="modifylist.creatives[0].icon"></td>
                        </tr>
                        <tr>
                        <td>图片</td>
                        <td><input type="text" v-model="modifylist.creatives[0].image"></td>
                        </tr>
                        <tr>
                        <td>按钮1</td>
                        <td><input type="text" v-model="modifylist.creatives[0].buttons[0]"></td>
                        </tr>
                        <tr>
                        <td>按钮2</td>
                        <td><input type="text" v-model="modifylist.creatives[0].buttons[1]"></td>
                        </tr>
                        </table>
                        <table class="table-float">
                        <H1>Creative2</H1>
                        <tr>
                        <td>状态</td>
                        <td>
                        <label><input type="radio" name="status2" value="1" v-model="modifylist.creatives[1].status">启动</label>
                        <label><input type="radio" name="status2" value="0" v-model="modifylist.creatives[1].status">停止</label>
                        </td>
                        </tr>
                        <tr>
                        <td>名称</td>
                        <td><input type="text" v-model="modifylist.creatives[1].name"></td>
                        </tr>
                        <tr>
                        <td>标题</td>
                        <td><input type="text" v-model="modifylist.creatives[1].title"></td>
                        </tr>
                        <tr>
                        <td>描述</td>
                        <td><input type="text" v-model="modifylist.creatives[1].description"></td>
                        </tr>
                        <tr>
                        <td>图标</td>
                        <td><input type="text" v-model="modifylist.creatives[1].icon"></td>
                        </tr>
                        <tr>
                        <td>图片</td>
                        <td><input type="text" v-model="modifylist.creatives[1].image"></td>
                        </tr>
                        <tr>
                        <td>按钮1</td>
                        <td><input type="text" v-model="modifylist.creatives[1].buttons[0]"></td>
                        </tr>
                        <tr>
                        <td>按钮2</td>
                        <td><input type="text" v-model="modifylist.creatives[1].buttons[1]"></td>
                        </tr>
                        </table>
                        <table class="table-float">
                        <H1>Creative3</H1>
                        <tr>
                        <td>状态</td>
                        <td>
                        <label><input type="radio" name="status3" value="1" v-model="modifylist.creatives[2].status">启动</label>
                        <label><input type="radio" name="status3" value="0" v-model="modifylist.creatives[2].status">停止</label>
                        </td>
                        </tr>
                        <tr>
                        <td>名称</td>
                        <td><input type="text" v-model="modifylist.creatives[2].name"></td>
                        </tr>
                        <tr>
                        <td>标题</td>
                        <td><input type="text" v-model="modifylist.creatives[2].title"></td>
                        </tr>
                        <tr>
                        <td>描述</td>
                        <td><input type="text" v-model="modifylist.creatives[2].description"></td>
                        </tr>
                        <tr>
                        <td>图标</td>
                        <td><input type="text" v-model="modifylist.creatives[2].icon"></td>
                        </tr>
                        <tr>
                        <td>图片</td>
                        <td><input type="text" v-model="modifylist.creatives[2].image"></td>
                        </tr>
                        <tr>
                        <td>按钮1</td>
                        <td><input type="text" v-model="modifylist.creatives[2].buttons[0]"></td>
                        </tr>
                        <tr>
                        <td>按钮2</td>
                        <td><input type="text" v-model="modifylist.creatives[2].buttons[1]"></td>
                        </tr>
                        </table>
                        <table class="table-float">
                        <H1>Creative4</H1>
                        <tr>
                        <td>状态</td>
                        <td>
                        <label><input type="radio" name="status4" value="1" v-model="modifylist.creatives[3].status">启动</label>
                        <label><input type="radio" name="status4" value="0" v-model="modifylist.creatives[3].status">停止</label>
                        </td>
                        </tr>
                        <tr>
                        <td>名称</td>
                        <td><input type="text" v-model="modifylist.creatives[3].name"></td>
                        </tr>
                        <tr>
                        <td>标题</td>
                        <td><input type="text" v-model="modifylist.creatives[3].title"></td>
                        </tr>
                        <tr>
                        <td>描述</td>
                        <td><input type="text" v-model="modifylist.creatives[3].description"></td>
                        </tr>
                        <tr>
                        <td>图标</td>
                        <td><input type="text" v-model="modifylist.creatives[3].icon"></td>
                        </tr>
                        <tr>
                        <td>图片</td>
                        <td><input type="text" v-model="modifylist.creatives[3].image"></td>
                        </tr>
                        <tr>
                        <td>按钮1</td>
                        <td><input type="text" v-model="modifylist.creatives[3].buttons[0]"></td>
                        </tr>
                        <tr>
                        <td>按钮2</td>
                        <td><input type="text" v-model="modifylist.creatives[3].buttons[1]"></td>
                        </tr>
                        </table>
                        <table class="table-float">
                        <H1>Creative5</H1>
                        <tr>
                        <td>状态</td>
                        <td>
                        <label><input type="radio" name="status5" value="1" v-model="modifylist.creatives[4].status">启动</label>
                        <label><input type="radio" name="status5" value="0" v-model="modifylist.creatives[4].status">停止</label>
                        </td>
                        </tr>
                        <tr>
                        <td>名称</td>
                        <td><input type="text" v-model="modifylist.creatives[4].name"></td>
                        </tr>
                        <tr>
                        <td>标题</td>
                        <td><input type="text" v-model="modifylist.creatives[4].title"></td>
                        </tr>
                        <tr>
                        <td>描述</td>
                        <td><input type="text" v-model="modifylist.creatives[4].description"></td>
                        </tr>
                        <tr>
                        <td>图标</td>
                        <td><input type="text" v-model="modifylist.creatives[4].icon"></td>
                        </tr>
                        <tr>
                        <td>图片</td>
                        <td><input type="text" v-model="modifylist.creatives[4].image"></td>
                        </tr>
                        <tr>
                        <td>按钮1</td>
                        <td><input type="text" v-model="modifylist.creatives[4].buttons[0]"></td>
                        </tr>
                        <tr>
                        <td>按钮2</td>
                        <td><input type="text" v-model="modifylist.creatives[4].buttons[1]"></td>
                        </tr>
                        </table>
                        

                        
                        <p>
                        <input type="button" @click="changeActive" value="取消">
                        <input type="button" @click="modify" value="保存">
                        </p>
                        </div>
                        </div>
                    </div>`,
        computed: {
            modifylist() {
                return this.list;
            }
        },
        methods: {
            changeActive() {
                this.$emit('change');
            },
            modify() {
                this.$emit('modify', this.modifylist);
            }
        }
    });
    var app = new Vue({
        el: '#app',
        data: {
            isActive: false,
            selected: -1,
            selectedlist:   {
                "id": 1,
                "name": "Campaign Name",
                "status": 0,
                "targetUrl": "https://www.google.com",
                "startedAt": "2021-10-23T12:20:16.000+00:00",
                "country": "USA",
                "interval": 5,
                "unit": "DAY",
                "useIntent": 0,
                "intent": "Campaign Name",
                "convBranch": 0,
                "trackerCampaignId": "",
                "cronExpression": "0/10 0/60 * * * ?",
                "creatives": [{
                	  'name':'',
                	  'description': '',
                	  'title': '',
                	  'image': '',
                	  'icon':'',
                	  'status': 0,
                	  'buttons':['','']
                	 },{  'name':'',
                		'description': '',
                		'title': '',
                		'image': '',
                		'icon':'',
                		'status': 0,
                		'buttons':['','']
                		 },{  'name':'',
                     		'description': '',
                    		'title': '',
                    		'image': '',
                    		'icon':'',
                    		'status': 0,
                    		'buttons':['','']
                    		 },{  'name':'',
                         		'description': '',
                        		'title': '',
                        		'image': '',
                        		'icon':'',
                        		'status': 0,
                        		'buttons':['','']
                        		 },{  'name':'',
                             		'description': '',
                            		'title': '',
                            		'image': '',
                            		'icon':'',
                            		'status': 1,
                            		'buttons':['','']
                            		 }]
              },
            slist: [],
            searchlist: [],
            list: []
        },
        created() {
            console.log(Date.now());
            this.setSlist(this.list);
        },
        methods: {
			// 修改数据
            async showOverlay(index) {
                this.selected = index;
                this.selectedlist = this.slist[index];// 问题出在这里
                this.changeOverlay();
            },
            // 点击保存按钮
            async modify(arr) {
            	console.log('--------33');
                if (this.selected > -1) {
                    Vue.set(this.list, this.selected, arr);
                    
                    console.log('--------3');
                    console.log(this.selected);
                    console.log('--------3');
                    
                    
                    await axios.post("/modCampaign",arr)
                    .then(function (response) {
                        tmp = response.data;
                        // TODO 打印日志看看
                    }).catch(function (reason) {
                        alert("error:"+reason);
                    });
                    this.selected = -1;
                } else {
                    this.list.push(arr);
                    console.log(this.selected);
                    await axios.post("/addCampaign",arr)
                    .then(function (response) {
                        tmp = response.data;
                    }).catch(function (reason) {
                        alert("error:"+reason);
                    });
                    
                    
                }
                this.setSlist(this.list);
                this.changeOverlay();
            },
            add: function () {
                this.selectedlist = {
                	name: 'Campaign Name',
                	status: '0',
                	targetUrl: 'https://www.google.com',
                    useIntent: 0,
                    intent: "Campaign Name",
                    convBranch: 0,
                    trackerCampaignId: "",
                	cronExpression: '0/10 0/60 * * * ?',
                	country: 'US',
                	interval: '5',
                	unit: 'DAY',
                         "creatives": [{
                       	  'name':'',
                       	  'description': '',
                       	  'title': '',
                       	  'image': '',
                       	  'icon':'',
                       	  'status': 0,
                       	  'buttons':['','']
                       	 },{  'name':'',
                       		'description': '',
                       		'title': '',
                       		'image': '',
                       		'icon':'',
                       		'status':0,
                       		'buttons':['','']
                       		 },{  'name':'',
                         		'description': '',
                        		'title': '',
                        		'image': '',
                        		'icon':'',
                        		'status': 0,
                        		'buttons':['','']
                        		 },{  'name':'',
                             		'description': '',
                            		'title': '',
                            		'image': '',
                            		'icon':'',
                            		'status': 0,
                            		'buttons':['','']
                            		 },{  'name':'',
                                 		'description': '',
                                		'title': '',
                                		'image': '',
                                		'icon':'',
                                		'status': 0,
                                		'buttons':['','']
                                		 }]
                };
                this.isActive = true;
            },
            
            async testCampaign(index) {

                this.selectedlist = this.slist[index];

                await axios.post("/testCampaign",this.selectedlist)
                .then(function (response) {
                    tmp = response.data;
                }).catch(function (reason) {
                    alert("error:"+reason);
                });
                this.slist.splice(index, 1);
                this.setSlist(this.slist);
                
            },
            
            async copyCampaign(index) {
            	
            	if(confirm('确认复制？')==false)return false;

                this.selectedlist = this.slist[index];

                await axios.post("/copyCampaign",this.selectedlist)
                .then(function (response) {
                    tmp = response.data;
                }).catch(function (reason) {
                    alert("error:"+reason);
                });
                this.slist.splice(index, 1);
                this.setSlist(this.slist);
                
            },
            
            // delete list in index location
            async del(index) {

            	if(confirm('确认删除？')==false)return false;
            	
                this.selectedlist = this.slist[index];

                await axios.post("/delCampaign",this.selectedlist)
                .then(function (response) {
                    tmp = response.data;
                }).catch(function (reason) {
                    alert("error:"+reason);
                });
                this.slist.splice(index, 1);
                this.setSlist(this.slist);
                
            },
            changeOverlay() {
                this.isActive = !this.isActive;
            },
            // 获取需要渲染到页面中的数据
            
            async setSlist(arr) {
            	var tmp;
                await axios.post("/getCampaigns")
                    .then(function (response) {
                        tmp = response.data;
                        console.log('--------1');
                        console.log(tmp);
                        console.log('--------1');
                    }).catch(function (reason) {
                        alert("error:"+reason);
                    });
                this.slist = tmp;
                console.log('--------2');
                console.log(this.slist);
                console.log('--------2');
            },
            setSlistNoQuery(arr) {
                this.slist = arr;
            },
            // 搜索
            search(e) {
            	console.log('-----4');
                var v = e.target.value,
                    self = this;
                self.searchlist = [];
                if (v) {
                    var ss = [];
                    console.log('-----5');
                    console.log(this.slist);
                    // 过滤需要的数据
                    this.slist.forEach(function (item) {
                    	// TODO item.name、item.country中的name就是需要搜索的目标！！！
                        if (item.name.indexOf(v) > -1) {
                            if (self.searchlist.indexOf(item.name) == -1) {
                                self.searchlist.push(item.name);
                            }
                            ss.push(item);
                        } else if (item.country.indexOf(v) > -1) {
                            if (self.searchlist.indexOf(item.country) == -1) {
                                self.searchlist.push(item.country);
                            }
                            ss.push(item);
                        }
                    });
                    this.setSlistNoQuery(ss); // 将过滤后的数据给了slist
                } else {
                    // 没有搜索内容，则展示全部数据
                    this.setSlist(this.slist);
                }
            }
        },
        watch: {
        }
    })
</script>
</html>