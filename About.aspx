<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <header>
        <nav>
            <div class="nav-wrapper">
                <a href="Default.aspx" class="brand-logo center"><span class="flow-text">About</span></a>
            </div>
        </nav>
    </header>

<div class="container">
    <ul class="collection">
        <li class="collection-item avatar">
            <img src="images/Harsh-Kukadia.jpg" alt="" class="circle" />
            <span class="title"><b>Harsh Kukadia</b></span>
            <p>Developer<br />King's College London</p>
        </li>
        <li class="collection-item avatar">
            <img src="images/Kaspar-Althoefer.jpg" alt="" class="circle" />
            <span class="title"><b>Prof. Kaspar Althoefer</b></span>
            <p>Project Supervisor<br />King's College London</p>
        </li>
    </ul>
    <h4 class="center-align"><span class="flow-text">Acknowledgements</span></h4>
    <ul class="collapsible popout" data-collapsible="accordion">
        <li>
            <div class="collapsible-header"><i class="mdi-editor-format-paint"></i>Materialize</div>
            <div class="collapsible-body"><p>For providing a modern responsive front-end framework based on Material Design</p></div>
        </li>
        <li>
            <div class="collapsible-header"><i class="mdi-av-web"></i>Google Developer's Guide</div>
            <div class="collapsible-body"><p>For providing web-based app and material ui guidelines</p></div>
        </li>
        <li>
            <div class="collapsible-header"><i class="mdi-hardware-memory"></i>ROS.org</div>
            <div class="collapsible-body"><p>For providing roslibjs - the core JavaScript library for interacting with ROS from the browser</p></div>
        </li>
        <li>
            <div class="collapsible-header"><i class="mdi-hardware-memory"></i>Jerome Etienne</div>
            <div class="collapsible-body"><p>of <a href="http://jetienne.com/">jetienne.com</a> For providing virtualjoystick.js - a JavaScript library for creating virtual joysticks</p></div>
        </li>
    </ul>
    <a href="javascript: history.go(-1)" class="btn waves-effect waves-light left-align" style="display: block; width: 100%;">Close<i class="mdi-content-clear right"></i></a>
</div>
</asp:Content>

