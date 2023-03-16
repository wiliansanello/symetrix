using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

/// <summary>
/// Summary description for ConexaoBD
/// </summary>
public class ConexaoBD
{
    string sDtSource, sUsuario, sSenha; 
    bool bAutWin;
    string qryNf = "SELECT INN_NUM, INN_SERIE FROM notafiscal nf INNER JOIN itensnota it ON nf.INN_NUM = it.NOTAFISCAL_INN_NUM ";
    string connString = "";
    SqlConnection conn = null;
    int index1;
    int index2;
    int nOpc;

    public ConexaoBD()
    {
    }
        
	public ConexaoBD(string sUsr, string sSenh, bool bAutentWin, int nOpCarga)
	{
        sUsuario = sUsr;
        sSenha = sSenh;
        bAutWin = bAutentWin;
        nOpc = nOpCarga;
	}
    
    public ArrayList efetuaConexao()
    {
        ArrayList ret = new ArrayList(); 
        if (bAutWin == false)
        {
            connString = "Data Source=.\\SQLENTERPRISE;Initial Catalog=KP_Neomix;User ID="+sUsuario+";Password=" + sSenha + " "; //;Integrated Security=SSPI
        }
        else
        {
            connString = "Data Source=.\\SQLENTERPRISE;Initial Catalog=KP_Neomix;Integrated Security=SSPI";
        }

        DataSet ds = new DataSet();
        int retr = 1;
        string erro = ""; 
                     
        using (conn = new SqlConnection(connString))
        {
            try
            {
                conn.Open();                
            } 
            catch (Exception ex) 
            {
                erro = ex.Message;
                retr = 0;
            }
            ret.Add(retr);
            ret.Add(erro);
            ret.Add(connString);            
            conn.Close();           
        }
        return ret;
        
    }
    public void FillDataTable(out DataTable tabela)
    {
        ArrayList connect = efetuaConexao();
        var tabelaRetorno = new DataTable();       
        string sStrSel = "";

        if (nOpc == 1)
        {
            sStrSel = "SELECT FNF_NUM, FNF_SERIE, FNF_EMISSAO, FNF_TOTAL, CONDICAOPAGAMENTO_FCP_ID, FNF_VALPIS, FNF_VALCOFI, "+
                "FNF_VALISS, CLIENTES_FCC_ID, CLIENTES_FCC_LOJA, FNF_VALIPI, FNF_VALICM, FNF_COMPL FROM nota_fiscal ";
        }
        else if (nOpc == 2)
        {
            sStrSel = "SELECT NOTA_FISCAL_FNF_NUM, NOTA_FISCAL_FNF_SERIE, FCR_VENCIMENTO, FCR_BAIXA, FCR_BANCO, FCR_AG, FCR_CC FROM contas_receber";
        }
        else if (nOpc == 3 || nOpc == 4)
        {
            sStrSel = "SELECT FCC_ID, FCC_LOJA, FCC_RAZAOSOC, FCC_CPF, FCC_CNPJ, FCC_PESSOA FROM clientes";
        }

        using (SqlConnection conn = new SqlConnection((string)connect[2]))
        {
            using (SqlDataAdapter adapter = new SqlDataAdapter(sStrSel, conn))
            {
                 adapter.Fill(tabelaRetorno);
                 FillSchemaDataTable(tabelaRetorno, adapter);
                 tabela = tabelaRetorno;                
            }
        }
    }

    private static void FillSchemaDataTable(DataTable tabela, SqlDataAdapter adapter)
    {
        adapter.FillSchema(tabela, SchemaType.Source);
    }

    public List<string> Read(DataTable tabela)
    {
        var fields = new List<string>();
        var columns = tabela.Columns;

        for (int i = 0; i < columns.Count; i++)
            fields.Add(columns[i].ColumnName);

        return fields;
    }

    public void setIndex1(int ind1)
    {
        this.index1 = ind1;
    }

    public int getIndex1()
    {
        return index1;
    }

    public List<string> obterCampos()
    {
        var cmd1 = new SqlCommand();
        var tab = new DataTable();
        var cmd = (IDbCommand)cmd1;
        FillDataTable(out tab);
        List<string>campos = Read(tab);

        return campos;
    }
        
    public void encerraConexao()
    {
        conn.Close();
    }
    
}