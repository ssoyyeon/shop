<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/header.jsp"%>
<div class="container">
	<h2>Form control: input</h2>
	<p>The form below contains two input elements; one of type text and one of type password:</p>
	<form action="/action_page.php">
		<div class="form-group">
			<label for="customer_id">CUSTOMER ID:</label>
			<input type="text" class="form-control" id="customer_id" name="customer_id">
		</div>
		<div class="form-group">
			<label for="customer_pass">CUSTOMER PASSWORD:</label>
			<input type="password" class="form-control" id="customer_pass" name="customer_pass">
		</div>
		<div class="form-group">
			<label for="customer_name">CUSTOMER NAME:</label>
			<input type="text" class="form-control" id="customer_name" name="customer_name">
		</div>
		<div class="form-group">
			<label for="customer_address">CUSTOMER ADDRESS:</label>
			<input type="text" class="form-control" id="usr" name="customer_address">
		</div>
		<div class="form-group">
			<label for="customer_telephone">CUSTOMER TELEPHONE:</label>
			<input type="text" class="form-control" id="customer_telephone" name="customer_telephone">
		</div>
		<button type="submit" class="btn btn-primary">Submit</button>
	</form>
</div>
<%@ include file="/inc/footer.jsp"%>
</body>
</html>