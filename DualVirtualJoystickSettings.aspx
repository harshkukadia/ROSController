<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DualVirtualJoystickSettings.aspx.cs" Inherits="VirtualJoystickProperties" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        $(document).ready(function () {
            $(".button-collapse").sideNav();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <%--Header--%>
    <header>
        <nav>
            <div class="nav-wrapper">

                <%--Application Name--%>
                <a href="Default.aspx" class="brand-logo center"><span class="flow-text">ROS Controller</span></a>

                <%--Back Button--%>
                <a href="DualVirtualJoystick.aspx" class="left"><i class="mdi-hardware-keyboard-backspace"></i></a>
            </div>
        </nav>
    </header>

    <div class="container">
        <div class="row">

            <%--Acceleration Details Form--%>
            <form class="col s12" runat="server">

                <br />

                <%--Linear Acceleration on X-axis Property Field--%>
                <div class="row">
                    <div class="input-field col s12">
                        <label for="LinearAccelerationX" class="active">Linear Acceleration on X-axis</label>
                        <input runat="server" value="" id="LinearAccelerationX" type="text" class="validate" />
                    </div>
                </div>

                <%--Linear Acceleration on Y-axis Property Field--%>
                <div class="row">
                    <div class="input-field col s12">
                        <label for="LinearAccelerationY" class="active">Linear Acceleration on Y-axis</label>
                        <input runat="server" value="" id="LinearAccelerationY" type="text" class="validate" />
                    </div>
                </div>

                <%--Linear Acceleration on Z-axis Property Field--%>
                <div class="row">
                    <div class="input-field col s12">
                        <label for="LinearAccelerationZ" class="active">Linear Acceleration on Z-axis</label>
                        <input runat="server" value="" id="LinearAccelerationZ" type="text" class="validate" />
                    </div>
                </div>

                <%--Angular Acceleration on X-axis Property Field--%>
                <div class="row">
                    <div class="input-field col s12">
                        <label for="AngularAccelerationZ" class="active">Angular Acceleration on X-axis</label>
                        <input runat="server" value="" id="AngularAccelerationZ" type="text" class="validate" />
                    </div>
                </div>

                <%--Submit Button--%>
                <div class="row">
                    <div class="grid-example col s12">
                        <button class="btn waves-effect waves-light"  style="display: block; width: 100%;" type="submit" name="action" runat="server" onserverclick="SaveProperties">Save
                            <i class="mdi-content-save right"></i>
                        </button>
                    </div>
                </div>

            </form>

        </div>
    </div>
</asp:Content>

