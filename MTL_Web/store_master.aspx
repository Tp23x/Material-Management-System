<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="store_master.aspx.cs" Inherits="MTL_Web.store_master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        function btnAddNew_Clicked(s, e) {
            pnNew.Show();
        }
        function btnSave_Clicked(s, e) {

            cpNew.PerformCallback();

            pnNew.Hide();
            gvMasterStore.PerformCallback();
            gvMasterStore.Refresh();

        }
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
                        return parent.GetParentControl() === gvMasterStore
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
                gvMasterStore.AddNewRow();
            }
            else if (e.actionName === "EditRow") {
                gvMasterStore.StartEditRow(gvMasterStore.GetFocusedRowIndex());
                gvMasterStore.SetFocusedRowIndex(-1);
            }
            else if (e.actionName === "DeleteRow") {
                if (confirm('Do you wish to delete this row ?'))
                    gvMasterStore.DeleteRow(gvMasterStore.GetFocusedRowIndex());
                gvMasterStore.SetFocusedRowIndex(-1);
            }
            else if (e.actionName === "Save") {
                gvMasterStore.UpdateEdit();
            }
            else if (e.actionName === "Cancel") {
                gvMasterStore.CancelEdit();
            }
        }
        function OnActionCollapsing(s, e) {
            if ((e.contextName === "FocusedRowContext" || e.contextName === "EditingRowContext") && e.collapseReason === ASPxClientFloatingActionButtonCollapseReason.CollapseButton) {
                setTimeout(function () {
                    gvMasterStore.CancelEdit();
                    gvMasterStore.SetFocusedRowIndex(-1);
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

    <div style="width:100%; text-align:center; padding-bottom:15px;"><h2>Store Master Setting</h2></div>
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

    <dx:BootstrapGridView ID="gvMasterStore" runat="server" KeyFieldName="STORE_ID" OnDataBinding="gvMasterStore_DataBinding" ClientInstanceName="gvMasterStore" EnableRowsCache="False"
           >
            
            <SettingsDataSecurity AllowEdit="True" AllowDelete="True" AllowInsert="True" />
            <SettingsBehavior ConfirmDelete="True" AllowFocusedRow="true" />
            <ClientSideEvents EndCallback="onGrid_EndCallBack" Init="OnGridViewInit" RowClick="OnRowClick" />
            <SettingsPager Mode="ShowAllRecords" />
            <Columns>
                <dx:BootstrapGridViewTextColumn FieldName="STORE_ID" VisibleIndex="1">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="0" />
                </dx:BootstrapGridViewTextColumn>

                <dx:BootstrapGridViewTextColumn FieldName="STORE_NAME" Name="STORE_NAME" VisibleIndex="2">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="1" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="REMARK" VisibleIndex="3">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="2" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="CREATED_BY" Name="CREATED_BY" VisibleIndex="4">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="3" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="CREATED_DATE" Name="CREATED_DATE" VisibleIndex="5">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="4" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="MODIFIED_BY" Name="MODIFIED_BY" VisibleIndex="6">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="5" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="MODIFIED_DATE" Name="MODIFIED_DATE" VisibleIndex="7">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="6" />
                </dx:BootstrapGridViewTextColumn>

            </Columns>

        </dx:BootstrapGridView>

        <br />

    </div>

</asp:Content>
