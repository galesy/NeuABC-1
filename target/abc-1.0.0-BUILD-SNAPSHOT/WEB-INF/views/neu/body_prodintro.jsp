<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="calendar_main_content_wrapper pure-u-1">
	<div class="mentor pure-u-1">
        <div class="mentor_box ">
            <div class="mentor">
            	<div class="mentor_line">
                    <div class="step_first"></div>
                    <div class="circle"></div>
                </div>
            </div>
            <div class="mentor_list">
                <div class="list">选择课程套餐</div>
                <div class="list">确认付费</div>
            </div>
        </div>
    </div>
    <div class="box_bg" >
    	<div class="s_calendar_box">
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
                	<a class="btn" href="<%=request.getContextPath()%>/bookclass">免费领取</a>
                </td>
              </tr>
              <tr>
                <td>L13级别定制套餐</td>
                <td>15天</td>
                <td>13课时，精品绘本阅读课</td>
                <td>
                	<p>全程中教服务教师辅导</p>
                    <p>少儿专属练习</p>
                    <p>学员活动1次</p>
                </td>
                <td>
                	<p class="price_now">现价：0元</p>
                	<p class="price">原价：1399元</p>
                </td>
                <td>
                	<a class="btn" href="<%=request.getContextPath()%>/bookclass">免费领取</a>
                </td>
              </tr>
            </table>
            <div>
            	<h1 class="tips">温馨提示：</h1>
                <div class="tips_con">
                    <p>1.各位学员免费配备中教服务教师，全程指导，随时解决学习中的问题。</p>
                    <p>2.所有套餐包含入学测评、学习方法课和但愿总结报告，保证学习效果。</p>
                    <p>3.更有丰富的学员活动课，英语配音等，帮孩子找到学习的伙伴。</p>
                </div>
            </div>
            <div>
            	<h1 class="tips">特别提示：</h1>
                <div class="tips_con">
                    <p>1.套餐到期时未使用的课程将做失效处理，有效期无法延长。</p>
                    <p>2.北美外教一对一课程可根据学员时间随时随地约课。</p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="footer pure-u-1">
	<p class="copyright">Copyright &copy; 2017 NP Technology. All rights reserved. </p>
</div>