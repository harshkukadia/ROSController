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
                if (Session["VJLinearAcceleration"] == null || Session["VJAngularAcceleration"] == null)
                {
                    //Set default settings
                    Session["VJLinearAcceleration"] = "1.0";
                    Session["VJAngularAcceleration"] = "1.0";
                }

                //Pass properties from code behind to the webpage
                HiddenElements.Text = @"<input type=""text"" id=""Name"" value=" + Session["Name"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""ServerAddress"" value=" + Session["ServerAddress"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""Port"" value=" + Session["Port"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""LinearAcceleration"" value=" + Session["VJLinearAcceleration"].ToString() + " style='display: none;'/>";
                HiddenElements.Text = HiddenElements.Text + @"<input type=""text"" id=""AngularAcceleration"" value=" + Session["VJAngularAcceleration"].ToString() + " style='display: none;'/>";
            }
        }
    }
}