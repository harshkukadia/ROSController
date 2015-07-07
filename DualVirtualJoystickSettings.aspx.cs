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
            if (Session["DVJLinearAccelerationX"] != null && Session["DVJLinearAccelerationY"] != null && Session["DVJLinearAccelerationZ"] != null && Session["DVJAngularAccelerationZ"] != null)
            {
                //Fill the textbox with the acceleration settings
                LinearAccelerationX.Value = Session["DVJLinearAccelerationX"].ToString();
                LinearAccelerationY.Value = Session["DVJLinearAccelerationY"].ToString();
                LinearAccelerationZ.Value = Session["DVJLinearAccelerationZ"].ToString();
                AngularAccelerationZ.Value = Session["DVJAngularAccelerationZ"].ToString();
            }
        }
    }
    protected void SaveProperties(object sender, EventArgs e)
    {
        //Check if all the fields have been completed
        if (LinearAccelerationX.Value != "" && LinearAccelerationY.Value != "" && LinearAccelerationZ.Value != "" && AngularAccelerationZ.Value != "")
        {
            //Save the acceleration settings
            Session["DVJLinearAccelerationX"] = LinearAccelerationX.Value;
            Session["DVJLinearAccelerationY"] = LinearAccelerationY.Value;
            Session["DVJLinearAccelerationZ"] = LinearAccelerationZ.Value;
            Session["DVJAngularAccelerationY"] = AngularAccelerationZ.Value;
            Response.Redirect("DualVirtualJoystick.aspx");
        }
        else 
        {
            //Raise an error message if some fields are empty
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Materialize.toast('" + "All fields are mandatory" + "', 5000);", true);
        }
    }

}