Return-Path: <cygwin-patches-return-4962-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15350 invoked by alias); 14 Sep 2004 08:30:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15340 invoked from network); 14 Sep 2004 08:30:03 -0000
Date: Tue, 14 Sep 2004 08:30:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Cc: Sam Steingold <sds@gnu.org>
Subject: Re: RTLD_DEFAULT & RTLD_NEXT
Message-ID: <20040914083050.GB3757@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Sam Steingold <sds@gnu.org>
References: <u65704sup.fsf@gnu.org> <20040830143832.GE17670@cygbert.vinschen.de> <uisb018x4.fsf@gnu.org> <20040831083258.GA7517@cygbert.vinschen.de> <u1xhn1gaz.fsf@gnu.org> <20040831190826.GV17670@cygbert.vinschen.de> <uoekrxfqx.fsf@gnu.org> <20040901094429.GY17670@cygbert.vinschen.de> <uoekhx0m9.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uoekhx0m9.fsf@gnu.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00114.txt.bz2

Hi Sam,

thanks for the patch.  There are still a couple of problems, which
I solved manually for now.

On Sep  7 16:52, Sam Steingold wrote:
> the (C) assignment is in the mail.
> 
> 2004-08-31  Sam Steingold  <sds@gnu.org>
> 
> 	* dlfcn.cc (dlsym): Handle RTLD_DEFAULT using EnumProcessModules().
> 	* include/dlfcn.h (RTLD_DEFAULT): Define to NULL.

The autoload.cc change is missing in the ChangeLog.

Compiling dlfcn.cc failed(!) because the compiler couln't find a definition
for EnumProcessModules.  Including psapi.h was missing, apparently.

Then you're a bit thrifty with spaces...

> +      if (!EnumProcessModules(cur_proc,NULL,0,&needed))
         if (!EnumProcessModules (cur_proc, NULL, 0, &needed))

> +      modules = (HMODULE*)alloca(needed);
         modules = (HMODULE *) alloca (needed);

> +      for (i=0; i < needed/sizeof(HMODULE); i++)
         for (i = 0; i < needed / sizeof (HMODULE); i++)
etc.

>  LoadDLLfunc (DuplicateToken, 12, advapi32)
>  LoadDLLfuncEx (DuplicateTokenEx, 24, advapi32, 1)
> +LoadDLLfuncEx (EnumProcessModules, 16, psapi, 1)

The definition of EnumProcessModules should go where the definitions
of psapi modules are.  As mentioned in my previous posting, the autoload
list is sorted by libraries.


Otherwise the patch looks ok.  Applied with the above changes.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
