﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MTL_Web
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class Entities : DbContext
    {
        public Entities()
            : base("name=Entities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<T_DVL_INV_PN> T_DVL_INV_PN { get; set; }
        public DbSet<T_DVL_INV_PN_CATEGORY> T_DVL_INV_PN_CATEGORY { get; set; }
        public DbSet<T_DVL_INV_PN_OUT> T_DVL_INV_PN_OUT { get; set; }
        public DbSet<T_DVL_INV_PN_RCV> T_DVL_INV_PN_RCV { get; set; }
        public DbSet<T_DVL_INV_STOCK> T_DVL_INV_STOCK { get; set; }
        public DbSet<T_DVL_INV_STORE> T_DVL_INV_STORE { get; set; }
        public DbSet<T_DVL_INV_USER> T_DVL_INV_USER { get; set; }
    }
}
