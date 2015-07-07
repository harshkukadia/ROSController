using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ConnectionCheck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ServerAddress"] == null && Session["Port"] == null)
        {
            Response.Redirect("Default.aspx");
        }
    }
    protected void ConnectionFunction(object sender, EventArgs e)
    {
        if (ConnectionStatus.Value=="Successful")
        {
            Session["ConnectionStatus"]="Successful";
            Response.Redirect("ControlTypes.aspx");
        }
        else if (ConnectionStatus.Value != null)
        {
            Session["ConnectionStatus"] = "Failed";
            Session["ConnectionError"] = ConnectionStatus.Value;
            Response.Redirect("Default.aspx");
        }
    }
}