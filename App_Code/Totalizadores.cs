using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

/// <summary>
/// Summary description for Class1
/// </summary>
public class Totalizadores
{
    string connString = "Data Source=.\\SQLENTERPRISE;Initial Catalog=IntegNeomix;Integrated Security=SSPI;User ID=sa;Password=S@lpic@o";
    string selTot1 = "SELECT COUNT(*) AS TOTREP FROM dbo.notafiscal WHERE INN_STATUS = '1'";
    string selTot2 = "SELECT COUNT(*) AS TOTREJ FROM dbo.notafiscal WHERE INN_STATUS = '0'";
    string selTot3 = "SELECT COUNT(*) AS CRREP FROM dbo.contasreceber";

    SqlDataReader read1 = null;
    SqlDataReader read2 = null;
    SqlDataReader read3 = null;
    ArrayList totais = new ArrayList();

    int nfrep = 0;
    int nfrej = 0;
    int titrep = 0;
    int titrej = 0;
	
    public Totalizadores()
	{
		
	}

    public ArrayList consulta()
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd1 = new SqlCommand(selTot1, conn);
            SqlCommand cmd2 = new SqlCommand(selTot2, conn);
            SqlCommand cmd3 = new SqlCommand(selTot3, conn);

            conn.Open();
            read1 = cmd1.ExecuteReader();

            while (read1.Read())
            {
                nfrep = (int)read1["TOTREP"];

            }

            read1.Close();
            
            read2 = cmd2.ExecuteReader();

            while (read2.Read())
            {
                nfrej = (int)read2["TOTREJ"];

            }

            read2.Close();
            
            read3 = cmd3.ExecuteReader();

            while (read3.Read())
            {
                titrep = (int)read3["CRREP"];

            }

            read3.Close();
            
            if (conn != null)
            {
                conn.Close();
            }

            totais.Add(nfrep);
            totais.Add(nfrej);
            totais.Add(titrep);

            return totais;
        }
    }
}