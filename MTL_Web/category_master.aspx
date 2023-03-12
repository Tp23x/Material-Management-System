<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="category_master.aspx.cs" Inherits="MTL_Web.category_master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function onGrid_EndCallBack(s, e) {
            if (s.cpShowMessage) {
                alert(s.cpShowMessage);
                delete s.cpShowMessage;
            }

            if (s.IsNewRowEditing() || s.IsEditing()) {
                fab.SetActionContext("CancelContext", true);
                ASPxClientEdit.AttachEditorModificationListener(onEditorsChanged, function (control) {
                    var parent = control.GetParentControl();
                    if (parent && parent instanceof dx.BootstrapClientFormLayout)
                        return parent.GetParentControl() === gvMaster
                    else
                        return false;
                });
            }
            else {
                fab.SetActionContext("NewRowContext");
                s.SetFocusedRowIndex(-1);
            }
        }

        function OnActionItemClick(s, e) {
            if (e.actionName === "NewRow") {
                gvMaster.AddNewRow();
            }
            else if (e.actionName === "EditRow") {
                gvMaster.StartEditRow(gvMaster.GetFocusedRowIndex());
                gvMaster.SetFocusedRowIndex(-1);
            }
            else if (e.actionName === "DeleteRow") {
                if (confirm('Do you wish to delete this row ?'))
                    gvMaster.DeleteRow(gvMaster.GetFocusedRowIndex());
                gvMaster.SetFocusedRowIndex(-1);
            }
            else if (e.actionName === "Save") {
                gvMaster.UpdateEdit();
            }
            else if (e.actionName === "Cancel") {
                gvMaster.CancelEdit();
            }
        }
        function OnActionCollapsing(s, e) {
            if ((e.contextName === "FocusedRowContext" || e.contextName === "EditingRowContext") && e.collapseReason === ASPxClientFloatingActionButtonCollapseReason.CollapseButton) {
                setTimeout(function () {
                    gvMaster.CancelEdit();
                    gvMaster.SetFocusedRowIndex(-1);
                    fab.SetActionContext("NewRowContext");
                }, 100);
            }
        }

        function OnGridViewInit(s, e) {
            fab.SetActionContext("NewRowContext");
            s.SetFocusedRowIndex(-1);
        }
        function OnRowClick(s, e) {
            if (s.IsNewRowEditing() || s.IsEditing())
                e.cancel = true;
            else
                fab.SetActionContext("FocusedRowContext", true);
        }
        function onEditorsChanged(s, e) {
            fab.SetActionContext("EditingRowContext", true);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="width:100%; text-align:center; padding-bottom:15px;"><h2>Category Master Setting</h2></div>
    <div>
        
                
        <dx:BootstrapFloatingActionButton ClientInstanceName="fab" runat="server"
            ContainerCssSelector="#container" InitialActionContext="NewRowContext">
            <Items>
                <dx:BootstrapFABAction ActionName="NewRow" ContextName="NewRowContext" Text="Add new row"></dx:BootstrapFABAction>
                <dx:BootstrapFABAction ActionName="Cancel" ContextName="CancelContext" IconCssClass="dxbs-icon dxbs-icon-fab-collapse"></dx:BootstrapFABAction>
                <dx:BootstrapFABActionGroup ContextName="FocusedRowContext">
                    <Items>
                        <dx:BootstrapFABActionItem ActionName="DeleteRow" IconCssClass="fas fa-trash" SettingsBootstrap-RenderOption="Danger"></dx:BootstrapFABActionItem>
                        <dx:BootstrapFABActionItem ActionName="EditRow" IconCssClass="fas fa-edit" SettingsBootstrap-RenderOption="Info"></dx:BootstrapFABActionItem>
                    </Items>
                </dx:BootstrapFABActionGroup>
                <dx:BootstrapFABActionGroup ContextName="EditingRowContext" Text="Cancel" CollapseIconCssClass="dxbs-icon dxbs-icon-fab-collapse">
                    <Items>
                        <dx:BootstrapFABActionItem ActionName="Save" IconCssClass="fas fa-save" SettingsBootstrap-RenderOption="Success" ></dx:BootstrapFABActionItem>
                    </Items>
                </dx:BootstrapFABActionGroup>
            </Items>
            <ClientSideEvents
                ActionItemClick="OnActionItemClick"
                ActionCollapsing="OnActionCollapsing" />
        </dx:BootstrapFloatingActionButton>
        
        <dx:BootstrapGridView ID="gvMaster" runat="server" KeyFieldName="CATEGORY_ID" OnDataBinding="gvMaster_DataBinding" AutoGenerateColumns="False" ClientInstanceName="gvMaster"
            OnRowDeleting="gvMaster_RowDeleting" 
                    OnRowInserting="gvMaster_RowInserting" OnRowUpdating="gvMaster_RowUpdating" EnableRowsCache="False">
                    <SettingsBehavior ConfirmDelete="True" AllowFocusedRow="true" />
                    <ClientSideEvents EndCallback="onGrid_EndCallBack" Init="OnGridViewInit" RowClick="OnRowClick" />
                    <SettingsPager Mode="ShowAllRecords" Visible="False">
                    </SettingsPager>
                    <SettingsEditing Mode="EditForm">
                    </SettingsEditing>
                    <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                <Columns>
                    <dx:BootstrapGridViewTextColumn FieldName="CATEGORY_NAME" VisibleIndex="2">
                        <PropertiesTextEdit>
                            <ValidationSettings CausesValidation="True" SetFocusOnError="True">
                                <RequiredField ErrorText="This field is required!!" IsRequired="True" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn FieldName="REMARK" VisibleIndex="3">
                    </dx:BootstrapGridViewTextColumn>

                </Columns>
            </dx:BootstrapGridView>

    </div>
</asp:Content>
