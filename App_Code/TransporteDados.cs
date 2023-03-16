using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Collections;
using System.IO;

/// <summary>
/// Summary description for TransporteDados
/// </summary>
public class TransporteDados
{
    string tab;
    ArrayList campos = new ArrayList();
    List<string> ordem = new List<string>();
    ArrayList cpos = new ArrayList();
    string condic;
    string connString;
    string strCmd;
    string strAux;
    string strAux1;
    StreamReader objReader = new StreamReader("C:\\Symetrix\\SP_CHECK_NF_CLIENTE.sql");

	public TransporteDados(string conn, string tabela, ArrayList cpo, string cond)
	{
        connString = conn;
        tab = tabela;
        campos = cpo;
        condic = cond;
	}

    public string redirecionar()
    {
        string msg = "";
        if (tab == "clientes")
        {
            msg=cargaCliente();
        }
        else if (tab == "contas_receber")
        {
            cargaContasRec();
        }
        else if (tab == "completa")
        {
            cargaCompleta();
        }
        return msg;
    }

    public string cargaCliente()
    {
        strCmd = "INSERT INTO NeoPiram.dbo.p_clientes (";
        ordem.Add("0");
        ordem.Add("1");
        ordem.Add("2");
        ordem.Add("3");
        ordem.Add("4");
        
        cpos.Add("PCLI_LOJA");
        cpos.Add("PCLI_RAZAO");
        cpos.Add("PCLI_CPF");
        cpos.Add("PCLI_CNPJ");
        cpos.Add("PCLI_PESSOA");
        
        int i = 0;
        int j = 0;
        int nLin = cpos.Count;
        string pos = "";
        string nome_cpo = "";
        string[,] meta = new string[nLin, 2];
        foreach(string elem in cpos)
        {
            pos = Convert.ToString(ordem[i]);
            nome_cpo = Convert.ToString(cpos[i]);
            meta[i,j] = pos;
            j++;
            meta[i,j] = nome_cpo;       
            i++;
            j = 0;
        }
        i = 0;
        int totcampos = campos.Count-1;       
        foreach (string campo in campos)
        {        
            if (campos[i] != "")
            {
                strAux += cpos[i];
            }
            if (totcampos != i)
            {
                strAux += ",";
            }
            else
            {
                strAux += ")";
            }

            i++;
        }
        strCmd += strAux;
        i = 0;

        foreach (string campo in campos)
        {
           strAux1 += campos[i];
           if (totcampos != i)
           {
               strAux1 += ",";
           }
           i++;
        }

        string strSel = " SELECT " + strAux1 + " FROM KP_Neomix.dbo.clientes ";
        strCmd += strSel;

        if (condic != "")
        {
            strCmd += "WHERE "+condic;
        }
        i = 0;
        j = i;
        string msg = "";
        string[,] ret = new string[10, 2];
        string[,] result = new string[10,2];
        strSel = "SELECT FCC_RAZAOSOC,FCC_LOJA FROM KP_Neomix.dbo.clientes ";

        if (condic != "")
        {
            strSel += "WHERE " + condic;
        }

        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand selComp = new SqlCommand(strSel, conn);
            conn.Open();
            SqlDataReader read1 = selComp.ExecuteReader();
            if (read1.HasRows)
            {
                while (read1.Read())
                {
                    ret[i, j] = (string)read1["FCC_RAZAOSOC"];
                    j++;
                    ret[i, j] = Convert.ToString((int)read1["FCC_LOJA"]);
                    j = 0;
                    i++;
                }
            }
            conn.Close();
        }

        connString = "Data Source=.\\SQLENTERPRISE;Initial Catalog=NeoPiram;User ID=sa;Password=S@lpic@o";
        i = 0;
        j = i;
        bool bLocaliza = false;
        strSel = "SELECT " + cpos[2] + ", " + cpos[1] + " FROM p_clientes WHERE PCLI_RAZAO = '" + ret[i, j] + "' AND PCLI_LOJA = '" + ret[i, j + 1] + "'";
        using (SqlConnection conn = new SqlConnection(connString))
        {           
            for (int cnt = 0; cnt < 10; cnt++)
            {
                SqlCommand selVer = new SqlCommand(strSel, conn);
                SqlDataReader read2 = null;
                conn.Open();
                read2 = selVer.ExecuteReader();

                if (read2.HasRows)
                {
                    msg = "Atenção. A replicação foi interrompida, pois já existem registros dentro da condição especificada gravados na base destino.";
                    conn.Close();
                    bLocaliza = true;
                    break;
                }
                else
                {
                    conn.Close();
                    bLocaliza = false;                    
                }
                if (bLocaliza == false)
                {
                    SqlCommand rep = new SqlCommand(strCmd, conn);
                    conn.Open();
                    rep.ExecuteNonQuery();
                    msg = "Replicação efetuada com sucesso!";
                }
            }                
        }
        return msg;
    }

    public void cargaContasRec()
    {
    }

    public string cargaCompleta()
    {
        string msg = "";
        string connString = "Data Source=.\\SQLENTERPRISE;Initial Catalog=IntegNeomix;User ID=sa;Password=S@lpic@o";
        
        while(!objReader.EndOfStream)
        {
            strCmd = objReader.ReadLine();
        }
        
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd = new SqlCommand();
        }
        return msg;
    }
}