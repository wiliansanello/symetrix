using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default_adm : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = (String)Session["UserName"];
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Contents.RemoveAll();
        Response.Redirect("~/Default.cshtml");
    }
}
