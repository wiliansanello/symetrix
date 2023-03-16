<%@ Page Title="Controle administrativo - Carga de Dados - Symetrix" Language="C#" MasterPageFile="~/Default_adm.master" %>
<script runat="server">
    
    string user;
    string senha;
    bool autWin;
    List<string> campos = new List<string>();
    int index1 = 0;
    int index2 = 0;
    int nOpc   = 0;
    int indexSel = 0;
    ConexaoBD bd = new ConexaoBD(); 
            
    protected void cmbSelectCarga_SelectedIndexChanged(object sender, EventArgs e)
    {
        user = txtAutorid.Text;
        senha = (string)Session["senha_bd"];//txtSenha.Text;        
        autWin = chkAuthWin.Checked;
        cmbSelectCarga.Enabled = true;
        nOpc = cmbSelectCarga.SelectedIndex;
        ConexaoBD con = new ConexaoBD(user, senha, autWin, nOpc);
        if (cmbSelectCarga.SelectedIndex != 4)
        {
            campos = con.obterCampos();

            /*foreach (string item in campos)
            {
                lbCampos.Items.Remove(item);
                cmbSelectCarga.Items.Remove(item);
            }*/
            lbCampos.Enabled = true;
            indexSel = cmbSelectCarga.SelectedIndex;
            preencherListas(indexSel);            
            btnConectar.Enabled = false;
        }      
    }

    
    protected void chkAuthWin_CheckedChanged1(object sender, EventArgs e)
    {
        if (chkAuthWin.Checked == true)
        {
            txtAutorid.Text = "";
            txtAutorid.Enabled = false;
            txtSenha.Text = "";
            txtSenha.Enabled = false;
        }
        else
        {
            txtAutorid.Enabled = true;
            txtSenha.Enabled = true;            
        }   
    }

    protected void btnConectar_Click(object sender, EventArgs e)
    {
        ArrayList ret;

        user = txtAutorid.Text;
        senha = txtSenha.Text;
        Session["senha_bd"] = senha;
        autWin = chkAuthWin.Checked;
        nOpc = cmbSelectCarga.SelectedIndex;
        ConexaoBD con = new ConexaoBD(user, senha, autWin, nOpc);        
        ret = con.efetuaConexao();

        if ((int)ret[0] == 1)
        {
            con.encerraConexao();
            cmbSelectCarga.Enabled = true;
            btnSelectCampo.Enabled = true;
            btnSelectCampo0.Enabled = true;
            lbCampos.Enabled = true;
            lbCamposSelect.Enabled = true;
            cmbCampo.Enabled = true;
            cmbOperador.Enabled = true;
            txtExpressao.Enabled = true;
            btnAdicionar.Enabled = true;
            txtCond.Enabled = true;
            lbl2.Visible = false;
            txtAutorid.Visible = false;
            lbl3.Visible = false;
            txtSenha.Visible = false;
            chkAuthWin.Visible = false;
            btnConectar.Visible = false;
            btnDesconectar.Visible = true;                           
        }
        else
        {
            Response.Write("Falha na conexão com o banco de dados. "+(string)ret[1]);  
        }        
    }

    protected void lbCamposSelect_SelectedIndexChanged(object sender, EventArgs e)
    {
        //index2 = bd.getIndex2(); 
    }

    protected void btnDesconectar_Click(object sender, EventArgs e)
    {
        int tamList1 = lbCampos.Items.Count;
        int tamList2 = lbCamposSelect.Items.Count;
        int tamList3 = cmbCampo.Items.Count;

        for (int i = tamList1-1; i >= 0; i--)
        {
            lbCampos.Items.RemoveAt(i);            
        }

        for (int i = tamList3 - 1; i >= 0; i--)
        {
            cmbCampo.Items.RemoveAt(i);
        }

        if (tamList2 != 0)
        {
            for (int i = tamList2-1; i >= 0; i--)
            {
                lbCamposSelect.Items.RemoveAt(i);
            }
        }
        cmbSelectCarga.Enabled = false;
        btnSelectCampo.Enabled = false;
        btnSelectCampo.Enabled = false;
        cmbCampo.Enabled = false;
        cmbOperador.Enabled = false;
        txtExpressao.Enabled = false;
        btnAdicionar.Enabled = false;
        txtCond.Enabled = false;            
        lbl2.Visible = true;
        txtAutorid.Text = "";
        txtAutorid.Visible = true;
        lbl3.Visible = true;
        txtSenha.Text = "";
        txtSenha.Visible = true;
        chkAuthWin.Visible = true;
        btnConectar.Visible = true;
        btnDesconectar.Visible = false;

        cmbSelectCarga.SelectedIndex = 0;      
    }     

    protected void lbCampos_SelectedIndexChanged(object sender, EventArgs e)
    {       
        index1 = lbCampos.SelectedIndex;
        bd.setIndex1(index1);      
    }

    protected void btnSelectCampo_Click(object sender, EventArgs e)
    {
        string item = lbCampos.SelectedValue;             
        lbCamposSelect.Items.Add(item);
        lbCampos.Items.Remove(item);        
    }

    protected void btnSelectCampo0_Click(object sender, EventArgs e)
    {
        index1 = bd.getIndex1();     
        lbCampos.Items.Insert(index1, lbCamposSelect.SelectedValue);
        lbCamposSelect.Items.Remove(lbCamposSelect.SelectedValue);        
    }

    protected void btnAnd_Click(object sender, EventArgs e)
    {
        string condicao;
        condicao = txtCond.Text;
        condicao += " AND ";
        cmbCampo.Enabled = true;
        cmbOperador.Enabled = true;
        txtExpressao.Enabled = true;
        btnAdicionar.Enabled = true;
        txtCond.Text = condicao;
    }
    
    protected void btnOr_Click(object sender, EventArgs e)
    {
        string condicao;
        condicao = txtCond.Text;
        condicao += " OR ";
        cmbCampo.Enabled = true;
        cmbOperador.Enabled = true;
        btnAbreAspas.Enabled = true;
        btnFechaAspas.Enabled = true;
        txtExpressao.Enabled = true;
        btnAdicionar.Enabled = true;
        txtCond.Text = condicao;
    }


    
    protected void btnAdicionar_Click(object sender, EventArgs e)
    {
        if (cmbOperador.Text == "%")
        {
            txtCond.Text += cmbCampo.Text + " LIKE " + "%" + txtExpressao.Text;
        }
        else if (cmbOperador.Text == "_%")
        {
            txtCond.Text += cmbCampo.Text + " LIKE " + txtExpressao.Text + "%";
        }
        else if (cmbOperador.Text == "%_%")
        {
            txtCond.Text += cmbCampo.Text + " LIKE " + "%" + txtExpressao.Text + "%";
        }
        else if (cmbOperador.Text == "BETWEEN")
        {
            txtCond.Text += cmbCampo.Text + " BETWEEN(" + txtExpressao.Text;
            btnEntre.Enabled = true;
        }
        else
        {
            txtCond.Text += cmbCampo.Text + cmbOperador.Text + txtExpressao.Text;
        }
        cmbCampo.Enabled = false;
        cmbOperador.Enabled = false;
        txtExpressao.Enabled = false;
        btnAnd.Enabled = true;
        btnOr.Enabled = true;
        btnAbreAspas.Enabled = true;
        btnFechaAspas.Enabled = true;
        btnAdicionar.Enabled = false;
    }

    protected void preencherListas(int indexSel)
    {
        int i = 0;
        int tamList1 = lbCampos.Items.Count;
        int tamList2 = lbCamposSelect.Items.Count;
        if (Convert.ToInt32(Session["indexSel"]) != cmbSelectCarga.SelectedIndex)
        {
            if (!lbCampos.Items.Count.Equals(0) && !cmbCampo.Items.Count.Equals(0))
            {
                for (i = tamList1 - 1; i >= 0; i--)
                {
                    lbCampos.Items.RemoveAt(i);
                    cmbCampo.Items.RemoveAt(i);
                }
                if (tamList2 != 0)
                {
                    for (i = tamList2 - 1; i >= 0; i--)
                    {
                        lbCamposSelect.Items.RemoveAt(i);
                    }
                }
            }
        }
        i = 0;
        if (cmbCampo.Items.Count == 0)
        {
            foreach (string campo in campos)
            {
                if (!cmbCampo.Items.Equals(campos))
                {
                    lbCampos.Items.Add(campos[i]);
                    cmbCampo.Items.Add(campos[i]);
                    i++;
                }
            }
            if (cmbSelectCarga.SelectedIndex.Equals(3))
            {
                lbCampos.Items.RemoveAt(0);
            }
            Session["indexSel"] = indexSel;
        }
    }
           
    protected void btnAbreAspas_Click(object sender, EventArgs e)
    {
        string condicao;
        condicao = txtCond.Text;
        condicao += " (";
        cmbCampo.Enabled = true;
        cmbOperador.Enabled = true;
        btnAbreAspas.Enabled = true;
        btnFechaAspas.Enabled = true;
        txtExpressao.Enabled = true;
        btnAdicionar.Enabled = true;
        txtCond.Text = condicao;

    }

    protected void btnFechaAspas_Click(object sender, EventArgs e)
    {
        string condicao;
        condicao = txtCond.Text;
        condicao += ")";
        cmbCampo.Enabled = true;
        cmbOperador.Enabled = true;
        btnAbreAspas.Enabled = true;
        btnFechaAspas.Enabled = true;
        txtExpressao.Enabled = true;
        btnAdicionar.Enabled = true;
        if (btnEntre.Enabled = true)
        {
            btnEntre.Enabled = false;
        }
        txtCond.Text = condicao;
    }

    protected void btnEntre_Click(object sender, EventArgs e)
    {
        string condicao;
        condicao = txtCond.Text;
        condicao += " AND ";
        txtCond.Text = condicao;
        cmbCampo.Enabled = true;
        cmbOperador.Enabled = true;
        txtExpressao.Enabled = true;
        btnAbreAspas.Enabled = false;
        btnFechaAspas.Enabled = false;
        btnEntre.Enabled = false;
        btnAdicionar.Enabled = true;     
    }

    protected void btnLimpar_Click(object sender, EventArgs e)
    {
        txtCond.Text = "";
        cmbCampo.Enabled = true;
        cmbOperador.Enabled = true;
        txtCond.Enabled = true;
        btnAbreAspas.Enabled = true;
        btnAdicionar.Enabled = true;        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        ArrayList ret = new ArrayList();
        ArrayList cpos = new ArrayList();
        ConexaoBD con = new ConexaoBD(user, senha, autWin, nOpc);
        string tab = "";
        ret = con.efetuaConexao();
        if (cmbSelectCarga.SelectedIndex.Equals(2))
        {
            tab = "contas_receber";
        }
        else if (cmbSelectCarga.SelectedIndex.Equals(3))
        {
            tab = "clientes";
        }
        else if (cmbSelectCarga.SelectedIndex.Equals(4))
        {
            tab = "completa";
        }
        for (int i = 0; i < lbCamposSelect.Items.Count; i++)
        {
            cpos.Add(lbCamposSelect.Items[i].Text);
        }
        string connect = "Data Source=.\\SQLENTERPRISE;Initial Catalog=KP_Neomix;User ID=sa;Password=S@lpic@o";
        string msg = "";
        TransporteDados td = new TransporteDados(connect,tab,cpos,txtCond.Text);
        msg = td.redirecionar();
        Response.Write(msg);
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="height: 756px; width: 1147px; margin-left: 81px; margin-top: 25px">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Names="Segoe UI" Font-Size="X-Large" ForeColor="#000066" Text="Controle de replicação"></asp:Label>
        <br />
        <br />
        <br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <div style="height: 218px; width: 352px; margin-left: 366px">
            <asp:Panel ID="Panel3" runat="server" BackColor="#FFFF66" Height="216px" style="margin-top: 0px">
                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Segoe UI" Text="Autenticação no Banco de Dados"></asp:Label>
                <br />
                <br />
                <asp:Label ID="lbl2" runat="server" Font-Names="Segoe UI" Text="Usuário"></asp:Label>
                <asp:TextBox ID="txtAutorid" runat="server" Font-Names="Segoe UI" style="margin-left: 84px; margin-bottom: 3px; margin-right: 15px; margin-top: 0px;" Width="171px"></asp:TextBox>
                <br />
                <br />
                <asp:Label ID="lbl3" runat="server" Font-Names="Segoe UI" Text="Senha"></asp:Label>
                <asp:TextBox ID="txtSenha" runat="server" style="margin-left: 97px; margin-right: 14px;" TextMode="Password" Width="172px"></asp:TextBox>
                <br />
                <br />
                <asp:CheckBox ID="chkAuthWin" runat="server" Font-Names="Segoe UI" OnCheckedChanged="chkAuthWin_CheckedChanged1" Text="Autenticação com Windows" AutoPostBack="True" />
                <br />
                <br />
                <asp:Button ID="btnDesconectar" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" Height="34px" OnClick="btnDesconectar_Click" style="margin-left: 138px" Text="Desconectar" Visible="False" Width="87px" />
                <asp:Button ID="btnConectar" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" Height="34px" style="margin-left: 18px" Text="Conectar" Width="85px" OnClick="btnConectar_Click" EnableViewState="False" />
                <br />
                <br />
            </asp:Panel>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
        </div>
        <asp:Label ID="Label5" runat="server" Font-Names="Segoe UI" Text="Selecione as tabelas que deseja replicar"></asp:Label>
        <asp:DropDownList ID="cmbSelectCarga" runat="server" Font-Names="Segoe UI" Height="25px" style="margin-left: 8px; margin-right: 8px; margin-top: 15px; margin-bottom: 4px" Width="198px" OnSelectedIndexChanged="cmbSelectCarga_SelectedIndexChanged" Enabled="False" ViewStateMode="Disabled" AutoPostBack="True">
            <asp:ListItem></asp:ListItem>
            <asp:ListItem Value="1">Nota fiscal e itens nota</asp:ListItem>
            <asp:ListItem Value="2">Contas a Receber</asp:ListItem>
            <asp:ListItem Value="3">Clientes</asp:ListItem>
            <asp:ListItem Value="4">Completa</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <asp:Label ID="Label8" runat="server" Font-Names="Segoe UI" Text="Selecione os campos para replicação"></asp:Label>
        <asp:ListBox ID="lbCampos" runat="server" Enabled="False" style="margin-left: 31px; margin-right: 0px; margin-bottom: 0px; margin-top: 0px;" Width="196px" OnSelectedIndexChanged="lbCampos_SelectedIndexChanged"></asp:ListBox>
        <asp:Button ID="btnSelectCampo0" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" Height="16px" style="margin-right: 0px; margin-bottom: 4px; margin-left: 0px; margin-top: 0px;" Text="&lt;" Width="50px" Enabled="False" OnClick="btnSelectCampo0_Click" />
        <asp:Button ID="btnSelectCampo" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" Height="16px" style="margin-right: 0px; margin-bottom: 3px; margin-top: 0px;" Text="&gt;" Width="50px" Enabled="False" OnClick="btnSelectCampo_Click" />
        <asp:ListBox ID="lbCamposSelect" runat="server" Enabled="False" style="margin-left: 0px; margin-right: 0px; margin-bottom: 0px" Width="196px" OnSelectedIndexChanged="lbCamposSelect_SelectedIndexChanged"></asp:ListBox>
        <br />
        <br />
        <div style="width: 798px; height: 281px">
            <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Names="Segoe UI" Text="Filtros para a consulta"></asp:Label>
            <br />
            <br />
            &nbsp;
            <asp:Label ID="Label13" runat="server" Font-Names="Segoe UI" Text="Campo"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label14" runat="server" Font-Names="Segoe UI" Text="Operador"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Label ID="Label15" runat="server" Font-Names="Segoe UI" Text="Expressão"></asp:Label>
            <br />
            <asp:DropDownList ID="cmbCampo" runat="server" Font-Names="Segoe UI" style="margin-left: 6px; margin-right: 24px" Width="179px" Enabled="False">
            </asp:DropDownList>
            <asp:DropDownList ID="cmbOperador" runat="server" Font-Names="Segoe UI" style="margin-right: 25px" Width="162px" Enabled="False">
                <asp:ListItem Selected="True"></asp:ListItem>
                <asp:ListItem Value="=">Igual (=)</asp:ListItem>
                <asp:ListItem Value="&lt;&gt;">Diferente (&lt;&gt;)</asp:ListItem>
                <asp:ListItem Value="&gt;">Maior (&gt;)</asp:ListItem>
                <asp:ListItem Value="&lt;">Menor (&lt;)</asp:ListItem>
                <asp:ListItem Value="&gt;=">Maior ou igual (&gt;=)</asp:ListItem>
                <asp:ListItem Value="&lt;=">Menor ou igual (&lt;=)</asp:ListItem>
                <asp:ListItem Value="%">Contém (LIKE %..)</asp:ListItem>
                <asp:ListItem Value="_%">Contém (LIKE ..%)</asp:ListItem>
                <asp:ListItem Value="%_%">Contém (LIKE %..%)</asp:ListItem>
                <asp:ListItem Value="BETWEEN">Entre (BETWEEN)</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="txtExpressao" runat="server" Font-Names="Segoe UI" style="margin-right: 15px" Width="142px" Enabled="False"></asp:TextBox>
            <asp:Button ID="btnAnd" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" style="margin-right: 4px; margin-left: 0px;" Text="E" Enabled="False" OnClick="btnAnd_Click" />
            <asp:Button ID="btnOr" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" style="margin-right: 4px; margin-left: 0px;" Text="Ou" Enabled="False" OnClick="btnOr_Click" />
            <asp:Button ID="btnEntre" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" style="margin-right: 3px; margin-left: 0px;" Text="Entre" Enabled="False" OnClick="btnEntre_Click" />
            <asp:Button ID="btnAbreAspas" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" style="margin-left: 0px; margin-right: 3px" Text="(" Enabled="False" OnClick="btnAbreAspas_Click" />
            <asp:Button ID="btnFechaAspas" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" style="margin-left: 0px; margin-right: 9px" Text=")" Enabled="False" OnClick="btnFechaAspas_Click" />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;<asp:Button ID="btnAdicionar" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" style="margin-left: 0px; margin-top: 5px; margin-right: 5px;" Text="+" Width="63px" Enabled="False" OnClick="btnAdicionar_Click" Height="32px" />
            &nbsp;<asp:Button ID="btnLimpar" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" Height="32px" OnClick="btnLimpar_Click" Text="Limpar" Width="61px" />
            <br />
            &nbsp;
            <asp:Label ID="Label16" runat="server" Font-Names="Segoe UI" Text="Condições"></asp:Label>
            <br />
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtCond" runat="server" Height="39px" ReadOnly="True" TextMode="MultiLine" Width="654px" Enabled="False" Font-Names="Segoe UI" Columns="200" Rows="5"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" BackColor="#000066" BorderStyle="None" Font-Names="Segoe UI" ForeColor="White" Height="38px" style="margin-left: 590px; margin-top: 13px" Text="Submeter" Width="91px" OnClick="Button1_Click" />
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>
</asp:Content>

