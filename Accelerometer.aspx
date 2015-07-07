<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Accelerometer.aspx.cs" Inherits="Accelerometer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    
    <%--Header--%>
    <header>
        <nav>
            <div class="nav-wrapper">

                <%--Application Name--%>
                <a href="Default.aspx" class="brand-logo center"><span class="flow-text">ROS Controller</span></a>
                
                <%--Slide out navigation menu for mobile and tablet devices--%>
                <a href="#" data-activates="mobile-demo" class="button-collapse left"><i class="mdi-navigation-menu"></i></a>
                <a href="AccelerometerSettings.aspx" class="hide-on-large-only right"><i class="mdi-action-settings"></i></a>
                <ul class="side-nav" id="mobile-demo">
                    <li>
                        <div class="row">
                            <div class="col s6"><a href="ControlTypes.aspx"><i class="mdi-hardware-keyboard-backspace"></i></a></div>
                            <div class="col s6"><a href="Default.aspx"><i class="mdi-action-home"></i></a></div>
                        </div>
                    </li>
                    <li><a href="AccelerometerSettings.aspx"><i class="mdi-action-settings left"></i>Settings</a></li>
                    <li><a href="VirtualJoystick.aspx"><i class="mdi-hardware-gamepad left"></i>Virtual Joystick</a></li>
                    <li><a href="DualVirtualJoystick.aspx"><i class="mdi-image-hdr-weak left"></i>Dual Virtual Joysticks</a></li>
                    <li><a href="Keyboard.aspx"><i class="mdi-hardware-keyboard left"></i>Keyboard</a></li>
                </ul>
                
                <%--Buttons shown on Desktop instead of slide out menu--%>
                <a href="ControlTypes.aspx" class="hide-on-med-and-down left"><i class="mdi-hardware-keyboard-backspace"></i></a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="AccelerometerSettings.aspx"><i class="mdi-action-settings left"></i>Settings</a></li>
                    <li><a class="dropdown-button" href="#!" data-activates="ControllerDropdown"><i class="mdi-navigation-arrow-drop-down left"></i>Change Controller</a></li>
                    <ul id='ControllerDropdown' class='dropdown-content'>
                        <li><a href="VirtualJoystick.aspx">Virtual Joystick</a></li>
                        <li><a href="DualVirtualJoystick.aspx">Dual Virtual Joysticks</a></li>
                        <li><a href="Keyboard.aspx">Keyboard</a></li>
                    </ul>
                </ul>

            </div>
        </nav>
    </header>


    <div class="container">
        <br />

        <%--Controller Name--%>
        <h4 class="center-align center">Accelerometer</h4>
        <br /> 

        <%--Information--%>
        <p class="center-align flow-text hide-on-large-only">Please make sure that auto screen lock is turned off else the controller won't work properly<br /><br />You can change your settings by clicking the gear icon in the top right corner</p>
        <p class="center-align flow-text hide-on-med-and-down">This controller is not supported on desktops due to lack of accelerometer</p>
    </div>


    <%--Modal to be triggered on websocket server connection close--%>
    <div id="ConnectionCloseModal" class="modal">
        <div class="modal-content">
            <div class="row ">
                <div class="col s12 center">

                    <%--Preloader--%>
                    <div class="preloader-wrapper big active">
                    <div class="spinner-layer spinner-blue-only">
                      <div class="circle-clipper left">
                        <div class="circle"></div>
                      </div><div class="gap-patch">
                        <div class="circle"></div>
                      </div><div class="circle-clipper right">
                        <div class="circle"></div>
                      </div>
                    </div>
                  </div>
                
                </div>
            </div>
            <div class="container">

                <%--Error text--%>
                <h6 class="center-align center">The connection to the websocket server was closed.<br /><br /><a href="Default.aspx">You will be automatically redirected to the server details page in 5 seconds. If you are not automatically redirected, please click here!</a></h6>

            </div>
        </div>
    </div>


    <%--Modal to be triggered on websocket server connection error--%>
    <div id="ConnectionErrorModal" class="modal">
        <div class="modal-content">
            <div class="row ">
                <div class="col s12 center">

                    <%--Preloader--%>
                    <div class="preloader-wrapper big active">
                    <div class="spinner-layer spinner-blue-only">
                      <div class="circle-clipper left">
                        <div class="circle"></div>
                      </div><div class="gap-patch">
                        <div class="circle"></div>
                      </div><div class="circle-clipper right">
                        <div class="circle"></div>
                      </div>
                    </div>
                  </div>
                
                </div>
            </div>
            <div class="container">

                <%--Error text--%>
                <h6 class="center-align center">There was some error connecting the websocket server.<br /><br /><a href="Default.aspx">You will be automatically redirected to the server details page in 5 seconds. If you are not automatically redirected, please click here!</a></h6>

            </div>
        </div>
    </div>


    <%--Script to connect to the server, read accelerometer data and send messages to the server--%>
	<script>
        
        //Assigning session data to the variables
		var Name = '<%= Session["Name"] %>';
		var ServerAddress = '<%= Session["ServerAddress"] %>';
		var Port = '<%= Session["Port"] %>';
	    var MaximumLinear = parseFloat('<%= Session["AccLinearAcceleration"] %>');   //Maximum Linear Velocity
	    var MaximumAngular = parseFloat('<%= Session["AccAngularAcceleration"] %>');   //Maximum Angular Velocity
        var x = 0;
	    var z = 0;
	    var twist


	    //Function to connect to the websocket server
	    try {
	        var con = new ROSLIB.Ros({
	            url: 'ws://' + ServerAddress + ':' + Port
	        });

	        //Function on failed connection to the websocket server
	        con.on('error', function (error) {
	            $('#ConnectionErrorModal').openModal({ dismissible: false });   //Displays error message on the screen
	            window.setTimeout(function () { window.location.href = 'Default.aspx'; }, 5000);  //Redirects the page to the Default page
	        });

	        //Function on connection to the websocket server getting closed
	        con.on('close', function () {
	            $('#ConnectionCloseModal').openModal({ dismissible: false });   //Displays error message on the screen
	            window.setTimeout(function () { window.location.href = 'Default.aspx'; }, 5000);  //Redirects the page to the Default page
	        });

	    }
	    catch (err) {
	        $('#ConnectionErrorModal').openModal({ dismissible: false });   //Displays error message on the screen
	        window.setTimeout(function () { window.location.href = 'Default.aspx'; }, 5000);  //Redirects the page to the Default page
	    }

	    //create a Ros node object to communicate with the server
	    var cmdVel = new ROSLIB.Topic({
		    ros: con,
		    name: Name + '/cmd_vel',
		    messageType: 'geometry_msgs/Twist'
		});

        //Function to read data from accelerometer and process it
		window.addEventListener('devicemotion', function (e) {
			var Acceleration = [e.accelerationIncludingGravity.x, e.accelerationIncludingGravity.y];
			var MaxAcceleration = [MaximumLinear, MaximumAngular];

            //Clip the data to zero in case of minor jerks
			for (var i = 0; i < 2; i++) {
			    if (Math.abs(Acceleration[i]) < 2)
			    {
			        Acceleration[i] = 0;
			    }
			    else
			    {
			        var sign = Math.abs(Acceleration[i]) / Acceleration[i];
			        if (i == 0) Acceleration[i] -= sign * 2;
			        if (sign * Acceleration[i] > 7) Acceleration[i] = sign * 7;
			        Acceleration[i] = MaxAcceleration[i] * Acceleration[i] / 7;
			    }
			}
			x = Acceleration[0];
			z = Acceleration[1];
		});

        //Function to send messages to the server every 0.01 seconds
		setInterval(function () {
			    twist = new ROSLIB.Message({ "angular": { "x": 0, "y": 0, "z": z }, "linear": { "x": x, "y": 0, "z": 0 } });
			cmdVel.publish(twist);
		}, 10);

	</script>


</asp:Content>

