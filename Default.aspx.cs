using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        for (int i = 1; i <= 20; i++)
        {
            if (Request.Cookies["History" + i.ToString()] != null)
            {
                string tempName = Request.Cookies["History" + i.ToString()]["Name"].ToString();
                string tempServerAddress = Request.Cookies["History" + i.ToString()]["ServerAddress"].ToString();
                string tempPort = Request.Cookies["History" + i.ToString()]["Port"].ToString();
                LinkButton lb = new LinkButton();
                lb.ID = "History" + i.ToString();
                lb.Text = tempName + " (" + tempServerAddress + ":" + tempPort + ")";
                lb.Attributes.Add("runat", "server");
                lb.Attributes.Add("class", "collection-item");
                lb.Command += new CommandEventHandler(this.HistorySession);
                lb.CommandName = "History" + i.ToString();
                lb.CommandArgument = tempName + "," + tempServerAddress + "," + tempPort;
                HistoryPanel.Controls.Add(lb);
            }
            else
            {
                break;
            }
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["ConnectionError"] != null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Materialize.toast('" + "Error connecting to the websocket server" + "', 10000);", true);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "Materialize.toast('" + "Please check all the details and try again" + "', 10000);", true);
                Session["ConnectionError"] = null;
            }
        }
    }
    protected void CreateSession(object sender, EventArgs e)
    {
        //Check if all the fields have been completed
        if (Name.Value != "" && ServerAddress.Value != "" && Port.Value != "")
        {
            if (HistoryCheckbox.Checked == true)
            {
                int count = 0;
                bool duplicate = false;
                for (int i = 1; i <= 20; i++)
                {
                    if (Request.Cookies["History" + i.ToString()] != null)
                    {
                        if (Request.Cookies["History" + i.ToString()]["Name"].ToString() == Name.Value && Request.Cookies["History" + i.ToString()]["ServerAddress"].ToString() == ServerAddress.Value && Request.Cookies["History" + i.ToString()]["Port"].ToString() == Port.Value)
                        {
                            duplicate = true;
                        }
                        count = count + 1;
                    }
                    else
                    {
                        break;
                    }
                }
                if (count != 0)
                {
                    //if (Request.Cookies["History" + i.ToString()]["Name"] != null && Request.Cookies["ServerAddress"][i.ToString()] != null && Request.Cookies["Port"][i.ToString()] != null)
                    //{
                    if (duplicate == false)
                    {
                        count = count + 1;
                        HttpCookie _History = new HttpCookie("History" + count.ToString());
                        _History["Name"] = Name.Value;
                        _History["ServerAddress"] = ServerAddress.Value;
                        _History["Port"] = Port.Value;
                        _History.Expires = DateTime.Now.AddDays(7);
                        Response.Cookies.Add(_History);
                    }
                }
                else
                {
                    HttpCookie _History = new HttpCookie("History1");
                    _History["Name"] = Name.Value;
                    _History["ServerAddress"] = ServerAddress.Value;
                    _History["Port"] = Port.Value;
                    _History.Expires = DateTime.Now.AddDays(7);
                    Response.Cookies.Add(_History);
                }
            }
            Session["Name"] = Name.Value;
            Session["ServerAddress"] = ServerAddress.Value;
            Session["Port"] = Port.Value;
            Response.Redirect("ConnectionCheck.aspx");
        }
        else 
        {
            //Raise an error message if some fields are empty
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "Materialize.toast('" + "All fields are mandatory" + "', 5000);", true);
        }

    }
    protected void HistorySession(object sender, EventArgs e)
    {
        string[] Data = ((LinkButton)sender).CommandArgument.Split(',');
        Session["Name"] = Data[0];
        Session["ServerAddress"] = Data[1];
        Session["Port"] = Data[2];
        Response.Redirect("ConnectionCheck.aspx");
    }
    protected void ClearHistory(object sender, EventArgs e)
    {
        for (int i = 1; i <= 20; i++)
        {
            if (Request.Cookies["History" + i.ToString()] != null)
            {
                Response.Cookies["History" + i.ToString()].Expires = DateTime.Now.AddDays(-7);
            }
            else
            {
                break;
            }
        }
        Response.Redirect("Default.aspx");
    }
}