Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 533394BA2E24; Mon, 22 Dec 2025 10:22:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 533394BA2E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766398967;
	bh=vq2/ci5tiyZO0jxuqe17PjlEaz8Ju7XHc2EaGLl2SYw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=w+Jbj3pHtWf5qa5DgOL8fLoihW/EyZki2qv25C1bGlHBcCbzYWO57O6jColBdTwg5
	 speT3yOhlp7T/9oGjklhgoyvTagxk0Fe2Sb9M9xsxAVt7qSLORdQLhg8Bf+hbrItZk
	 m+pcxQzhUxkC4S7EKVdBCLdBlmCHhKGbdezWt5OE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 65023A80D4B; Mon, 22 Dec 2025 11:22:45 +0100 (CET)
Date: Mon, 22 Dec 2025 11:22:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/4] Cygwin: uinfo: allow to override user account as
 primary group
Message-ID: <aUkb9XD6oKFaSqOr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251218112308.1004395-1-corinna-cygwin@cygwin.com>
 <20251218112308.1004395-3-corinna-cygwin@cygwin.com>
 <20251222150715.1a927b6963b98a34b172d7a9@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222150715.1a927b6963b98a34b172d7a9@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 22 15:07, Takashi Yano wrote:
> On Thu, 18 Dec 2025 12:23:06 +0100
> Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > Do not only allow to override the (localized) group "None" as primary
> > group, but also the user account.  The user account is used as primary
> > group in the user token, if the user account is a Microsoft Account or
> > an AzureAD account.
> 
> Is there any evidence of:
> "The user account is used as primary group in the user token, "

I don't quite understand the question.  That's what I'm trying to
explain with this sentence:

  The user account is used as primary group in the user token, if the
  user account is a Microsoft Account or an AzureAD account.

This was a known problem at the time Microsoft Accounts have been
introduced.  I never had a Microsoft Account myself since I'm
setting up my machines as AD DC or member machines, but we hit this
problem back in 2014.

I think the first patch handling Microsoft Accounts was 439b7db7850cb
("* grp.cc (internal_getgroups): Drop unused cygsid variable.").

In 2016 we also got the new Azure AD accounts, first patch handling them
was eb61113daf84b ("Workaround AzureAD shortcomings").

> 
> > 
> > Fixes: dc7b67316d01 ("Cygwin: uinfo: prefer token primary group")
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > ---
> >  winsup/cygwin/uinfo.cc | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > index 8e9b9e07de9d..fb4618b8a19e 100644
> > --- a/winsup/cygwin/uinfo.cc
> > +++ b/winsup/cygwin/uinfo.cc
> > @@ -170,13 +170,17 @@ internal_getlogin (cygheap_user &user)
> >  	 group of a local user ("None", localized), we have to find the SID
> >  	 of that group and try to override the token primary group.  Also
> >  	 makes sure we're not on a domain controller, where account_sid ()
> > -	 == primary_sid (). */
> > +	 == primary_sid ().
> > +	 CV 2025-12-05: Microsoft Accounts as well as AzureAD accounts have
> > +	 the primary group SID in their user token set to their own user SID.
> > +	 Allow to override them as well. */
> >        gsid = cygheap->dom.account_sid ();
> >        gsid.append (DOMAIN_GROUP_RID_USERS);
> >        if (!pgrp
> >  	  || (pwd->pw_gid != pgrp->gr_gid
> >  	      && cygheap->dom.account_sid () != cygheap->dom.primary_sid ()
> > -	      && RtlEqualSid (gsid, user.groups.pgsid)))
> > +	      && (gsid == user.groups.pgsid
> > +		  || user.sid () == user.groups.pgsid)))
> >  	{
> >  	  if (gsid.getfromgr (grp = internal_getgrgid (pwd->pw_gid, &cldap)))
> >  	    {
> > -- 
> > 2.52.0
> 
> Other than that LGTM.

Thanks,
Corinna
