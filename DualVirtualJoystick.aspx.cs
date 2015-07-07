using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ext : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Name"] == null || Session["ServerAddress"] == null || Session["Port"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                //Check if the acceleration settings exist
                if (Session["DVJLinearAccelerationX"] == null || Session["DVJAngularAccelerationZ"] == null)
                {
                    //Set default settings
                    Session["DVJLinearAccelerationX"] = "1.0";
                    Session["DVJLinearAccelerationY"] = "1.0";
                    Session["DVJLinearAccelerationZ"] = "1.0";
                    Session["DVJAngularAccelerationZ"] = "1.0";
                }

                //Pass properties from code behind to the webpage
                HiddenElements.Text = @"<input type=""text"" id=""Name"" value=" + Session["Name"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""ServerAddress"" value=" + Session["ServerAddress"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""Port"" value=" + Session["Port"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""DVJLinearAccelerationX"" value=" + Session["DVJLinearAccelerationX"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""DVJLinearAccelerationY"" value=" + Session["DVJLinearAccelerationY"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""DVJLinearAccelerationZ"" value=" + Session["DVJLinearAccelerationZ"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""DVJAngularAccelerationZ"" value=" + Session["DVJAngularAccelerationZ"].ToString() + " style='display: none;'/>";
            }
        }
    }
}