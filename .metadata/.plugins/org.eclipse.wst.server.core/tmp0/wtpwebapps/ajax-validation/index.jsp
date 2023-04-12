<html>
    <head>
        <!-- JavaScript code starts from here -->
        <script type="text/javascript">
            var req;
            var target;
            var isIE;

            // (3) JavaScript function in which XMLHttpRequest JavaScript object is created.
            // Please note that depending on a browser type, you create
            // XMLHttpRequest JavaScript object differently.  Also the "url" parameter is not
            // used in this code (just in case you are wondering why it is
            // passed as a parameter).
            //
            function initRequest(url) {
                if (window.XMLHttpRequest) {
                    req = new XMLHttpRequest();
                } else if (window.ActiveXObject) {
                    isIE = true;
                    req = new ActiveXObject("Microsoft.XMLHTTP");
                }
            }

            // (2) Event handler that gets invoked whenever a user types a character
            // in the input form field whose id is set as "userid".  This event
            // handler invokes "initRequest(url)" function above to create XMLHttpRequest
            // JavaScript object.
            //
            function validateUserId() {
                if (!target) target = document.getElementById("userid");
                var url = "validate?id=" + escape(target.value); 
   
                // Invoke initRequest(url) to create XMLHttpRequest object
                initRequest(url);
    
                // The "processRequest" function is set as a callback function.
                // (Please note that, in JavaScript, functions are first-class objects: they
                // can be passed around as objects.  This is different from the way
                // methods are treated in Java programming language.)
                req.onreadystatechange = processRequest;
                req.open("GET", url, true); 
                req.send(null);
            }

            // (4) Callback function that gets invoked asynchronously by the browser
            // when the data has been successfully returned from the server.
            // (Actually this callback function gets called every time the value
            // of "readyState" field of the XMLHttpRequest object gets changed.)
            // This callback function needs to be set to the "onreadystatechange"
            // field of the XMLHttpRequest.
            //
            function processRequest() {
                if (req.readyState == 4) {
                  if (req.status == 200) {
        
                    // Extract "true" or "false" from the returned data from the server.
                    // The req.responseXML should contain either <valid>true</valid> or <valid>false</valid>
                    var message = req.responseXML.getElementsByTagName("valid")[0].childNodes[0].nodeValue;
            
                    // Call "setMessageUsingDOM(message)" function to display
                    // "Valid User Id" or "Invalid User Id" message.
                    setMessageUsingDOM(message);
            
                    // If the user entered value is not valid, do not allow the user to
                    // click submit button.
                    var submitBtn = document.getElementById("submit_btn");
                    if (message == "false") {
                        submitBtn.disabled = true;
                    } else {
                        submitBtn.disabled = false;
                    }
                  }
                }
            }

            // This function is not used for now. You will use this later.
            //
            function setMessageUsingInline(message) {
                mdiv = document.getElementById("userIdMessage");
                if (message == "false") {
                    mdiv.innerHTML = "<div style=\"color:red\">Invalid User Id</div>";
                } else {
                    mdiv.innerHTML = "<div style=\"color:green\">Valid User Id</div>";
                }  
            }

            // (5) Function in which message indicating the validity of the data gets displayed
            // through the "userIdMessage" <div> element.
            //
            function setMessageUsingDOM(message) {
                var userMessageElement = document.getElementById("userIdMessage");
                var messageText;
                if (message == "false") {
                    userMessageElement.style.color = "red";
                    messageText = "Invalid User Id";
                } else {
                    userMessageElement.style.color = "green";
                    messageText = "Valid User Id";
                }
                var messageBody = document.createTextNode(messageText);
                // if the messageBody element has been created simple replace it otherwise
                // append the new element
                
                userMessageElement.innerHTML = messageText;
                /* if (userMessageElement.childNodes[0]) {
                    userMessageElement.replaceChild(messageBody, userMessageElement.childNodes[0]);
                } else {
                    userMessageElement.appendChild(messageBody);
                } */
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
        <hr/>
        <p>
            This example shows how you can use AJAX to do server-side form data validation without
            a page reload.
        </p>
        <p>
            In the form below enter a user id. By default the user ids &quot;greg&quot; and &quot;duke&quot;
            are taken. If you attempt to enter a user id that has been taken an error message will be
            displayed next to the form field and the &quot;Create Account&quot; button will be
            disabled. After entering a valid user id and selecting the &quot;Create Account&quot;
            button that user id  will be added to the list of user ids that are taken.
        </p>
 
        <form name="updateAccount" action="validate" method="post">
            <input type="hidden" name="action" value="create"/>
            <table border="0" cellpadding="5" cellspacing="0">
                <tr>
                    <td><b>User Id:</b></td>
                    <td>
                        <!-- (1) Input form field whose id is set as "userid" and "validateUserId()" function is
                        associated with the onkeyup event -->
                        <input type="text"
                        size="20"  
                        id="userid"
                        name="id"
                        onkeyup="validateUserId()">
                    </td>
                    <!-- The "userIdMessage" div element specifies the location where input validation
                    message gets displayed. -->
                    <td>
                        <div id="userIdMessage"></div>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="2">
                        <input id="submit_btn" type="Submit" value="Create Account">
                    </td>
                    <td></td>
                </tr>
            </table>
        </form>
    </body>
</html>
