﻿<%@ Page Title="" Language="C#" MasterPageFile="~/BackEnd/BS_Site.Master" AutoEventWireup="true" CodeBehind="BS_收費標準.aspx.cs" Inherits="testModel01.WebForm12" ValidateRequest="false" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="BS_HeadContent" runat="server">
    <p style="color: #0000CC; font-size: xx-large">
        <strong>收費標準表</strong>
    </p>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BS_BodyContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-striped" DataKeyNames="room" DataSourceID="SqlDataSource1" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" Width="100%" >
        <Columns>
            <asp:BoundField DataField="room" HeaderText="住  房" ReadOnly="True" SortExpression="room">
            <HeaderStyle CssClass="info text-center" Font-Size="Medium" />
            <ItemStyle CssClass="text-center" />
            </asp:BoundField>
            <asp:BoundField DataField="price" HeaderText="基本月費（含住房費、水電費、洗衣費、一般伙食費）" SortExpression="price">
            <HeaderStyle CssClass="info text-center" Font-Size="Medium" />
            <ItemStyle CssClass="text-center" />
            </asp:BoundField>
            <asp:BoundField DataField="care" HeaderText="特殊照護費" SortExpression="care">
            <HeaderStyle CssClass="info text-center" Font-Size="Medium" />
            <ItemStyle CssClass="text-center" />
            </asp:BoundField>
            <asp:BoundField DataField="careprice" HeaderText="費用" SortExpression="careprice">
            <HeaderStyle CssClass="info text-center" Font-Size="Medium" />
            <ItemStyle CssClass="text-center" />
            </asp:BoundField>
            <asp:CommandField ButtonType="Image" CancelImageUrl="~/pic/Cancel32x32.png" EditImageUrl="~/pic/reverse32x32.png" EditText="修改" HeaderText="修改" ShowEditButton="True" UpdateImageUrl="~/pic/save32x32.png" UpdateText="儲存">
            <HeaderStyle CssClass="info text-center" Font-Size="Medium" />
            <ItemStyle CssClass="text-center" Font-Size="Medium" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="刪除">
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Delete" ImageUrl="~/pic/delete32x32.png" OnClientClick="return confirm('確定要刪除？')" ToolTip="點我刪除" />
                </ItemTemplate>
                <HeaderStyle CssClass="info text-center" Font-Size="Medium" />
                <ItemStyle CssClass="text-center" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" SelectCommand="SELECT * FROM [Fees_table_1]" DeleteCommand="DELETE FROM [Fees_table_1] WHERE [room] = @room" InsertCommand="INSERT INTO [Fees_table_1] ([room], [price], [care], [careprice]) VALUES (@room, @price, @care, @careprice)" UpdateCommand="UPDATE [Fees_table_1] SET [price] = @price, [care] = @care, [careprice] = @careprice WHERE [room] = @room">
        <DeleteParameters>
            <asp:Parameter Name="room" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="room" Type="String" />
            <asp:Parameter Name="price" Type="String" />
            <asp:Parameter Name="care" Type="String" />
            <asp:Parameter Name="careprice" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="price" Type="String" />
            <asp:Parameter Name="care" Type="String" />
            <asp:Parameter Name="careprice" Type="String" />
            <asp:Parameter Name="room" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" DeleteCommand="DELETE FROM [note] WHERE [Id] = @Id" InsertCommand="INSERT INTO [note] ([content]) VALUES (@content)" SelectCommand="SELECT * FROM [note]" UpdateCommand="UPDATE [note] SET [content] = @content WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="CKEditorControl2" Name="content" PropertyName="Text" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="content" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-striped" DataKeyNames="Id" DataSourceID="SqlDataSource2" OnRowEditing="GridView2_RowEditing" OnRowUpdated="GridView2_RowUpdated" OnRowUpdating="GridView2_RowUpdating" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="備註">
                <ItemTemplate>
                    <asp:Label ID="lb1" runat="server"  Text='<%#Bind("content") %>'></asp:Label>               
                         </ItemTemplate>
                <EditItemTemplate>
                    
                    <CKEditor:CKEditorControl ID="description" runat="server" Text='<%#Bind("content") %>'>'</CKEditor:CKEditorControl>
                </EditItemTemplate>
                
                <FooterStyle BackColor="#D7EBF7" />
                <HeaderStyle Font-Size="Medium" CssClass="info text-center" />
                
                <ItemStyle CssClass="text-center" Font-Size="Medium" />
                
            </asp:TemplateField>

            <asp:CommandField ButtonType="Image" CancelImageUrl="~/pic/Cancel32x32.png" EditImageUrl="~/pic/reverse32x32.png" EditText="修改" HeaderText="修改" ShowEditButton="True" UpdateImageUrl="~/pic/save32x32.png" UpdateText="儲存">
            <HeaderStyle CssClass="info text-center" Font-Size="Medium" />
            <ItemStyle CssClass="text-center" Font-Size="Medium" />
            </asp:CommandField>

        </Columns>
        
    </asp:GridView>
</asp:Content>
