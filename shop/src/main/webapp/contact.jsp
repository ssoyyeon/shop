<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<!-- Start Contact Us  -->
<div class="contact-box-main">
	<div class="container">
		<div class="row">
			<div class="col-lg-12"
				style="margin-top: 6%; background-color: #E9EDF1; text-align: center;">
				<h2 style="font-size: 40px; text-align: center; margin-top: 5%;">
					<b>GET IN TOUCHl</b>
				</h2>
				<br> <br>
				<form class="gform" id="sendEmailForm"
					action="https://script.google.com/macros/s/AKfycbzBT3MM8mpiWutlwJX4p4PyhJI0zPihVy7IXkMYq3o5OMu5AOXQ/exec"
					method="POST" data-email="20aachi01@gmail.com">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<input type="text" class="form-control" id="name" name="name"
									placeholder="Your Name" required
									data-error="Please enter your name">
								<div class="help-block with-errors"></div>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<input type="text" placeholder="Your Email" id="email"
									class="form-control" name="name" required
									data-error="Please enter your email">
								<div class="help-block with-errors"></div>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<input type="text" class="form-control" id="subject" name="name"
									placeholder="Subject" required
									data-error="Please enter your Subject">
								<div class="help-block with-errors"></div>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<textarea class="form-control" id="message"
									placeholder="Your Message" rows="4"
									data-error="Write your message" required></textarea>
								<div class="help-block with-errors"></div>
							</div>
							<div class="submit-button text-center"
								style="margin-top: 5%; margin-bottom: 10%;">
								<button class="btn hvr-hover" id="submit" type="button"
									style="background-color: black;">Send Message</button>
								<button class="btn hvr-hover" id="reset" type="reset"
									style="background-color: black;">Reset</button>
								<div id="msgSubmit" class="h3 text-center hidden"></div>
								<div class="clearfix"></div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- End Cart -->
<%@ include file="/inc/footer.jsp"%>
</body>
<script>
	$('#submit').click(function() {
		$('#sendEmailForm').submit();
		alert('감사합니다. 메일이 전송되었습니다.');
		location.href = "<%=request.getContextPath()%>/main.jsp";
	});
</script>
</html>