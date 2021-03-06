<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="calendar_main_content_wrapper pure-u-1">
    <div class="box_bg" >
    	<div class="s_calendar_box calendar_date">
        	<div class="title">温馨提示：</div>
            <div class="schedule_tips">您下次上课时间是<span class="orange">2016-06-25 08：00</span>，请准时参与上课。</div>
            <p class="line"></p>
            <div class="schedule_tips"><span class="bold">L1级别定制套餐：</span>已上2课时，剩余5课时。</div>
            <a href="#" class="schedule_button">请准时进入教室</a>
        </div>
    </div>
    <div class="box_bg" >
    	<div class="s_calendar_box">
        	<div class="title">我的课表</div>
            <div class="date_box schedule_table_box">
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
                <div class="schedule_table">
                    <div class="left_time">
                        <span>00:00</span>
                        <span>01:00</span>
                        <span>02:00</span>
                        <span>03:00</span>
                        <span>04:00</span>
                        <span>05:00</span>
                        <span>06:00</span>
                        <span>07:00</span>
                        <span>08:00</span>
                        <span>09:00</span>
                        <span>10:00</span>
                        <span>11:00</span>
                        <span>12:00</span>
                    </div>
                    <div class="right_box">
                        <ul class="schedule_date_week">
                            <li>
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
                        <div class="con">
                            <div class="con_list">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <div class="con_list">
                                <span></span>
                                <span></span>
                                <span class="sel recent_sel">
                                    <span class="recent_icon"></span>已预约
                                    <div class="class_details">
                                        <div class="title">课堂详情</div>
                                        <div class="line"></div>
                                        <div class="con">
                                            <p>时间：2017-06-21  02:30-03:00</p>
                                            <p>教师：Ally</p>
                                            <p>课程：L1级别定制套餐</p>
                                            <p>课题：L1.Hans Christian Andersen 课程 </p>
                                        </div>
                                        <a href="#" class="btn_class">请准时进入课堂</a>
                                    </div>
                                    </span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <div class="con_list">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span class="sel">
                                    <span class="icon"></span>已预约
                                    <div class="class_details">
                                        <div class="title">课堂详情</div>
                                        <div class="line"></div>
                                        <div class="con">
                                            <p>时间：2017-06-21  02:30-03:00</p>
                                            <p>教师：Ally</p>
                                            <p>课程：L1级别定制套餐</p>
                                            <p>课题：L1.Hans Christian Andersen 课程 </p>
                                        </div>
                                        <a href="#" class="btn">等待上课</a>
                                        <a href="#" class="btn_cancel">取消上课</a>
                                    </div>
                                </span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <div class="con_list">
                                <span></span>
                                <span></span>
                                <span class="sel"><span class="icon"></span>已预约</span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <div class="con_list">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span class="sel"><span class="icon"></span>已预约</span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <div class="con_list">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                            <div class="con_list con_list_last">
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span class="sel"><span class="icon"></span>已预约</span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
    					</div>
                    </div>
                    <div class="btn_box">
                        <a href="#" class="btn btn_sel">上午</a>
                        <a href="#" class="btn">下午</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>