using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VirtualJoystickProperties : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //Check if the acceleration settings exist
            if (Session["KbLinearAcceleration"] != null && Session["KbAngularAcceleration"] != null)
            {
                //Fill the textbox with the acceleration settings
                LinearAcceleration.Value = Session["KbLinearAcceleration"].ToString();
                AngularAcceleration.Value = Session["KbAngularAcceleration"].ToString();
            }
        }
    }
    protected void SaveProperties(object sender, EventArgs e)
    {
        //Check if all the fields have been completed
        if (LinearAcceleration.Value != "" && AngularAcceleration.Value != "")
        {
            //Save the acceleration settings
            Session["KbLinearAcceleration"] = LinearAcceleration.Value;
            Session["KbAngularAcceleration"] = AngularAcceleration.Value;
            Response.Redirect("Keyboard.aspx");
        }
        else
        {
            //Raise an error message if some fields are empty
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Materialize.toast('" + "All fields are mandatory" + "', 5000);", true);
        }

    }

}