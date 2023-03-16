<%@ Page Title="Symetrix - Cadastro de Configurações" Language="C#" MasterPageFile="~/Default_adm.master" %>

<script runat="server">

    string idUser,nome,email,login,senha;
    int grupo = 0;
    int op = 0;
    int id = 0;
    ArrayList usuario;
    int [] privilegio;
                
    protected void Grupo_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
             
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        idUser = (string)Session["idUser"];
        op = (int)Session["op"];
        Cadastro cad = new Cadastro(idUser, op);
        usuario = cad.carregarDados();

        txtNome.Focus();
        
        if (op == 1)
        {
            id = cad.getId();
            txtIdUser.Text = Convert.ToString(id);
        }
            
        else if (op == 2 | op == 3)
        {
            txtLogin.Enabled = false;
            grupo = Convert.ToInt32(usuario[4]);
            txtIdUser.Text = (string)usuario[0];
            txtNome.Text = (string)usuario[1];
            txtEmail.Text = (string)usuario[2];
            cmbGrupo.SelectedValue = Convert.ToString(grupo);
            txtLogin.Text = (string)usuario[3];
            txtSenha.Text = (string)usuario[5];

            ArrayList priv = new ArrayList();
            priv = (ArrayList)usuario[6];

            for (int cont = 0; cont < priv.Count; cont++)
            {
                lbPrivilegio.SelectedIndex = (int)priv[cont];                
            }
            Session["op"] = 4;            
        }
    }

    protected void btnGravar_Click(object sender, EventArgs e)
    {
        Cadastro cad = new Cadastro();
        id = Convert.ToInt32(idUser);
        if (op == 1)
        {
            id = cad.getId();
            nome = txtNome.Text;
            email = txtEmail.Text;
            login = txtLogin.Text;
            grupo = Convert.ToInt32(cmbGrupo.SelectedValue);
            privilegio = lbPrivilegio.GetSelectedIndices();
            senha = txtSenha.Text;
            cad.Inserir(nome,email,login,grupo,privilegio,senha,id);
        }
        else if (op == 4)
        {
            nome = txtNome.Text;
            email = txtEmail.Text;
            grupo = Convert.ToInt32(cmbGrupo.SelectedValue);
            privilegio = lbPrivilegio.GetSelectedIndices();
            senha = txtSenha.Text;
            cad.GravaAlteracao(nome, email, login, grupo, privilegio, senha, id);
        }

        else
        {
            cad.GravaExclusao(id);
        }
        Response.Redirect("~/Configuracoes.aspx");
    }

    protected void cmbGrupo_SelectedIndexChanged(object sender, EventArgs e)
    {
        grupo = cmbGrupo.SelectedIndex;
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void btnSair_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Configuracoes.aspx");
    }
       
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="margin-left: 40px">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="XX-Large" Text="Cadastro de configurações" Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Panel ID="Panel1" runat="server" BackColor="#000066" style="margin-left: 69px" Width="771px" Height="326px">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label4" runat="server" Text="ID " Font-Names="Segoe UI" Font-Bold="True" ForeColor="White"></asp:Label>
            &nbsp;&nbsp;<asp:TextBox ID="txtIdUser" runat="server" Enabled="False" Font-Names="Segoe UI" Height="16px" style="margin-left: 13px; margin-top: 45px" Width="46px" EnableViewState="False"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;<asp:Label ID="Label6" runat="server" Text="Nome" Font-Names="Segoe UI" Font-Bold="True" ForeColor="White"></asp:Label>
            &nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtNome" runat="server" Width="298px" Font-Names="Segoe UI" EnableViewState="False"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNome" ErrorMessage="*O nome deve ser preenchido!" Font-Names="Segoe UI" ForeColor="Red"></asp:RequiredFieldValidator>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;
            <asp:Label ID="Email" runat="server" Font-Bold="True" Font-Names="Segoe UI" ForeColor="White" Text="Email"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" Font-Names="Segoe UI" style="margin-left: 5px; margin-top: 21px;" TextMode="Email" Width="307px"></asp:TextBox>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Names="Segoe UI" ForeColor="White" Text="Grupo"></asp:Label>
            &nbsp;&nbsp;<asp:DropDownList ID="cmbGrupo" runat="server" DataSourceID="Grupo" DataTextField="ING_NOME" DataValueField="ING_ID" Font-Names="Segoe UI" Height="17px" OnSelectedIndexChanged="cmbGrupo_SelectedIndexChanged" style="margin-top: 0px; margin-right: 12px;" Width="199px">
            </asp:DropDownList>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label13" runat="server" Font-Bold="True" Font-Names="Segoe UI" ForeColor="White" Text="Privilégios"></asp:Label>
            <asp:ListBox ID="lbPrivilegio" runat="server" DataSourceID="Privilegio" DataTextField="INP_DESC" DataValueField="INP_ID" Height="64px" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" SelectionMode="Multiple" style="margin-left: 10px" Width="197px"></asp:ListBox>
            &nbsp;&nbsp;
            <asp:Button ID="btnRemover" runat="server" BackColor="#FFFF66" BorderStyle="None" Height="16px" style="margin-left: 0px; margin-right: 10px; margin-bottom: 0px" Text="&lt;" Width="38px" />
            <asp:Button ID="btnAdicionar" runat="server" BackColor="#FFFF66" BorderStyle="None" Height="16px" style="margin-left: 0px; margin-right: 10px; margin-bottom: 0px" Text="&gt;" Width="38px" />
            <asp:ListBox ID="lbPrivilegioSelect" runat="server" Height="64px" SelectionMode="Multiple" style="margin-left: 0px" Width="197px"></asp:ListBox>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br /> &nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Segoe UI" ForeColor="White" Text="Login"></asp:Label>
            <asp:TextBox ID="txtLogin" runat="server" Font-Names="Segoe UI" style="margin-left: 15px; margin-right: 12px" Width="117px"></asp:TextBox>
            <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Names="Segoe UI" ForeColor="White" Text="Senha"></asp:Label>
            <asp:TextBox ID="txtSenha" runat="server" Font-Names="Segoe UI" style="margin-left: 12px" TextMode="Password"></asp:TextBox>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtLogin" ErrorMessage="* O login deve ser preenchido!" Font-Names="Segoe UI" ForeColor="Red"></asp:RequiredFieldValidator>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSenha" ErrorMessage="*A senha deve ser preenchida!" Font-Names="Segoe UI" ForeColor="Red"></asp:RequiredFieldValidator>
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
            <br />
        </asp:Panel>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnGravar" runat="server" Text="Gravar" BackColor="#000066" BorderStyle="None" CssClass="dynamic" Font-Names="Segoe UI" ForeColor="#CCCCCC" style="margin-top: 21px; margin-left: 648px;" OnClick="btnGravar_Click" Height="31px" Width="81px" />
            &nbsp;<asp:Button ID="btnSair" runat="server" Text="Sair" BackColor="#000066" BorderColor="Black" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" Height="32px" Width="61px" OnClick="btnSair_Click" />
        <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:SqlDataSource ID="Grupo" runat="server" ConnectionString="<%$ ConnectionStrings:IntegNeomixConnectionString %>" OnSelecting="Grupo_Selecting" SelectCommand="SELECT [ING_ID], [ING_NOME] FROM [grupo]">
        </asp:SqlDataSource>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <asp:SqlDataSource ID="Privilegio" runat="server" ConnectionString="<%$ ConnectionStrings:IntegNeomixConnectionString %>" SelectCommand="SELECT [INP_ID], [INP_DESC] FROM [privilegio]"></asp:SqlDataSource>
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <br />
        <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
    </div>
</asp:Content>

