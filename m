Return-Path: <cygwin-patches-return-3221-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4609 invoked by alias); 24 Nov 2002 13:04:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4594 invoked from network); 24 Nov 2002 13:04:16 -0000
Date: Sun, 24 Nov 2002 05:04:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: More passwd/group patches
Message-ID: <20021124140414.Z1398@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DDE3FB9.2AFAA199@ieee.org> <20021122154644.N1398@cygbert.vinschen.de> <3DDE4528.3BDCDCEF@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDE4528.3BDCDCEF@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00172.txt.bz2

Hi Pierre,

a few comments:

On Fri, Nov 22, 2002 at 09:54:32AM -0500, Pierre A. Humblet wrote:
>  static void
>  getace (__aclent16_t &acl, int type, int id, DWORD win_ace_mask, DWORD win_ace_type)
>  {
>    acl.a_type = type;
>    acl.a_id = id;
>  
> -  if (win_ace_mask & FILE_READ_DATA)
> +  if ((win_ace_mask & FILE_READ_DATA) &&
> +      !(acl.a_perm & (ALLOW_R | DENY_R)))

A formatting nit:
As long as these conditionals are not longer than a line, it would be nice
to keep them on one line.  *If* you split the logical expression, please put
the && or || in front of the next line, not at the end of the previous one.

>      if (win_ace_type == ACCESS_ALLOWED_ACE_TYPE)
> -      acl.a_perm |= (acl.a_perm & S_IRGRP) ? 0 : S_IRUSR;
> +      acl.a_perm |= ALLOW_R;
>      else if (win_ace_type == ACCESS_DENIED_ACE_TYPE)
> -      acl.a_perm &= ~S_IRGRP;
> +      acl.a_perm |= DENY_R;

I don't like the idea that these DENY bits are still set when the acl is
returned to the application.  The underlying Solaris acl implementation 
doesn't know about these bits.  They should be removed before returning
the acl to the application.  Otherwise you're using bits which are not
defined in acl.h.

> +      /* Include CLASS_OBJ to insure count > 4 (MIN_ACL_ENTRIES)
> +	 if any default ace exists */
> +      lacl[3].a_perm = lacl[1].a_perm;

You're copying the group bits to the mask?  Didn't you suggest to set
it to rwx?  I think you're right.  It would be better to move this line
to the initialization of the first lacl members and change it to

  lacl[3].a_perm = ALLOW_R | ALLOW_W | ALLOW_X;

> +      int dgpos;
> +      if ((types_def & (USER|GROUP)) 
> +	  && ((dgpos = searchace (lacl, MAX_ACL_ENTRIES, DEF_GROUP_OBJ)),
> +	      (pos = searchace (lacl, MAX_ACL_ENTRIES, DEF_CLASS_OBJ)) >= 0))
> +	{
> +	  lacl[pos].a_type = DEF_CLASS_OBJ;
> +	  lacl[pos].a_perm = lacl[dgpos].a_perm;

Same here, shouldn't the DEF_CLASS_OBJ entry have rwx, too?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
