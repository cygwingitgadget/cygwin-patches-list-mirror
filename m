Return-Path: <cygwin-patches-return-2802-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17782 invoked by alias); 8 Aug 2002 13:53:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17768 invoked from network); 8 Aug 2002 13:53:42 -0000
Date: Thu, 08 Aug 2002 06:53:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: minor patch to printf
Message-ID: <20020808155339.G4229@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches <cygwin-patches@cygwin.com>
References: <3D52765A.5000507@hekimian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D52765A.5000507@hekimian.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00250.txt.bz2

On Thu, Aug 08, 2002 at 09:47:06AM -0400, Joe Buehler wrote:
> A minor patch for a printf format problem is attached.

Thanks.  And the ChangeLog is where...?

Corinna

> 
> Joe Buehler

> Index: src/winsup/cygwin/sec_helper.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/sec_helper.cc,v
> retrieving revision 1.23
> diff -u -r1.23 sec_helper.cc
> --- src/winsup/cygwin/sec_helper.cc	3 Jul 2002 03:20:50 -0000	1.23
> +++ src/winsup/cygwin/sec_helper.cc	8 Aug 2002 13:41:27 -0000
> @@ -432,8 +442,8 @@
>    if (sid1)
>      if (!AddAccessAllowedAce (acl, ACL_REVISION,
>  			      GENERIC_ALL, sid1))
> -      debug_printf ("AddAccessAllowedAce(sid1) %E", sid1);
> +      debug_printf ("AddAccessAllowedAce(sid1) %E");
>    if (admins)
>      if (!AddAccessAllowedAce (acl, ACL_REVISION,
>  			      GENERIC_ALL, well_known_admins_sid))


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
