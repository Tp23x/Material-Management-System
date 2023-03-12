using DevExpress.Web;
using DevExpress.Web.Bootstrap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MTL_Web
{
    public partial class part_master : System.Web.UI.Page
    {

        

        #region Method Members
        private List<T_DVL_INV_PN> lstPart()
        {
            List<T_DVL_INV_PN> lst = new List<T_DVL_INV_PN>();
            string yy = string.Empty;

            try
            {
                using (Entities ctx = new Entities())
                {
                    var qry = (from e in ctx.T_DVL_INV_PN
                               select e).ToList<T_DVL_INV_PN>();                  


                    lst = qry;


                }
            }
            catch (Exception ex)
            {

                throw ex;
            }


            return lst;
        }

        void AddError(Dictionary<GridViewColumn, string> errors, GridViewColumn column, string errorText)
        {
            if (errors.ContainsKey(column)) return;
            errors[column] = errorText;
        }

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {

            if(!Page.IsPostBack)
            {
                this.gvMaster.DataBind();
            }


        }

        protected void gvMaster_DataBinding(object sender, EventArgs e)
        {
            gvMaster.DataSource = this.lstPart();
        }
    

        protected void gvMaster_RowDeleting(object sender, DevExpress.Web.Data.ASPxDataDeletingEventArgs e)
        {
            try
            {
                BootstrapGridView gridView = (BootstrapGridView)sender;
                int id = Convert.ToInt32(e.Keys[gridView.KeyFieldName]);
                using (Entities ctx = new Entities())
                {
                    var qry = from d in ctx.T_DVL_INV_PN
                              where d.PART_ID == id
                              select d;

                    ctx.T_DVL_INV_PN.Remove(qry.First());
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

        protected void gvMaster_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            try
            {

                BootstrapGridView gridView = (BootstrapGridView)sender;


                BootstrapTextBox txtPartNo = this.gvMaster.FindEditFormLayoutItemTemplateControl("txtPartNo") as BootstrapTextBox;
                string part_no = txtPartNo.Text;
                BootstrapRadioButtonList rblProduct = this.gvMaster.FindEditFormLayoutItemTemplateControl("rblProduct") as BootstrapRadioButtonList;
                string prod_name = rblProduct.SelectedItem.Value.ToString();
                BootstrapTextBox txtStd = this.gvMaster.FindEditFormLayoutItemTemplateControl("txtStd") as BootstrapTextBox;
                string std_pack = txtStd.Text;
                BootstrapSpinEdit spMin = this.gvMaster.FindEditFormLayoutItemTemplateControl("spMin") as BootstrapSpinEdit;
                int minqty = Convert.ToInt32(spMin.Value);
                BootstrapSpinEdit spMax = this.gvMaster.FindEditFormLayoutItemTemplateControl("spMax") as BootstrapSpinEdit;
                int maxqty = Convert.ToInt32(spMax.Value);
                BootstrapComboBox cmbCategory = this.gvMaster.FindEditFormLayoutItemTemplateControl("cmbCategory") as BootstrapComboBox;
                string category = cmbCategory.Text;
                BootstrapRadioButtonList rblStatus = this.gvMaster.FindEditFormLayoutItemTemplateControl("rblStatus") as BootstrapRadioButtonList;
                string status = rblStatus.SelectedItem.Value.ToString();

                using (Entities ctx = new Entities())
                {




                    var checkDup1 = ctx.T_DVL_INV_PN.SingleOrDefault(record => record.PART_NO == part_no);
                    if (checkDup1 != null)
                    {
                        gridView.JSProperties["cpShowMessage"] = "Duplicate Data!! Please try another";

                        return;
                    }
                    else //Subject does not exist.
                    {
                        var qry = new T_DVL_INV_PN()
                        {
                            PART_NO = part_no,
                            PRODUCT_NAME = prod_name,
                            STD_PACK = std_pack,
                            MIN_QTY = minqty,
                            MAX_QTY = maxqty,
                            CATEGORY_ID = category,
                            STATUS = status,
                            CREATED_BY = "praew",
                            CREATED_DATE = DateTime.Now

                        };
                        ctx.T_DVL_INV_PN.Add(qry);
                        ctx.SaveChanges();

                        e.Cancel = true;
                        gridView.CancelEdit();

                        gridView.JSProperties["cpShowMessage"] = "Add new data completed.";

                    }

                }

            }
            catch (Exception ex)
            {

                throw ex;
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

                    BootstrapTextBox txtPartNo = this.gvMaster.FindEditFormLayoutItemTemplateControl("txtPartNo") as BootstrapTextBox;
                    string part_no = txtPartNo.Text;
                    BootstrapRadioButtonList rblProduct = this.gvMaster.FindEditFormLayoutItemTemplateControl("rblProduct") as BootstrapRadioButtonList;
                    string prod_name = rblProduct.SelectedItem.Value.ToString();
                    BootstrapTextBox txtStd = this.gvMaster.FindEditFormLayoutItemTemplateControl("txtStd") as BootstrapTextBox;
                    string std_pack = txtStd.Text;
                    BootstrapSpinEdit spMin = this.gvMaster.FindEditFormLayoutItemTemplateControl("spMin") as BootstrapSpinEdit;
                    int minqty = Convert.ToInt32(spMin.Value);
                    BootstrapSpinEdit spMax = this.gvMaster.FindEditFormLayoutItemTemplateControl("spMax") as BootstrapSpinEdit;
                    int maxqty = Convert.ToInt32(spMax.Value);
                    BootstrapComboBox cmbCategory = this.gvMaster.FindEditFormLayoutItemTemplateControl("cmbCategory") as BootstrapComboBox;
                    string category = cmbCategory.Text;
                    BootstrapRadioButtonList rblStatus = this.gvMaster.FindEditFormLayoutItemTemplateControl("rblStatus") as BootstrapRadioButtonList;
                    string status = rblStatus.SelectedItem.Value.ToString();

                    string modified_by = "praew";
                    DateTime modified_date = DateTime.Now;


                    var qry = from c in ctx.T_DVL_INV_PN
                              where c.PART_ID == id
                              select c;

                    var std = qry.FirstOrDefault();
                    std.PART_NO = part_no;
                    std.PRODUCT_NAME = prod_name;
                    std.STD_PACK = std_pack;
                    std.MIN_QTY = minqty;
                    std.MAX_QTY = maxqty;
                    std.CATEGORY_ID = category;
                    std.STATUS = status;
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

        protected void gvMaster_RowValidating(object sender, DevExpress.Web.Data.ASPxDataValidationEventArgs e)
        {
            BootstrapGridView grid = (BootstrapGridView)sender;

            foreach (GridViewColumn column in grid.Columns)
            {
                GridViewDataColumn dataColumn = column as GridViewDataColumn;
                if (dataColumn == null) continue;
                if (e.NewValues[dataColumn.FieldName] == null)
                {
                    e.Errors[dataColumn] = "Value can't be null.";
                }
            }
            if (e.Errors.Count > 0) e.RowError = "Please, fill all fields.";
        }

        protected void gvMaster_StartRowEditing(object sender, DevExpress.Web.Data.ASPxStartRowEditingEventArgs e)
        {
            if (!gvMaster.IsNewRowEditing)
            {
                gvMaster.DoRowValidation();
            }
        }
    }
}