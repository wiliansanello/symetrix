using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = (String)Session["UserName"];
    }

    
    protected void btnLogout_Click1(object sender, EventArgs e)
    {
        Session.Contents.RemoveAll();
        Response.Redirect("~/Default.cshtml");
    }
}
