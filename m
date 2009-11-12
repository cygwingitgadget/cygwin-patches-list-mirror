Return-Path: <cygwin-patches-return-6839-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6924 invoked by alias); 12 Nov 2009 14:42:28 -0000
Received: (qmail 6908 invoked by uid 22791); 12 Nov 2009 14:42:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Nov 2009 14:42:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DC08F6D41A0; Thu, 12 Nov 2009 15:42:07 +0100 (CET)
Date: Thu, 12 Nov 2009 14:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
Message-ID: <20091112144207.GJ26238@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AFA6675.6070408@users.sourceforge.net>  <20091111094119.GA3564@calimero.vinschen.de>  <4AFA907E.1050408@users.sourceforge.net>  <4AFAB42C.1020404@byu.net>  <4AFB0042.90602@users.sourceforge.net>  <20091111202106.GA17519@ednor.casa.cgf.cx>  <20091112094424.GA12637@calimero.vinschen.de>  <4AFBDF1A.9020606@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AFBDF1A.9020606@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00170.txt.bz2

On Nov 12 04:10, Yaakov S wrote:
> On 12/11/2009 03:44, Corinna Vinschen wrote:
> >In this case I'm rather surprised that these very GNU/Linux specific
> >things are *not* in a linux/sysinfo.h file.  But it doesn't hurt to keep
> >that in line with Linux, right?
> 
> In that case, here is a patch which declares directly in sys/sysinfo.h.
> 
> 
> Yaakov

> 2009-11-12  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
> 
> 	* sysconf.cc (get_nprocs, get_nprocs_conf): New functions.
> 	* cygwin.din: Export them.
> 	* include/sys/sysinfo.h: New header.
> 	(get_nprocs, get_nprocs_conf): Declare.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
> 	* posix.sgml: Mention them as GNU extensions.

Thanks, I applied the change with a few changes.

First of all, I took the opportunity to add get_phys_pages and
get_avphys_pages as well so we only have to bump the API minor
number once.

Second, I added the C++ guards to sys/sysinfo.h, as Vaclav pointeed out.

Third, a tiny formatting change:

> +extern "C" int
> +get_nprocs_conf (void)
> +{
> +  return get_nproc_values(_SC_NPROCESSORS_CONF);
                           ^^^
                           Please add a space in front of an opening
                           parenthesis.

Finally, I added the new API to the "What's new" section in the User's
Guide as well.


Thanks again,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
