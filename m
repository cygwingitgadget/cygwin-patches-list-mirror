Return-Path: <cygwin-patches-return-6166-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26523 invoked by alias); 16 Nov 2007 11:09:13 -0000
Received: (qmail 26509 invoked by uid 22791); 16 Nov 2007 11:09:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 16 Nov 2007 11:09:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id F39B26D4805; Fri, 16 Nov 2007 12:09:01 +0100 (CET)
Date: Fri, 16 Nov 2007 11:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Encode invalid chars in /proc/registry entries
Message-ID: <20071116110901.GK30894@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <473CC0A6.6010409@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473CC0A6.6010409@t-online.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00018.txt.bz2

Hi Christian,

On Nov 15 22:56, Christian Franke wrote:
> Registry key and value names may contain chars which are not allowed within 
> file names ('/', '\', ":"). But Cygwin's /proc/registry returns these names 
> unchanged to the app. The obvious effect is that such entries cannot be 
> accessed.
>
> But if an entry name is identical to an existing path, more interesting 
> results occur. Cygwin itself adds registry entries which are testcases for 
> this issue :-))
> [...]
> The attached patch encodes the critical chars with %XX to avoid such 
> problems.
>
> Patch is tested with 1.5.24-2. Merge with HEAD looks good, but was not 
> actually tested. Therefore, no changelog provided yet.

Thanks for this patch.  Apart from the missing ChangeLog I'm inclined
to apply it to the upcoming 1.5.25 release, but I don't like to have it
in HEAD as is.

The reason is that the patch introduces more usages of CYG_MAX_PATH plus
static buffers of that size.  That's ok for 1.5, but that's not ok
anymore for 1.7.  We're heading to support PATH_MAX = ~32K paths.  The
registry also supports long paths, unfortunately with undefined max
length.  The current definition in MSDN(*) is

  Max name length of keys:      255 chars
  Max name length of values:  16383 chars
  Max tree depth:               512 levels

So, for HEAD I'd like to ask you to allow arbitrary path lengths in your
code.  Personally I could live with restricting registry paths to
PATH_MAX as well.

While you're digging in registry code anyway... would you be interested
to convert the entire registry code to wide char and long path names?
I'd be glad for any help.


Corinna

(*) http://msdn2.microsoft.com/en-us/library/ms724872.aspx

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
