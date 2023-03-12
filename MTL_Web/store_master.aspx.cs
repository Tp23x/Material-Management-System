using DevExpress.Web.Bootstrap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MTL_Web
{
    public partial class store_master : System.Web.UI.Page
    {

        private List<T_DVL_INV_STORE> lstStore()
        {
            List<T_DVL_INV_STORE> lst = new List<T_DVL_INV_STORE>();
            string yy = string.Empty;

            try
            {
                using (Entities ctx = new Entities())
                {
                    var qry = (from e in ctx.T_DVL_INV_STORE
                               select e).ToList<T_DVL_INV_STORE>();


                    lst = qry;


                }
            }
            catch (Exception ex)
            {

                throw ex;
            }


            return lst;
        }

        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.gvMasterStore.DataBind();
            }
        }

        protected void gvMasterStore_DataBinding(object sender, EventArgs e)
        {
            gvMasterStore.DataSource = this.lstStore();
        }

        protected void gvMasterStore_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            try
            {
                BootstrapGridView gridView = (BootstrapGridView)sender;
                int id = Convert.ToInt32(e.Keys[gridView.KeyFieldName]);
                using (Entities ctx = new Entities())
                {
                    var qry = from d in ctx.T_DVL_INV_STORE
                              where d.STORE_ID == id
                              select d;

                    ctx.T_DVL_INV_STORE.Remove(qry.First());
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
    }
}