using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Accelerometer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Check if the Acceleration settings exist
            if (Session["AccLinearAcceleration"] == null && Session["AccAngularAcceleration"] == null)
            {
                //Set default settings
                Session["AccLinearAcceleration"] = "1";
                Session["AccAngularAcceleration"] = "1";
            }
        }
    }
}