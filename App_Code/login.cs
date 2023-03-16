using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Esta classe instancia a fábrica de conexão e pesquisa pelo usuário e senha passados
/// </summary>
public class login
{
    public int idUser;
    public string UserName;
    public string Password;
    public string nome;
    public int grupo;
    public bool hasReturn;
    string connString = "Data Source=.\\SQLENTERPRISE;Initial Catalog=IntegNeomix;Integrated Security=SSPI;User ID=sa;Password=S@lpic@o";
    string strOp  = "OPEN SYMMETRIC KEY UsuSym DECRYPTION BY PASSWORD = N'xF0F1F2'";
    string strSel = "SELECT INU_ID,INU_NOME,INU_LOGIN, CONVERT(VARCHAR,DECRYPTBYKEY([INU_SENHA])),GRUPO_ING_ID FROM usuario WHERE INU_LOGIN=@0 AND CONVERT(VARCHAR,DECRYPTBYKEY([INU_SENHA])) =@1";
    public SqlDataReader reader = null;

    
    public login(int id, string userName,string pwd, int grp)
    {
        idUser = id;
        UserName = userName;
        Password = pwd;
        grupo = grp;
        hasReturn = false;
        nome = "";
    }
      
    public void conect(string UserName,string Password){  
        
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand op = new SqlCommand(strOp, conn);
            SqlCommand cmd = new SqlCommand(strSel, conn);

            SqlParameter par1 = new SqlParameter();
            par1.ParameterName = "@0";
            par1.Value = UserName;

            SqlParameter par2 = new SqlParameter();
            par2.ParameterName = "@1";
            par2.Value = Password;

            cmd.Parameters.Add(par1);
            cmd.Parameters.Add(par2);

            conn.Open();
            SqlDataReader cript = op.ExecuteReader();
            cript.Close();
            reader = cmd.ExecuteReader();

            if (reader.HasRows)
                hasReturn = true;
                while (reader.Read())
                {
                    idUser = (int)reader["INU_ID"];
                    nome = (String)reader["INU_NOME"];
                    grupo = (int)reader["GRUPO_ING_ID"];                    
                }
                //fecha o reader
                if (reader == null)
                {
                    reader.Close();
                }   

                if (conn != null)
                {
                    conn.Close();
                }
            }
        }
    
 }