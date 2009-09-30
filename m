Return-Path: <cygwin-patches-return-6666-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 836 invoked by alias); 30 Sep 2009 15:55:59 -0000
Received: (qmail 815 invoked by uid 22791); 30 Sep 2009 15:55:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 15:55:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8D8AD6D5598; Wed, 30 Sep 2009 17:55:43 +0200 (CEST)
Date: Wed, 30 Sep 2009 15:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: detect . in a/.//
Message-ID: <20090930155543.GP7193@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC34A01.4070509@byu.net> <20090930152438.GA11977@ednor.casa.cgf.cx> <20090930153451.GA12182@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090930153451.GA12182@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00120.txt.bz2

On Sep 30 11:34, Christopher Faylor wrote:
> bool
> has_dot_last_component (const char *dir, bool test_dot_dot)
> {
>   /* SUSv3: . and .. are not allowed as last components in various system
>      calls.  Don't test for backslash path separator since that's a Win32
>      path following Win32 rules. */
>   const char *last_comp = strrchr (dir, '\0');
> 
>   if (last_comp == dir)
>     return false;       /* Empty string.  Probably shouldn't happen here? */
> 
>   /* Detect run of trailing slashes */
>   while (last_comp > dir && *--last_comp == '/')
>     continue;
> 
>   /* Detect just a run of slashes or a path that does not end with a slash. */
>   if (*last_comp != '.')
>     return false;
> 
>   /* We know we have a trailing dot here.  Check that it really is a standalone "."
>      path component by checking that it is at the beginning of the string or is
>      preceded by a "/" */
>   if (last_comp == dir || *--last_comp == '/')
>     return true;
> 
>   /* If we're not checking for '..' we're done.  Ditto if we're now pointing to
>      a non-dot. */
>   if (!test_dot_dot || *last_comp != '.')
>     return false;               /* either not testing for .. or this was not '..' */
> 
>   /* Repeat previous test for standalone or path component. */
>   return last_comp == dir || last_comp[-1] == '/';
> }

Looks good to me.  Easier to understand than the current code.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
