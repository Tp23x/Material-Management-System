<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="store.aspx.cs" Inherits="MTL_Web.store" %>
<%@ Register assembly="DevExpress.Web.Bootstrap.v20.2" namespace="DevExpress.Web.Bootstrap" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">



    <dx:BootstrapGridView runat="server" KeyFieldName="STORE_ID" EnableRowsCache="False" Width="90%" align="Center"  ID="gvMasterS">
        <SettingsEditing Mode="PopupEditForm"></SettingsEditing>
        <SettingsDataSecurity AllowEdit="true" AllowDelete="true" AllowInsert="true" />
        <Columns >
            <dx:BootstrapGridViewCommandColumn ShowEditButton="true" ShowDeleteButton="true" ShowNewButtonInHeader="true" />
            <dx:BootstrapGridViewDataColumn FieldName="PART_ID" Visible="false" />
            <dx:BootstrapGridViewDataColumn FieldName="PART_NO" />
            <dx:BootstrapGridViewDataColumn FieldName="PRODUCT_NAME" />
            <dx:BootstrapGridViewDataColumn FieldName="STD_PACK" />
            <dx:BootstrapGridViewDataColumn FieldName="MIN_QTY" />
            <dx:BootstrapGridViewDataColumn FieldName="MAX_QTY" />
            <dx:BootstrapGridViewDataColumn FieldName="CATEGORY_ID" />
            <dx:BootstrapGridViewDataColumn FieldName="STATUS" />
        
        </Columns>
        </dx:BootstrapGridView>



</asp:Content>
