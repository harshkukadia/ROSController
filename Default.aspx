<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="head1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>

<asp:Content ID="body1" ContentPlaceHolderID="body" Runat="Server">
    
    <%--Header--%>
    <header>
        <nav>
            <div class="nav-wrapper">

                <%--Application Name--%>
                <a href="Default.aspx" class="brand-logo center"><span class="flow-text">ROS Controller</span></a>

                <%--Slide out navigation menu for mobile and tablet devices--%>
                <a href="#" data-activates="mobile-demo" class="button-collapse left"><i class="mdi-navigation-menu"></i></a>
                <a href="#HistoryModal" class="hide-on-large-only modal-trigger right"><i class="mdi-action-history"></i></a>
                <ul class="side-nav" id="mobile-demo">
                    <li><a href="#HistoryModal" class="modal-trigger"><i class="mdi-action-history left"></i>History</a></li>
                    <li><a href="About.aspx"><i class="mdi-action-info-outline left"></i>About</a></li>
                </ul>

                <%--Buttons shown on Desktop instead of slide out menu--%>
                <ul class="right hide-on-med-and-down">
                    <li><a href="#HistoryModal" class="modal-trigger"><i class="mdi-action-history left"></i>History</a></li>
                    <li><a href="About.aspx"><i class="mdi-action-info-outline left"></i>About</a></li>
                </ul>

            </div>
        </nav>
    </header>
    
    


    <div class="container">
        <div class="row">

            <%--Robot Details Form--%>
            <form class="col s12" runat="server">

                <br />
                <%--Name Field--%>
                <div class="row">
                    <div class="input-field col s12">
                        <i class="mdi-action-android prefix"></i>
                        <input id="Name" type="text" class="validate" runat="server" required/>
                        <label for="Name">Name of the Node</label>
                    </div>
                </div>

                <%--Server Address Field--%>
                <div class="row">
                    <div class="input-field col s12">
                        <i class="mdi-social-public prefix"></i>
                        <input id="ServerAddress" type="text" class="validate" runat="server" required/>
                        <label for="ServerAddress">Websocket Server Address</label>
                    </div>
                </div>

                <%--Server Address Field--%>
                <div class="row">
                    <div class="input-field col s12">
                        <i class="mdi-communication-import-export prefix"></i>
                        <input id="Port" type="number" class="validate" runat="server" required/>
                        <label for="Port">Port</label>

                        <%--Save History Checkbox--%>
                        <p>
                        <asp:CheckBox  class="filled-in" id="HistoryCheckbox" checked="true" runat="server" Text="Save History (Cookies must be enabled)"/>
                        </p>
                        <br />
                    </div>
                </div>

                <%--Submit Button--%>
                <div class="row">
                    <div class="grid-example col s12">
                        <button class="btn waves-effect waves-light"  style="display: block; width: 100%;" type="submit" name="action" runat="server" onserverclick="CreateSession">
                            Submit
                            <i class="mdi-content-send right"></i>
                        </button>
                    </div>
                </div>

                <%--History Modal--%>
                <div id="HistoryModal" class="modal bottom-sheet">
                  <div class="modal-content">
                    <h4 class="center-align">History</h4>
                    <div class="collection">
                        <asp:Panel ID="HistoryPanel" runat="server"></asp:Panel>
                    </div>
                    <a href="#" class="btn waves-effect waves-light left-align" style="display: block; width: 100%;" runat="server" onserverclick="ClearHistory">Clear<i class="mdi-content-clear right"></i></a>
                  </div>
                </div>
            </form>
          </div>
    </div>
</asp:Content>

