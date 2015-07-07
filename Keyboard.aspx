<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Keyboard.aspx.cs" Inherits="Keyboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">

    <%--Header--%>
    <header>
        <nav>
            <div class="nav-wrapper">

                <%--Application Name--%>
                <a href="Default.aspx" class="brand-logo center">ROS Controller</a>
                
                <%--Slide out navigation menu for mobile and tablet devices--%>
                <a href="#" data-activates="mobile-demo" class="button-collapse left"><i class="mdi-navigation-menu"></i></a>
                <a href="KeyboardSettings.aspx" class="hide-on-large-only right"><i class="mdi-action-settings"></i></a>
                <ul class="side-nav" id="mobile-demo">
                    <li>
                        <div class="row">
                            <div class="col s6"><a href="ControlTypes.aspx"><i class="mdi-hardware-keyboard-backspace"></i></a></div>
                            <div class="col s6"><a href="Default.aspx"><i class="mdi-action-home"></i></a></div>
                        </div>
                    </li>
                    <li><a href="KeyboardSettings.aspx"><i class="mdi-action-settings left"></i>Settings</a></li>
                    <li><a href="VirtualJoystick.aspx"><i class="mdi-hardware-gamepad left"></i>Virtual Joystick</a></li>
                    <li><a href="DualVirtualJoystick.aspx"><i class="mdi-image-hdr-weak left"></i>Dual Virtual Joysticks</a></li>
                    <li><a href="Accelerometer.aspx"><i class="mdi-hardware-phone-android left"></i>Accelerometer</a></li>
                </ul>
                
                <%--Buttons shown on Desktop instead of slide out menu--%>
                <a href="ControlTypes.aspx" class="hide-on-med-and-down left"><i class="mdi-hardware-keyboard-backspace"></i></a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="KeyboardSettings.aspx"><i class="mdi-action-settings left"></i>Settings</a></li>
                    <li><a class="dropdown-button" href="#!" data-activates="ControllerDropdown"><i class="mdi-navigation-arrow-drop-down left"></i>Change Controller</a></li>
                    <ul id='ControllerDropdown' class='dropdown-content'>
                        <li><a href="VirtualJoystick.aspx">Virtual Joystick</a></li>
                        <li><a href="DualVirtualJoystick.aspx">Dual Virtual Joysticks</a></li>
                        <li><a href="Accelerometer.aspx">Accelerometer</a></li>
                    </ul>
                </ul>

            </div>
        </nav>
    </header>

    
    <div class="container">
        <br />

        <%--Controller Name--%>
        <h4 class="center-align center">Keyboard</h4>
        <br /> 
        <%--Information--%>
        <p class="center-align flow-text hide-on-large-only">Press the arrow keys to send command to the server<br /><br />You can change your settings by clicking the gear icon in the top right corner</p>
        <p class="center-align flow-text hide-on-med-and-down">Press the arrow keys to send command to the server<br /><br />You can change your settings by clicking on settings in the top right corner</p>
    </div>



    <!--Modal to be triggered on websocket server connection close-->
    <div id="ConnectionCloseModal" class="modal">
        <div class="modal-content">
            <div class="row ">
                <div class="col s12 center">
                        <!--Preloader-->
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

                <!--Error text-->
                <h6 class="center-align center">The connection to the websocket server was closed.<br /><a href="Default.aspx">You will be automatically redirected to the server details page in 5 seconds. If you are not automatically redirected, please click here!</a></h6>

            </div>
        </div>
    </div>


    <!--Modal to be triggered on websocket server connection error-->
    <div id="ConnectionErrorModal" class="modal">
        <div class="modal-content">
            <div class="row ">
                <div class="col s12 center">

                    <!--Preloader-->
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

                <!--Error text-->
                <h6 class="center-align center">There was some error connecting the websocket server.<br /><a href="Default.aspx">You will be automatically redirected to the server details page in 5 seconds. If you are not automatically redirected, please click here!</a></h6>

            </div>
        </div>
    </div>


    <!--Script to connect to the server, read joystick data and send messages to the server-->
    <script>
        //Assigning session data to the variables
        var Name = '<%= Session["Name"] %>';
        var ServerAddress = '<%= Session["ServerAddress"] %>';
        var Port = '<%= Session["Port"] %>';
        var LinX = parseFloat('<%= Session["KbLinearAcceleration"] %>');
        var AngZ = parseFloat('<%= Session["KbAngularAcceleration"] %>');
        var twist;


        //Function to connect to the websocket server
        try{
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
        catch(err){
            $('#ConnectionErrorModal').openModal({ dismissible: false });   //Displays error message on the screen
            window.setTimeout(function () { window.location.href = 'Default.aspx'; }, 5000);  //Redirects the page to the Default page
        }

        //create a Ros node object to communicate with the server
        var cmdVel = new ROSLIB.Topic({
            ros: con,
            name:  'turtle1/cmd_vel',
            messageType: 'geometry_msgs/Twist'
        });

        var key = {};
        document.addEventListener('keydown', function (e) { key[e.keyCode] = true;}, true);
        document.addEventListener('keyup', function (e) { key[e.keyCode] = false;}, true);

        //Function to send messages to the server on key down event
        function Move() {
            if (key[38] && key[39]) {
                //Forward Right Movement
                twist = new ROSLIB.Message({ "linear": { "x": LinX, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": -AngZ } });
                cmdVel.publish(twist);
            } else if (key[38] && key[37]) {
                //Forward Left Movement
                twist = new ROSLIB.Message({ "linear": { "x": LinX, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": AngZ } });
                cmdVel.publish(twist);
            } else if (key[40] && key[39]) {
                //Backward Right Movement
                twist = new ROSLIB.Message({ "linear": { "x": -LinX, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": -AngZ } });
                cmdVel.publish(twist);
            } else if (key[40] && key[37]) {
                //Backward Left Movement
                twist = new ROSLIB.Message({ "linear": { "x": -LinX, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": AngZ } });
                cmdVel.publish(twist);
            } else if (key[38]) {
                //Forward Movement
                twist = new ROSLIB.Message({ "linear": { "x": LinX, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": 0 } });
                cmdVel.publish(twist);
            } else if (key[40]) {
                //Backward Movement
                twist = new ROSLIB.Message({ "linear": { "x": -LinX, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": 0 } });
                cmdVel.publish(twist);
            } else if (key[39]) {
                //Right Movement
                twist = new ROSLIB.Message({ "linear": { "x": 0, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": -AngZ } });
                cmdVel.publish(twist);
            } else if (key[37]) {
                //Left Movement
                twist = new ROSLIB.Message({ "linear": { "x": 0, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": AngZ } });
                cmdVel.publish(twist);
            } else {
                twist = new ROSLIB.Message({ "linear": { "x": 0, "y": 0, "z": 0 }, "angular": { "x": 0, "y": 0, "z": 0 } });
                cmdVel.publish(twist);
            }
            setTimeout(Move, 10);
        }
        Move();
    </script>
</asp:Content>

