<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="ISO-8859-1">
		<script type="text/javascript">

			var request;
			var target;

			function validateUserId() {
				if (!target) target = document.getElementById("userid");
				var url = "validate?id=" + escape(target.value);
				request = new XMLHttpRequest();
				request.onreadystatechange = processRequest;
				request.open("GET", url, true);
				request.send(null);
			}

			function processRequest() {
				if (request.readyState == 4 && request.status == 200) {
					var message = request.responseXML.getElementsByTagName("valid")[0].childNodes[0].nodeValue;

					setMessageUsingDOM(message);

					var submitBtn = document.getElementById("submit_btn");
					if (message == "false") {
						submitBtn.disabled == true;
					} else {
						submitBtn.disabled == false;
					}
				}
			}

			function setMessageUsingDOM(message) {
				var userMessageElement = document.getElementById("userIdMessage");
				var messageText;

				if (message == "false") {
					userMessageElement.style.color = "red";
					messageText = "Invalid User ID";
				} else {
					userMessageElement.style.color = "green";
					messageText = "Valid User ID";
				}

				var messageBody = document.createTextNode(messageText);

				userMessageElement.innerHTML = messageText;
			}

			function disableSubmitBtn() {
				var submitBtn = document.getElementById("submit_btn");
				submitBtn.disabled = true;
			}
		</script>
		<title>Form Data Validation using AJAX</title>
	</head>

	<body onload="disableSubmitBtn()">

		<h1>Form Data Validation using AJAX</h1>
		<hr />
		<p>
			This example shows how you can use AJAX to do server-side form data validation without
			a page reload.
		</p>
		<p>
			In the form below enter a user id. By default the user ids &quot;greg&quot; and &quot;duke&quot;
			are taken. If you attempt to enter a user id that has been taken an error message will be
			displayed next to the form field and the &quot;Create Account&quot; button will be
			disabled. After entering a valid user id and selecting the &quot;Create Account&quot;
			button that user id will be added to the list of user ids that are taken.
		</p>

		<form name="updateAccount" action="validate" method="post">
			<input type="hidden" name="action" value="create"/>
			<table border="0" cellpadding="5" cellspacing="0">
				<tr>
					<td><b>User ID:</b></td>
					<td>
						<input type="text" size="20" id="userid" name="id" onkeyup="validateUserId()"/>
					</td>
					<td>
						<div id="userIdMessage"></div>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="2">
						<input id="submit_btn" type="submit" value="Create Account"/>
					</td>
					<td></td>
				</tr>
			</table>			
		</form>

	</body>

	</html>