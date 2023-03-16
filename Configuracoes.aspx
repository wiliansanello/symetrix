<%@ Page Title="Symetrix - Cadastro de Configurações" Language="C#" MasterPageFile="~/Default_adm.master" %>

<script runat="server">
    int op = 0;
                
    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default_adm.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
         
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["idUser"] = GridView1.SelectedRow.Cells[1].Text;
    }
        
    
    protected void btnAlterar_Click(object sender, EventArgs e)
    {
        op = 2;
        Session["op"] = op;
        Response.Redirect("~/CadastroConfig.aspx");                
    }

    protected void btnIncluir_Click(object sender, EventArgs e)
    {
        op = 1;
        Session["op"] = op;
        Response.Redirect("~/CadastroConfig.aspx");
    }

    protected void btnExcluir_Click(object sender, EventArgs e)
    {
        op = 3;
        Session["op"] = op;
        Response.Redirect("~/CadastroConfig.aspx");           
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="margin-left: 0px; background-color: #FFFFFF;">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="XX-Large" Text="Cadastro de Configurações" Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        <br />&nbsp;&nbsp;&nbsp;
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="INU_ID" DataSourceID="Usuario" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" Font-Names="Segoe UI" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" style="margin-left: 318px">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="INU_ID" HeaderText="ID" ReadOnly="True" SortExpression="INU_ID" />
                <asp:BoundField DataField="INU_NOME" HeaderText="Nome" SortExpression="INU_NOME" />
                <asp:BoundField DataField="INU_EMAIL" HeaderText="Email" SortExpression="INU_EMAIL" />
                <asp:BoundField DataField="INU_LOGIN" HeaderText="Login" SortExpression="INU_LOGIN" />
            </Columns>
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <SortedAscendingCellStyle BackColor="#F4F4FD" />
            <SortedAscendingHeaderStyle BackColor="#5A4C9D" />
            <SortedDescendingCellStyle BackColor="#D8D8F0" />
            <SortedDescendingHeaderStyle BackColor="#3E3277" />
        </asp:GridView>
        <asp:Button ID="btnIncluir" runat="server" Text="Incluir" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" OnClick="btnIncluir_Click" Height="29px" style="margin-top: 19px; margin-left: 516px;" Width="62px" />
&nbsp;
        <asp:Button ID="btnAlterar" runat="server" Text="Alterar" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" OnClick="btnAlterar_Click" Height="29px" Width="64px" />
&nbsp;
        <asp:Button ID="btnExcluir" runat="server" Text="Excluir" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" OnClick="btnExcluir_Click" Height="29px" Width="58px" />
&nbsp;
        <asp:Button ID="btnVoltar" runat="server" OnClick="btnVoltar_Click" Text="Voltar" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" Height="28px" Width="60px" />
        <asp:SqlDataSource ID="Usuario" runat="server" ConnectionString="<%$ ConnectionStrings:IntegNeomixConnectionString %>" SelectCommand="SELECT [INU_ID], [INU_NOME], [INU_EMAIL], [INU_LOGIN] FROM [usuario]"></asp:SqlDataSource>
</div>
</asp:Content>

