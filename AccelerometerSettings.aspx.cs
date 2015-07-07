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
            if (Session["AccLinearAcceleration"] != null && Session["AccAngularAcceleration"] != null)
            {
                //Fill the textbox with the acceleration settings
                LinearAcceleration.Value = Session["AccLinearAcceleration"].ToString();
                AngularAcceleration.Value = Session["AccAngularAcceleration"].ToString();
            }
        }
    }
    protected void SaveProperties(object sender, EventArgs e)
    {
        //Check if all the fields have been completed
        if (LinearAcceleration.Value != "" && AngularAcceleration.Value != "")
        {
            //Save the acceleration settings
            Session["AccLinearAcceleration"] = LinearAcceleration.Value;
            Session["AccAngularAcceleration"] = AngularAcceleration.Value;
            Response.Redirect("Accelerometer.aspx");
        }
        else
        {
            //Raise an error message if some fields are empty
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Materialize.toast('" + "All fields are mandatory" + "', 5000);", true);
        }
    }
}