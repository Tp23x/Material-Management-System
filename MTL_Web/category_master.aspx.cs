using DevExpress.Web.Bootstrap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MTL_Web
{
    public partial class category_master : System.Web.UI.Page
    {

        #region Method Members
        private List<T_DVL_INV_PN_CATEGORY> lstCategory()
        {
            List<T_DVL_INV_PN_CATEGORY> lst = new List<T_DVL_INV_PN_CATEGORY>();
            string yy = string.Empty;

            try
            {
                using (Entities ctx = new Entities())
                {
                    var qry = (from e in ctx.T_DVL_INV_PN_CATEGORY
                               select e).ToList<T_DVL_INV_PN_CATEGORY>();


                    lst = qry;


                }
            }
            catch (Exception ex)
            {

                throw ex;
            }


            return lst;
        }
        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                this.gvMaster.DataBind();
            }
        }

        protected void gvMaster_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            try
            {

                BootstrapGridView gridView = (BootstrapGridView)sender;
                using (Entities ctx = new Entities())
                {


                    string category_name = e.NewValues["CATEGORY_NAME"].ToString();
                    string remark = e.NewValues["REMARK"].ToString();
                    string CREATED_BY = "praew";
                    DateTime CREATED_DATE = DateTime.Now;




                    var checkDup1 = ctx.T_DVL_INV_PN_CATEGORY.SingleOrDefault(record => record.CATEGORY_NAME == category_name);
                    if (checkDup1 != null)
                    {
                        gridView.JSProperties["cpShowMessage"] = "Duplicate Data!! Please try another";
                        //e.Cancel = true;
                        //return;
                    }
                    else //Subject does not exist.
                    {
                        var qry = new T_DVL_INV_PN_CATEGORY()
                        {
                            //CATEGORY_ID = category_id,
                            CATEGORY_NAME = category_name,
                            REMARK = remark,
                            CREATED_BY = CREATED_BY,
                            CREATED_DATE = CREATED_DATE
                        };
                        ctx.T_DVL_INV_PN_CATEGORY.Add(qry);
                        ctx.SaveChanges();
                        gridView.JSProperties["cpShowMessage"] = "Add new data completed.";
                    }

                    e.Cancel = true;
                    gridView.CancelEdit();
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void gvMaster_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            
            try
            {
                BootstrapGridView gridView = (BootstrapGridView)sender;
                int id = Convert.ToInt32(e.Keys[gridView.KeyFieldName]);
                using (Entities ctx = new Entities())
                {
                    var qry = from d in ctx.T_DVL_INV_PN_CATEGORY
                              where d.CATEGORY_ID == id
                              select d;

                    ctx.T_DVL_INV_PN_CATEGORY.Remove(qry.First());
                    ctx.SaveChanges();

                    gridView.JSProperties["cpShowMessage"] = "Delete data completed.";
                }

                e.Cancel = true;
            }
            catch (Exception)
            {

                throw;
            }

        }

        protected void gvMaster_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
           
            try
            {
                BootstrapGridView gridView = (BootstrapGridView)sender;
                int id = Convert.ToInt32(e.Keys[gridView.KeyFieldName]);

                using (Entities ctx = new Entities())
                {
                    string category_name = e.NewValues["CATEGORY_NAME"].ToString();
                    string remark = e.NewValues["REMARK"].ToString();
                    string modified_by = "praew";
                    DateTime modified_date = DateTime.Now;


                    var qry = from c in ctx.T_DVL_INV_PN_CATEGORY
                              where c.CATEGORY_ID == id
                              select c;

                    var std = qry.FirstOrDefault();

                    std.CATEGORY_NAME = category_name;
                    std.REMARK = remark;
                    std.MODIFIED_BY = modified_by;
                    std.MODIFIED_DATE = modified_date;



                    ctx.SaveChanges();

                    gridView.JSProperties["cpShowMessage"] = "Update data completed.";

                    e.Cancel = true;
                    gridView.CancelEdit();


                }
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        protected void gvMaster_DataBinding(object sender, EventArgs e)
        {
            this.gvMaster.DataSource = lstCategory();
        }
    }
}