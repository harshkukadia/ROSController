<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="VirtualJoystick.aspx.cs" Inherits="ext" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--Style tag for responsive iframe--%>
    <style type="text/css">
        body, html
        {
            margin: 0; padding: 0; height: 100%; overflow: hidden;
        }

        #content
        {
            position:absolute; left: 0; right: 0; bottom: 0; top: 64px; 
        }
    </style>
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
                <a href="VirtualJoystickSettings.aspx" class="hide-on-large-only right"><i class="mdi-action-settings"></i></a>
                <ul class="side-nav" id="mobile-demo">
                    <li>
                        <div class="row">
                            <div class="col s6"><a href="ControlTypes.aspx"><i class="mdi-hardware-keyboard-backspace"></i></a></div>
                            <div class="col s6"><a href="Default.aspx"><i class="mdi-action-home"></i></a></div>
                        </div>
                    </li>
                    <li><a href="VirtualJoystickSettings.aspx"><i class="mdi-action-settings left"></i>Settings</a></li>
                    <li><a href="DualVirtualJoystick.aspx"><i class="mdi-image-hdr-weak left"></i>Dual Virtual Joysticks</a></li>
                    <li><a href="Accelerometer.aspx"><i class="mdi-hardware-phone-android left"></i>Accelerometer</a></li>
                    <li><a href="Keyboard.aspx"><i class="mdi-hardware-keyboard left"></i>Keyboard</a></li>
                </ul>
                
                <%--Buttons shown on Desktop instead of slide out menu--%>
                <a href="ControlTypes.aspx" class="hide-on-med-and-down left"><i class="mdi-hardware-keyboard-backspace"></i></a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="VirtualJoystickSettings.aspx"><i class="mdi-action-settings left"></i>Settings</a></li>
                    <li><a class="dropdown-button" href="#!" data-activates="ControllerDropdown"><i class="mdi-navigation-arrow-drop-down left"></i>Change Controller</a></li>
                    <ul id='ControllerDropdown' class='dropdown-content'>
                        <li><a href="DualVirtualJoystick.aspx">Dual Virtual Joysticks</a></li>
                        <li><a href="Accelerometer.aspx">Accelerometer</a></li>
                        <li><a href="Keyboard.aspx">Keyboard</a></li>
                    </ul>
                </ul>

            </div>
        </nav>
    </header>

    <div class="container">
        <br />

        <%--Controller Name--%>
        <h4 class="center-align center">Virtual Joystick</h4>
        <br /> 
        <%--Information--%>
        <p class="center-align flow-text hide-on-large-only">Touch anywhere on the screen and drag to move the virtual joystick<br /><br />You can change your settings by clicking the gear icon in the top right corner</p>
        <p class="center-align flow-text hide-on-med-and-down">Touch/Click anywhere on the screen and drag to move the virtual joystick<br /><br />You can change your settings by clicking on settings in the top right corner</p>
    </div>

        <!--Modal to be triggered when no touchscreen is found-->
    <div id="TouchScreenWarningModal" class="modal">
        <div class="modal-content">
            <div class="container">
                <!--Warning text-->
                <h6 class="center-align center">
                    You are accessing this page from a non-touchscreen device. For best results, it is recommended to use a touchscreen device.<br />
                    <br /><a href="ControlTypes.aspx">Click here if you want to go back</a><br />
                    <br />This warning will automatically dismiss in 10 seconds. If it doesn't, please click anywhere on the page to dismiss it!
                </h6>
            </div>
        </div>
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
                <h6 class="center-align center">The connection to the websocket server was closed.<br /><br /><a href="Default.aspx">You will be automatically redirected to the server details page in 5 seconds. If you are not automatically redirected, please click here!</a></h6>

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
                <h6 class="center-align center">There was some error connecting the websocket server.<br /><br /><a href="Default.aspx">You will be automatically redirected to the server details page in 5 seconds. If you are not automatically redirected, please click here!</a></h6>

            </div>
        </div>
    </div>

    <%--Hidden controls to pass data to the iframe--%>
    <asp:Literal id="HiddenElements"  runat="server" />

    <!--Script to connect to the server, read joystick data and send messages to the server-->
    <script>

        function ConnectionError() {
            $('#ConnectionErrorModal').openModal({ dismissible: false });   //Displays error message on the screen
            window.setTimeout(function () { window.location.href = 'Default.aspx'; }, 5000);  //Redirects the page to the Default page
        }

        function ConnectionClose() {
            $('#ConnectionCloseModal').openModal({ dismissible: false });   //Displays error message on the screen
            window.setTimeout(function () { window.location.href = 'Default.aspx'; }, 5000);  //Redirects the page to the Default page
        }

        function TouchScreenWarning() {
            $('#TouchScreenWarningModal').openModal();   //Displays warning message on the screen
            setInterval(function () { $('#TouchScreenWarningModal').closeModal(); }, 10000);
        }
    </script>

    <%--Initialize iframe--%>
    <div id="content">
        <iframe width="100%" height="100%" frameborder="0" src="VirtualJoystick.html"> </iframe>
    </div>

</asp:Content>

