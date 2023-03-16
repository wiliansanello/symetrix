<%@ Page Title="" Language="C#" MasterPageFile="~/Default_adm.master" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<script runat="server">
       
    ArrayList totais = new ArrayList();

    protected void btnAtualizar_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }

    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default_adm.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Totalizadores tot = new Totalizadores();
        totais=tot.consulta();
        lblNfRep.Text = Convert.ToString(totais[0]); 
        lblNfRej.Text = Convert.ToString(totais[1]);
        lblTitRep.Text = Convert.ToString(totais[2]);                  
    }

    protected void NotaFiscal_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        
    }

    protected void btnContrAdm_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/CargaDados.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="margin-left: 275px">
        <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="X-Large" Text="Monitor de Replicação" Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <asp:Button ID="btnAtualizar" runat="server" style="margin-left: 29px; margin-top: 17px;" Text="Atualizar" OnClick="btnAtualizar_Click" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" Height="31px" Width="84px" />
        <asp:Button ID="btnVoltar" runat="server" style="margin-left: 7px" Text="Voltar" OnClick="btnVoltar_Click" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" Height="31px" Width="74px" />
        <asp:Button ID="btnContrAdm" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="#CCCCCC" style="margin-left: 7px; margin-top: 0px; margin-bottom: 0px" Text="Carga Dados" Height="31px" OnClick="btnContrAdm_Click" />
        <br />
        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Medium" Text="Notas Fiscais" Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="NotaFiscal" GridLines="Horizontal" Font-Names="Segoe UI">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:BoundField DataField="INN_NUM" HeaderText="Número" SortExpression="INN_NUM" />
                <asp:BoundField DataField="INN_SERIE" HeaderText="Série" SortExpression="INN_SERIE" />
                <asp:BoundField DataField="INN_CLIENTE" HeaderText="Cliente" SortExpression="INN_CLIENTE" />
                <asp:BoundField DataField="INN_LOJA" HeaderText="Loja" SortExpression="INN_LOJA" />
                <asp:BoundField DataField="INN_EMISSAO" HeaderText="Emissão" SortExpression="INN_EMISSAO" />
                <asp:BoundField DataField="INN_TOTAL" HeaderText="Valor total" SortExpression="INN_TOTAL" />
                <asp:BoundField DataField="INN_DTAUD" HeaderText="Data Auditoria" SortExpression="INN_DTAUD" />
                <asp:BoundField DataField="MOTIVO_INMT_ID" HeaderText="Motivo rejeição" SortExpression="MOTIVO_INMT_ID" />
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
        <asp:SqlDataSource ID="NotaFiscal" runat="server" ConnectionString="<%$ ConnectionStrings:IntegNeomixConnectionString %>" SelectCommand="SELECT [INN_NUM], [INN_SERIE], [INN_CLIENTE], [INN_LOJA], [INN_EMISSAO], [INN_TOTAL], [INN_DTAUD], [MOTIVO_INMT_ID] FROM [notafiscal] WHERE ([INN_STATUS] = @INN_STATUS)" OnSelecting="NotaFiscal_Selecting">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="INN_STATUS" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="Label5" runat="server" Font-Bold="True" Text="Notas replicadas:  " Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        <asp:Label ID="lblNfRep" runat="server" Text="Label" Font-Names="Segoe UI"></asp:Label>
        <br />
        <asp:Label ID="Label6" runat="server" Font-Bold="True" Text="Notas rejeitadas: " Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        <asp:Label ID="lblNfRej" runat="server" Text="Label" Font-Names="Segoe UI"></asp:Label>
        <br />
        <br />
        <br />
        <asp:Label ID="Label7" runat="server" Font-Bold="True" Text="Contas a receber" Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="ContasReceber" GridLines="Horizontal" Font-Names="Segoe UI">
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:BoundField DataField="NOTAFISCAL_INN_NUM" HeaderText="Número" SortExpression="NOTAFISCAL_INN_NUM" />
                <asp:BoundField DataField="INCR_PARC" HeaderText="Parcela" SortExpression="INCR_PARC" />
                <asp:BoundField DataField="INCR_EMISSAO" HeaderText="Data emissão" SortExpression="INCR_EMISSAO" />
                <asp:BoundField DataField="INCR_TOTAL" HeaderText="Valor" SortExpression="INCR_TOTAL" />
                <asp:BoundField DataField="INCR_DTAUD" HeaderText="Data auditoria" SortExpression="INCR_DTAUD" />
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
        <asp:SqlDataSource ID="ContasReceber" runat="server" ConnectionString="<%$ ConnectionStrings:IntegNeomixConnectionString %>" SelectCommand="SELECT [NOTAFISCAL_INN_NUM], [INCR_PARC], [INCR_EMISSAO], [INCR_TOTAL], [INCR_DTAUD] FROM [contasreceber]"></asp:SqlDataSource>
        <asp:Label ID="Label8" runat="server" Font-Bold="True" Text="Títulos replicados: " Font-Names="Segoe UI" ForeColor="#000066"></asp:Label>
        <asp:Label ID="lblTitRep" runat="server" Text="Label" Font-Names="Segoe UI"></asp:Label>
        <br />
        <br />
    </div>
</asp:Content>

