<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="./menubar.jsp" flush="true" />
<link rel="stylesheet" href="/resources/css/main/main.css">
<!-- 영역지정 다른이름으로 수정 -->
            <section id="counter_two" class="counter_two">
            <div class="overlay">
                <div class="container">
                    <div class="row">
                        <div class="main_counter_two sections text-center">
                            <div class="col-sm-10 col-sm-offset-1">
                                <div class="row">
                                    <div class="col-sm-3 col-xs-12">
                                        <div class="single_counter_two_right">
                                            <i class="glyphicon glyphicon-user"></i>
                                            <h2 class="statistic-counter_two" id="member-counter">3,800</h2>
                                            <p>Members</p>
                                        </div>
                                    </div><!-- End off col-sm-3 -->
                                    <div class="col-sm-3 col-xs-12">
                                        <div class="single_counter_two_right">
                                            <i class="glyphicon glyphicon-home"></i>
                                            <h2 class="statistic-counter_two" id="visitor-counter" ></h2>
                                            <p>Total Visitors</p>
                                        </div>
                                    </div><!-- End off col-sm-3 -->
                                    <div class="col-sm-3 col-xs-12">
                                        <div class="single_counter_two_right">
                                            <i class="glyphicon glyphicon-heart"></i>
                                            <h2 class="statistic-counter_two" id="like-counter"></h2>
                                            <p>Total Likes</p>
                                        </div>
                                    </div><!-- End off col-sm-3 -->
                                    <div class="col-sm-3 col-xs-12">
                                        <div class="single_counter_two_right">
                                            <i class="glyphicon glyphicon-pencil"></i>
                                            <h2 class="statistic-counter_two" id="board-counter"></h2>
                                            <p>Total posts</p>
                                        </div>
                                    </div>
                                </div><!-- End off col-sm-3 -->
                            </div>
                        </div>
                    </div><!-- End off row -->
                </div><!-- End off container -->
            </div><!-- End off overlay -->
        </section><!-- End off Counter section -->

    <div id="contact_area" class="white contents">
    <div class="row">
	    <div class="col-md-2"></div>
	    <div class="col-md-8 middle_contact">
	    <h3><span class="glyphicon glyphicon-phone-alt"></span>&nbsp;Contact us</h3> we love makgeoli!!!</div>
   </div>

<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="well well-sm">
                <form method='post' action='./insertFeedback.ma' >
                
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="name">
                                Name</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span>
                                </span>
                            <input type="text" name="feedback_writer" class="form-control" id="name" placeholder="Enter your name" required="required" />
                            </div>
                        </div>
                     </div>
                 </div>
                 
                 <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="email">
                                Email Address</label>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span>
                                </span>
                                <input type="email" name="feedback_email" class="form-control" id="email" placeholder="Enter your email" required="required" /></div>
                        </div>
                     </div>
                  </div>
                  
                   <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="name">
                                Message</label>
                            <textarea name="feedback_message" id="message" class="form-control" rows="5" cols="25" required="required"
                                placeholder="Message"></textarea>
                        </div>
                    	</div>
                   </div>
                   
               <div class="row">
                    <div class="col-md-12">
                    <div class="form-group">
                        <div class="col-md-12">
                            <button type="submit" class="btn btn-warning pull-right">Send <span class="glyphicon glyphicon-send"></span></button>
                        </div>
                    </div>
                </div>
                </div>
                </form>
            </div>
        </div>
        <div class="col-md-4">
            <form>
            <legend><span class="glyphicon glyphicon-map-marker"></span> Our Location</legend>
            <address>
                <strong>altaltal.com</strong><br>
                Bongcheon-dong meow-load 88<br>
                Gwanakgu Seoul<br>
                <abbr title="Phone">
                    Phone</abbr>
                (+82) 1577 6746
            </address>
            <address>
                Email: <a href="mailto:yaongyaong@gmail.com">yaongyaong@gmail.com</a>
            </address>
            </form>
        </div>
    </div>
</div>
    </div> <!-- white contents -->
<jsp:include page="./footer.jsp" flush="true"></jsp:include>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/waypoints/4.0.1/jquery.waypoints.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Counter-Up/1.0.0/jquery.counterup.min.js"></script>
<script>
$(document).ready(function(){

	function printVisitorCount(){
			
			$('#visitor_check').empty();
			
			$.ajax({
				url: '/altaltal/visitorCount.vi',
				type: 'POST',
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success: function(data){
						$('#visitor-counter').text(data.visitor);
						$('#member-counter').text(data.member);	
						$('#like-counter').text(data.likecount);
						$('#board-counter').text(data.boardcount);
						
						$('.statistic-counter_two').counterUp({
						    delay: 100,
						    time: 2000
						});
				},
				error: function() {alert('ajax 통신실패');}
			});
		}
	
	printVisitorCount();
	
});
</script>
