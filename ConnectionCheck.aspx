<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ConnectionCheck.aspx.cs" Inherits="ConnectionCheck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        $(document).ready(function(){
            $('#PreloaderModal').openModal({ dismissible: false });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    
    <%--Preloader--%>
    <div id="PreloaderModal" class="modal">
        <div class="modal-content">
            <div class="row ">
                <div class="col s12 center">
                <div class="preloader-wrapper center big active">
                    <div class="spinner-layer spinner-blue">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div><div class="gap-patch">
                        <div class="circle"></div>
                    </div><div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                    </div>

                    <div class="spinner-layer spinner-red">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div><div class="gap-patch">
                        <div class="circle"></div>
                    </div><div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                    </div>

                    <div class="spinner-layer spinner-yellow">
                    <div class="circle-clipper left">
                        <div class="circle"></div>
                    </div><div class="gap-patch">
                        <div class="circle"></div>
                    </div><div class="circle-clipper right">
                        <div class="circle"></div>
                    </div>
                    </div>

                    <div class="spinner-layer spinner-green">
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
            <h6 class="center-align center">Please wait while we connect to the websocket server<br /><a href="Default.aspx">Click here if you want to go back and edit the details</a></h6>
        </div>
    </div>
  </div>

    
    <form runat="server">
        
        <%--Hidden Field to store connection status--%>
        <asp:HiddenField id="ConnectionStatus" runat="server" Value="">   </asp:HiddenField>
        
        <%--Hidden Button to trigger Code behind function--%>
        <div style="display: none;">
            <asp:Button ID ="HiddenButton" runat="server" OnClick="ConnectionFunction" />
        </div>

    </form>


    <script type="text/javascript">

        try{
            //Connecting to the server
            var con = new ROSLIB.Ros({
                url: 'ws://' + '<%= Session["ServerAddress"] %>' + ':' + '<%= Session["Port"] %>'
            });

            //Function on connection success
            con.on('connection', function () {
                var ConnStatus = document.getElementById('<%= ConnectionStatus.ClientID %>');
                ConnStatus.value = 'Successful';
                document.getElementById('<%= HiddenButton.ClientID %>').click();
            });

            //Function on connection failure
            con.on('error', function (error) {
                var ConnStatus = document.getElementById('<%= ConnectionStatus.ClientID %>');
                ConnStatus.value = error;
                document.getElementById('<%= HiddenButton.ClientID %>').click();
            });
        }

        catch(err)
        {
            var ConnStatus = document.getElementById('<%= ConnectionStatus.ClientID %>');
            ConnStatus.value = JSON.stringify(err);
            document.getElementById('<%= HiddenButton.ClientID %>').click();
        }
    </script>
</asp:Content>

