<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="calendar_main_content_wrapper pure-u-1">
    <div class="box_bg" >
    	<div class="s_calendar_box calendar_date">
        	<div class="title">L1小学课程套餐（10天内无条件退款）</div>
        	<table border="1" class="s_calendar_courselist">
              <tr class="title">
                <td>套餐名称</td>
                <td>有效期</td>
                <td>课时</td>
                <td>课程服务</td>
                <td>套餐价格</td>
                <td>购买</td>
              </tr>
              <tr>
                <td>L1级别定制套餐</td>
                <td>10天</td>
                <td>7课时，北美外教一对一课程</td>
                <td>
                	<p>全程中教服务教师辅导</p>
                    <p>少儿专属练习</p>
                    <p>学员活动1次</p>
                </td>
                <td>
                	<p class="price_now">现价：0元</p>
                	<p class="price">原价：999元</p>
                </td>
                <td>
                	<p class="btn_over">已购买</p>
                </td>
              </tr>
            </table>
        </div>
    </div>
    <div class="box_bg" >
    	<div class="s_calendar_box">
        	<div class="title">预约上课时间</div>
            <p class="tips">提示：您可以选择7个时间段，至少选择2个预约时间段，才可提交！</p>
            <p class="line"></p>
            <div class="date_box">
            	<div class="date_title">
                	<span class="title">日期/时间</span>
                    <select name="年" class="date_day">
                        <option value ="2019年">2019年</option>
                        <option value ="2018年">2018年</option>
                        <option value ="2017年">2017年</option>
                    </select>
                    <select name="月"  class="date_day">
                        <option value ="1">1月</option>
                        <option value ="2">2月</option>
                        <option value ="3">3月</option>
                        <option value ="4">4月</option>
                        <option value ="5">5月</option>
                        <option value ="6">6月</option>
                        <option value ="7">7月</option>
                        <option value ="8">8月</option>
                        <option value ="9">9月</option>
                        <option value ="10">10月</option>
                        <option value ="11">11月</option>
                        <option value ="12">12月</option>
                    </select>
                    <a href="#" class="next_week">下一周</a>
                </div>
                <div class="date_table">
                	<ul class="date_week">
                    	<li class="sel">
                        	<p>今天</p>
                        	<p>6月21日</p>
                        </li>
                    	<li>
                        	<p>周四</p>
                        	<p>6月22日</p>
                        </li>
                    	<li>
                        	<p>周五</p>
                        	<p>6月23日</p>
                        </li>
                    	<li>
                        	<p>周六</p>
                        	<p>6月24日</p>
                        </li>
                    	<li>
                        	<p>周日</p>
                        	<p>6月25日</p>
                        </li>
                    	<li>
                        	<p>周一</p>
                        	<p>6月26日</p>
                        </li>
                    	<li>
                        	<p>周二</p>
                        	<p>6月27日</p>
                        </li>
                    </ul>
                    <ul class="clock">
                    	<li>00:00</li>
                    	<li>00:30</li>
                    	<li>01:00</li>
                    	<li>01:30</li>
                    	<li>02:00</li>
                    	<li>02:30</li>
                    	<li class="sel"><span class="icon"></span>03:00</li>
                    	<li>03:30</li>
                    	<li>04:00</li>
                    	<li class="disable">04:30</li>
                    	<li>05:00</li>
                    	<li>05:30</li>
                    	<li>06:00</li>
                    	<li>06:30</li>
                    	<li>07:00</li>
                    	<li class="disable">07:30</li>
                    	<li class="disable">08:00</li>
                    	<li class="disable">08:30</li>
                    	<li class="disable">09:00</li>
                    	<li class="disable">09:30</li>
                    	<li class="disable">10:00</li>
                    	<li>10:30</li>
                    	<li>11:00</li>
                    	<li>11:30</li>
                    	<li class="disable">12:00</li>
                    	<li class="disable">12:30</li>
                    	<li class="disable">13:00</li>
                    	<li>13:30</li>
                    	<li>14:00</li>
                    	<li>14:30</li>
                    	<li>15:00</li>
                    	<li>15:30</li>
                    	<li>16:00</li>
                    	<li>16:30</li>
                    	<li>17:00</li>
                    	<li>17:30</li>
                    	<li>18:00</li>
                    	<li>18:30</li>
                    	<li>19:00</li>
                    	<li>19:30</li>
                    	<li>20:00</li>
                    	<li>20:30</li>
                    	<li>21:00</li>
                    	<li>21:30</li>
                    	<li>22:00</li>
                    	<li>22:30</li>
                    	<li>23:00</li>
                    	<li>23:30</li>
                    </ul>
                </div>
                <div class="pure-controls">
                    <p class="calendar_button pure-u-1" ><a href="student-schedule.html" class="pure-u-1-4">提交</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>