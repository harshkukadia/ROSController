using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Keyboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Check if the Acceleration settings exist
            if (Session["KbLinearAcceleration"] == null && Session["KbAngularAcceleration"] == null)
            {
                //Set default settings
                Session["KbLinearAcceleration"] = "1";
                Session["KbAngularAcceleration"] = "1";
            }
        }

    }
}