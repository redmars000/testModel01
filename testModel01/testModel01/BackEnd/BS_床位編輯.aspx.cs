﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace testModel01.BackEnd
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        // string str_Data_Source = @"CR4-17\MSSQLSERVER2013";//資策
        //  string str_Data_Source = @"SHAWN-PC";//家3
        string str_Data_Source = @"WIN-R56ALTBAKPC\SQLEXPRESS";//家2

        DropDownList ddlist;  //暫存
        Image img1;//暫存
        FileUpload fupload; //暫存
        Control contrl_temp;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                m_initial();
            }

            if (Session["test"] != null)
                Label1.Text=(string)Session["test"];
          }

        private void m_initial()
        {
            string str_bednum= Request.QueryString["f床號"].ToString();
          
            SqlDataSource sds = new SqlDataSource();
            sds.ConnectionString = "Data Source=" + str_Data_Source + ";Initial Catalog=dbKSYY;Integrated Security=True";
            sds.SelectCommand = "SELECT * from  T床位系統 WHERE f床號 ='"+str_bednum+"'";
            DataView dn = (DataView)sds.Select(DataSourceSelectArguments.Empty);            
            int[] inta_ = new int[3];

         try
         {
             m_FindControl_ddlist(FormView16, typeof(DropDownList));
             ddlist.SelectedIndex = Convert.ToInt32(dn[0]["f是否住院中"]);
         }
         catch (Exception exc)
         {
             ddlist = new DropDownList();
             ddlist.SelectedIndex = 0;
         }


         try
         {
             img1 = new Image();  
             img1.ImageUrl = dn[0]["f大頭照"].ToString();
             if (img1.ImageUrl.Length < 5)
             {
               
                 img1.ImageUrl = @"../pic/床位照片/大頭照/defaultimg.png";
             }
          
         }
         catch (Exception ee)
         {
             img1.ImageUrl = @"../pic/床位照片/大頭照/defaultimg.png";
         }
         m_FindControl_Control(FormView16, typeof(Image));
         ((Image)contrl_temp).ImageUrl = img1.ImageUrl;
        }

        public void m_FindControl_ddlist(Control root, Type type)
        {

            if (root.GetType() == type)
            {
                if (((DropDownList)root).ID == "DDList_hospital")
                {
                    ddlist = ((DropDownList)root);
                    return;
                }
            }
            foreach (Control c in root.Controls)
                m_FindControl_ddlist(c, type);
        }

        public void m_FindControl_Control(Control root, Type type)
        {
            if (root.GetType() == type)
            {
                contrl_temp = root;
                    return;
            }
            foreach (Control c in root.Controls)
                m_FindControl_Control(c, type);
        }

        protected void FormView1_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Response.Redirect("BS_床位顯示_地圖.aspx");
            }
        }

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
//            Response.Redirect("BS_床位顯示_地圖.aspx");
            Response.Redirect("BS_床位編輯.aspx?f床號=110-6(E)");
        }

        protected void FormView16_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            FormView f = (FormView)sender;
            m_FindControl_ddlist(FormView16, typeof(DropDownList));
            e.NewValues["f是否住院中"] = ddlist.SelectedIndex.ToString();

            
            //照片

            m_FindControl_Control(FormView16, typeof(FileUpload));
            fupload = (FileUpload)contrl_temp;


            m_FindControl_Control(FormView16, typeof(Image));
            img1 = ((Image)contrl_temp);
            //////
     
           if (fupload.HasFile)//是否有上傳的檔案
            {

                if ("jpg".Equals(fupload.FileName.Substring(fupload.FileName.LastIndexOf(".") + 1).ToLower()) ||
                             "png".Equals(fupload.FileName.Substring(fupload.FileName.LastIndexOf(".") + 1).ToLower()) ||
                             "bmp".Equals(fupload.FileName.Substring(fupload.FileName.LastIndexOf(".") + 1).ToLower()) ||
                             "gif".Equals(fupload.FileName.Substring(fupload.FileName.LastIndexOf(".") + 1).ToLower()))
                {
                    //是否符合副檔名
                    //刪除照片
                    string str_expath = System.Web.Hosting.HostingEnvironment.MapPath("~");
                    if (img1.ImageUrl!=@"../pic/床位照片/大頭照/defaultimg.png")
                    {
                        string str_temp = str_expath + img1.ImageUrl.Substring(4, img1.ImageUrl.Length - 4);
                        if (System.IO.File.Exists(str_temp))
                            System.IO.File.Delete(str_temp);
                    }
                    //上傳照片                   
                        fupload.SaveAs(Server.MapPath(@"~\pic\床位照片\大頭照\" + fupload.FileName));
                        e.NewValues["f大頭照"] = @"..\pic\床位照片\大頭照\" + fupload.FileName;
                 }
            }
           else
               e.NewValues["f大頭照"] = img1.ImageUrl;
        }

        protected void FormView16_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            Response.Redirect("BS_床位顯示_地圖.aspx");
        }

        protected void FormView16_Unload(object sender, EventArgs e)
        {

        }

   

  
    }
}