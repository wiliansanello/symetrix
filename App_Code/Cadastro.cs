using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

/// <summary>
/// Summary description for Cadastro
/// </summary>
public class Cadastro
{
    string connString = "Data Source=.\\SQLENTERPRISE;Initial Catalog=IntegNeomix;Integrated Security=SSPI;User ID=sa;Password=S@lpic@o";
    string strCrp = "OPEN SYMMETRIC KEY UsuSym DECRYPTION BY PASSWORD = N'xF0F1F2'";
    string strSel = "SELECT INU_ID, INU_NOME, INU_EMAIL, INU_LOGIN, GRUPO_ING_ID, CONVERT(VARCHAR,DECRYPTBYKEY([INU_SENHA])) AS SENHA FROM dbo.usuario WHERE INU_ID = @ID";
    string strGrp = "SELECT ING_ID, ING_NOME FROM dbo.grupo";
    SqlDataReader read = null;
    SqlConnection conn = null;
    DataSet ds = new DataSet();
    ArrayList usuario = new ArrayList();
    internal DataTable dt = null;

    int id, grupo,op;
    string nome, cpf, email, login, senha, id_conv, codigo, grupo_conv;
    DateTime datanasc = new DateTime();

    public Cadastro() { }

	public Cadastro(string codigo, int oper)
	{
        id = Convert.ToInt32(codigo);
        nome = "";
        email = "";
        login = "";
        grupo = 0;
        senha = "";
        op = oper ;
        
	}

    public ArrayList carregarDados()
    {        

        if (op == 2 | op == 3)
        {
            using (conn = new SqlConnection(connString))
            {
                SqlCommand crp = new SqlCommand(strCrp,conn);
                SqlCommand sel = new SqlCommand(strSel, conn);

                SqlParameter par1 = new SqlParameter();
                par1.ParameterName = "@ID";
                par1.Value = id;

                sel.Parameters.Add(par1);

                conn.Open();
                SqlDataReader cript = crp.ExecuteReader();
                cript.Close();
                read = sel.ExecuteReader();
                                                                
                while (read.Read())
                {
                    id_conv = Convert.ToString(id);
                    nome = (string)read["INU_NOME"];
                    email = (string)read["INU_EMAIL"];
                    login = (string)read["INU_LOGIN"];
                    grupo = (int)read["GRUPO_ING_ID"];
                    //grupo_conv = Convert.ToString(grupo); 
                    senha = (string)read["SENHA"];                                      
                }

                read.Close();
                
                usuario.Add(id_conv);
                usuario.Add(nome);
                usuario.Add(email);
                usuario.Add(login);
                usuario.Add(grupo);
                usuario.Add(senha);
                
                string qryPriv = "SELECT PRIVILEGIO_INP_ID FROM dbo.usuario_has_privilegio WHERE USUARIO_INU_ID = @idUser";
                
                SqlCommand cmdPriv = new SqlCommand(qryPriv, conn);

                SqlParameter parPriv = new SqlParameter();
                
                cmdPriv.Parameters.AddWithValue("@idUser", id);

                SqlDataReader priv = cmdPriv.ExecuteReader();
                ArrayList privilegio = new ArrayList();
                int nPos = 0;
                while (priv.Read())
                {
                    privilegio.Add((int)priv["PRIVILEGIO_INP_ID"]);
                    nPos++;
                }
                   
                fechaConexao();

                usuario.Add(privilegio);

                using (SqlDataAdapter adaptcmb = new SqlDataAdapter(strGrp, conn))
                {
                    adaptcmb.Fill(ds, "dbo.grupo");
                }
            }
            return usuario;
        }
        else
        {
            return null;
        }
            
    }

    public void Inserir(string nome, string email, string login, int grupo, int [] privilegio,string senha,int id)
    {
        usuario.Add(nome);
        usuario.Add(email);
        usuario.Add(login);
        usuario.Add(grupo);
        usuario.Add(senha);
        GravaInsercao(id,privilegio);
    }

    public void Alterar()
    {        
        carregarDados();
    }

    public void Excluir()
    {
        carregarDados();
    }

    public void GravaInsercao(int id,int [] privilegio)
    {
        string strIns = " INSERT INTO dbo.usuario " +
            "(INU_NOME, " +
            "INU_EMAIL, " +
            "INU_LOGIN, " +
            "GRUPO_ING_ID," +
            "INU_SENHA)" +
            "VALUES " +
            "(@nome, " +
            "@email," +
            "@login," +
            "@grupo," +
            "EncryptByKey(Key_GUID('UsuSym'),@senha)) ";
                        
        using (conn = new SqlConnection(connString))
        {
            SqlCommand crp = new SqlCommand(strCrp, conn);
            SqlCommand ins = new SqlCommand(strIns, conn);
            ins.Parameters.AddWithValue("@nome", (string)usuario[0]);
            ins.Parameters.AddWithValue("@email", (string)usuario[1]);
            ins.Parameters.AddWithValue("@login", (string)usuario[2]);
            ins.Parameters.AddWithValue("@grupo", Convert.ToInt32(usuario[3]));
            ins.Parameters.AddWithValue("@senha", (string)usuario[4]);
                                
            conn.Open();
            crp.ExecuteNonQuery();
            ins.ExecuteNonQuery();

            for (int nPos = 0;nPos < privilegio.Length;nPos++)
            {
                string par1 = "@idUserPriv" + Convert.ToString(nPos + 1);
                string par2 = "@idPriv" + Convert.ToString(nPos + 1);

                string strPriv = "INSERT INTO dbo.usuario_has_privilegio VALUES ("+par1+","+par2+")"; 

                SqlCommand insprv = new SqlCommand(strPriv, conn);
            
                insprv.Parameters.AddWithValue(par1,(int)id);
                insprv.Parameters.AddWithValue(par2,(int)privilegio[nPos]);
                insprv.ExecuteNonQuery();            
            }
            fechaConexao();
            
        }
    }

    public void GravaAlteracao(string nome, string email, string login, int grupo, int [] privilegio, string senha, int id)
    {
        string strUpd = "UPDATE dbo.usuario " +
            "SET INU_NOME = @nome," +
            "INU_EMAIL = @email," +
            "GRUPO_ING_ID = @grupo," +
            "INU_SENHA = EncryptByKey(Key_GUID('UsuSym'),@senha) " +
            "WHERE INU_ID = @id";

        using (conn = new SqlConnection(connString))
        {

            SqlCommand comm = new SqlCommand(strCrp, conn);
            SqlCommand upd = new SqlCommand(strUpd,conn);
                
            upd.Parameters.AddWithValue("@nome", nome);
            upd.Parameters.AddWithValue("@email", email);
            upd.Parameters.AddWithValue("@grupo", grupo);
            upd.Parameters.AddWithValue("@senha", senha);
            upd.Parameters.AddWithValue("@id", id);

            conn.Open();
            comm.ExecuteNonQuery();
            upd.ExecuteNonQuery();
            fechaConexao();

            /*string strPriv = "SELECT PRIVILEGIO_INP_ID FROM dbo.usuario_has_privilegio WHERE INP_ID = @idUser";

            for (int nPos = 0; nPos < privilegio.Length; nPos++)
            {
                string par1 = "@idUserPriv" + Convert.ToString(nPos + 1);
                string par2 = "@idPriv" + Convert.ToString(nPos + 1);

                

            }*/
        }
    }

    public void GravaExclusao(int id)
    {
        string strDel = "DELETE FROM dbo.usuario WHERE INU_ID = @idUser";

        using (conn = new SqlConnection(connString))
        {
            SqlCommand del = new SqlCommand(strDel, conn);

            del.Parameters.AddWithValue("@idUser", id);

            conn.Open();
            del.ExecuteNonQuery();
        }
    }

    public void fechaConexao()
    {
        if (conn != null)
        {
            conn.Close();
        }
    }

    public int getId()
    {
        int id_user = 0;
        string strQryId = "SELECT IDENT_CURRENT('dbo.usuario') AS IDATUAL;";
        using (conn = new SqlConnection(connString))
        {
            SqlCommand cmdId = new SqlCommand(strQryId, conn);

            conn.Open();

            SqlDataReader readId = cmdId.ExecuteReader();

            while (readId.Read())
            {
                id_user = Convert.ToInt32(readId["IDATUAL"]);
            }
            id_user += 1;

            conn.Close();
        }
        return id_user;
    }
    
}