﻿using System.Linq;
using System.Web.Http;
using System.Web.Http.OData.Query;
using YangKai.BlogEngine.Common;
using YangKai.BlogEngine.Domain;

namespace YangKai.BlogEngine.Web.Mvc.Controllers.OData
{
    public class BoardController : EntityController<Board>
    {
        [Queryable(AllowedQueryOptions = AllowedQueryOptions.All, PageSize = 100, MaxExpansionDepth = 5)]
        public override IQueryable<Board> Get()
        {
            return base.Get();
        }

        protected override Board CreateEntity(Board entity)
        {
            if (!Current.IsAdmin)
            {
                Current.User = new WebUser
                {
                    UserName = entity.Author,
                    Email = entity.Email,
                };
            }
            entity.Ip = Request.Headers.From;
            var security = Config.UseDomainAccount ? (IUserSecurity)new NeweggUserSecurity() : new LocalUserSecurity();
            entity.Avatar = security.GetAvater(Current.User);
            return base.CreateEntity(entity);
        }
    }
}