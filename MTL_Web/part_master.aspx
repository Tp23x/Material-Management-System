<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="part_master.aspx.cs" Inherits="MTL_Web.part_master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        function btnAddNew_Clicked(s, e) {
            pnNew.Show();
        }
        function btnSave_Clicked(s, e) {

            cpNew.PerformCallback();

            pnNew.Hide();
            gvMaster.PerformCallback();
            gvMaster.Refresh();

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
    <div style="width:100%; text-align:center; padding-bottom:15px;"><h2>Part Master Setting</h2></div>
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
        <dx:BootstrapGridView ID="gvMaster" runat="server" KeyFieldName="PART_ID" OnDataBinding="gvMaster_DataBinding" ClientInstanceName="gvMaster" EnableRowsCache="False"
            OnRowDeleting="gvMaster_RowDeleting" OnRowInserting="gvMaster_RowInserting" OnRowUpdating="gvMaster_RowUpdating" AutoGenerateColumns="False" 
            OnRowValidating="gvMaster_RowValidating" OnStartRowEditing="gvMaster_StartRowEditing">
            
            <SettingsEditing>
                <FormLayoutProperties>
                    <Items>
                        <dx:BootstrapGridViewColumnLayoutItem Caption="Part No." ColumnName="PART_NO" RequiredMarkDisplayMode="Required">
                            <Template>
                                <dx:BootstrapTextBox ID="txtPartNo" runat="server" Text='<%# Bind("PART_NO") %>'>
                                    <ValidationSettings CausesValidation="True" SetFocusOnError="True" ValidationGroup="AddNew">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:BootstrapTextBox>
                            </Template>
                        </dx:BootstrapGridViewColumnLayoutItem>
                        <dx:BootstrapGridViewColumnLayoutItem Caption="Product" ColumnName="PRODUCT_NAME" RequiredMarkDisplayMode="Required">
                            <Template>
                                <dx:BootstrapRadioButtonList ID="rblProduct" runat="server" RepeatDirection="Horizontal" Value='<%# Bind("PRODUCT_NAME") %>' ValueType="System.String">
                                    <ValidationSettings CausesValidation="True" SetFocusOnError="True" ValidationGroup="AddNew">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                    <Items>
                                        <dx:BootstrapListEditItem Text="EAGLERAY​" Value="EAGLERAY​">
                                        </dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Text="EVANS" Value="EVANS">
                                        </dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Text="All​" Value="All​">
                                        </dx:BootstrapListEditItem>
                                    </Items>
                                </dx:BootstrapRadioButtonList>
                            </Template>
                        </dx:BootstrapGridViewColumnLayoutItem>
                        <dx:BootstrapGridViewColumnLayoutItem Caption="STD. Pack" ColumnName="STD_PACK" RequiredMarkDisplayMode="Required">
                            <Template>
                                <dx:BootstrapTextBox ID="txtStd" runat="server" Text='<%# Bind("STD_PACK") %>'>
                                    <ValidationSettings CausesValidation="True" SetFocusOnError="True" ValidationGroup="AddNew">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:BootstrapTextBox>
                            </Template>
                        </dx:BootstrapGridViewColumnLayoutItem>
                        <dx:BootstrapGridViewColumnLayoutItem Caption="Min Qty." ColumnName="MIN_QTY" RequiredMarkDisplayMode="Required">
                            <Template>
                                <dx:BootstrapSpinEdit ID="spMin" runat="server" Value='<%# Bind("MIN_QTY") %>'>
                                    <ValidationSettings CausesValidation="True" SetFocusOnError="True" ValidationGroup="AddNew">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:BootstrapSpinEdit>
                            </Template>
                        </dx:BootstrapGridViewColumnLayoutItem>
                        <dx:BootstrapGridViewColumnLayoutItem Caption="Max Qty." ColumnName="MAX_QTY" RequiredMarkDisplayMode="Required">
                            <Template>
                                <dx:BootstrapSpinEdit ID="spMax" runat="server" Value='<%# Bind("MAX_QTY") %>'>
                                    <ValidationSettings CausesValidation="True" SetFocusOnError="True" ValidationGroup="AddNew">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:BootstrapSpinEdit>
                            </Template>
                        </dx:BootstrapGridViewColumnLayoutItem>
                        <dx:BootstrapGridViewColumnLayoutItem Caption="Category" ColumnName="CATEGORY_ID" RequiredMarkDisplayMode="Required">
                            <Template>
                                <dx:BootstrapComboBox ID="cmbCategory" runat="server" DataSourceID="SqlDataSource1" TextField="CATEGORY_NAME" ValueField="CATEGORY_ID" Value='<%# Bind("CATEGORY_ID") %>'>
                                    <ValidationSettings CausesValidation="True" SetFocusOnError="True" ValidationGroup="AddNew">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                </dx:BootstrapComboBox>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OraConn %>" ProviderName="<%$ ConnectionStrings:OraConn.ProviderName %>" SelectCommand="SELECT &quot;CATEGORY_NAME&quot;, &quot;CATEGORY_ID&quot; FROM &quot;T_DVL_INV_PN_CATEGORY&quot;"></asp:SqlDataSource>
                            </Template>
                        </dx:BootstrapGridViewColumnLayoutItem>
                        <dx:BootstrapGridViewColumnLayoutItem Caption="Status" ColumnName="STATUS" RequiredMarkDisplayMode="Required">
                            <Template>
                                <dx:BootstrapRadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal" Value='<%# Bind("STATUS") %>' ValueType="System.String">
                                    <ValidationSettings CausesValidation="True" SetFocusOnError="True" ValidationGroup="AddNew">
                                        <RequiredField IsRequired="True" />
                                    </ValidationSettings>
                                    <Items>
                                        <dx:BootstrapListEditItem Value="Active">
                                        </dx:BootstrapListEditItem>
                                        <dx:BootstrapListEditItem Value="Inactive">
                                        </dx:BootstrapListEditItem>
                                    </Items>
                                </dx:BootstrapRadioButtonList>
                                
                            </Template>
                        </dx:BootstrapGridViewColumnLayoutItem>
                       <%-- <dx:BootstrapEditModeCommandLayoutItem HorizontalAlign="Right" />--%>

                    </Items>
                </FormLayoutProperties>
            </SettingsEditing>



            <SettingsDataSecurity AllowEdit="True" AllowDelete="True" AllowInsert="True" />
            <SettingsBehavior ConfirmDelete="True" AllowFocusedRow="true" />
            <ClientSideEvents EndCallback="onGrid_EndCallBack" Init="OnGridViewInit" RowClick="OnRowClick" />
            <SettingsPager Mode="ShowAllRecords" />
            <Columns>
                <dx:BootstrapGridViewTextColumn FieldName="PART_NO" VisibleIndex="1">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="0" />
                </dx:BootstrapGridViewTextColumn>

                <dx:BootstrapGridViewTextColumn FieldName="PRODUCT_NAME" Name="PRODUCT_NAME" VisibleIndex="2">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="1" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="STD_PACK" VisibleIndex="3">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="2" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="MIN_QTY" Name="MIN_QTY" VisibleIndex="4">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="3" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="MAX_QTY" Name="MAX_QTY" VisibleIndex="5">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="4" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="CATEGORY_ID" Name="CATEGORY_ID" VisibleIndex="6">
                    <PropertiesTextEdit>
                        <ValidationSettings CausesValidation="True">
                            <RequiredField IsRequired="True" />
                        </ValidationSettings>
                    </PropertiesTextEdit>
                    <SettingsEditForm VisibleIndex="5" />
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn FieldName="STATUS" Name="STATUS" VisibleIndex="7">
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
