Return-Path: <cygwin-patches-return-2476-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10217 invoked by alias); 21 Jun 2002 00:35:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10200 invoked from network); 21 Jun 2002 00:35:02 -0000
Date: Thu, 20 Jun 2002 17:35:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: YACP
Message-ID: <20020621003543.GG7913@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.44.0206201816310.96-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0206201816310.96-200000@iocc.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00459.txt.bz2

On Thu, Jun 20, 2002 at 06:17:21PM -0500, Joshua Daniel Franklin wrote:
>YACP (Yet Another Cygpath Patch)
>
>The major change that this make is setting the UNIXy output to be the
>default. This was already true for the -ADHPSW options. If this is a
>bad idea for some reason unknown to me, there were only 3 lines changed
>to do it. (Everything still works with --unix, of course.)
>
>Also, thinking about this new --type TYPE option, I was wondering what
>exactly the 'dos' type did. So I look at the code:
>
>-         if (strcasecmp (windows_format_arg, "mixed") == 0)
>-           mixed_flag = 1;
>-         else if (strcasecmp (windows_format_arg, "dos") == 0)
>-           /* nothing */;
>-         else
>-           usage (stderr, 1);
>-         break;
>
>Ah! It does /* nothing */, I see. So also this patch REMOVES the
>-t, --type option and changes it to -m, --mixed instead. This is hopefully
>easier to understand.

Actually, there was another option but it was obsolete so I removed it.
I figured that the --type option would provide the capability for other
formats for filenames in the future, like //?/ or whatever.

cgf
