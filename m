Return-Path: <cygwin-patches-return-2477-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20499 invoked by alias); 21 Jun 2002 00:57:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20475 invoked from network); 21 Jun 2002 00:57:08 -0000
Message-ID: <20020621005707.27244.qmail@web20004.mail.yahoo.com>
Date: Thu, 20 Jun 2002 17:57:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: YACP
To: cygwin-patches@cygwin.com
In-Reply-To: <20020621003543.GG7913@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q2/txt/msg00460.txt.bz2

So is the UNC type coming back at some point? 

It would be fine with me to leave the '--type TYPE' syntax as an 
alternative to --unix, --windows, --mixed, but having the --type mixed
as the only way to get a forward-slash Windows path seemed counter-
intuitive to me. Also --type dos to me should mean short-name as well.
So should I put together another patch to do this as well?

And BTW, is the UNIXy default OK?

--- Christopher Faylor <cgf@redhat.com> wrote:
> On Thu, Jun 20, 2002 at 06:17:21PM -0500, Joshua Daniel Franklin wrote:
> >YACP (Yet Another Cygpath Patch)
> >
> >The major change that this make is setting the UNIXy output to be the
> >default. This was already true for the -ADHPSW options. If this is a
> >bad idea for some reason unknown to me, there were only 3 lines changed
> >to do it. (Everything still works with --unix, of course.)
> >
> >Also, thinking about this new --type TYPE option, I was wondering what
> >exactly the 'dos' type did. So I look at the code:
> >
> >-         if (strcasecmp (windows_format_arg, "mixed") == 0)
> >-           mixed_flag = 1;
> >-         else if (strcasecmp (windows_format_arg, "dos") == 0)
> >-           /* nothing */;
> >-         else
> >-           usage (stderr, 1);
> >-         break;
> >
> >Ah! It does /* nothing */, I see. So also this patch REMOVES the
> >-t, --type option and changes it to -m, --mixed instead. This is hopefully
> >easier to understand.
> 
> Actually, there was another option but it was obsolete so I removed it.
> I figured that the --type option would provide the capability for other
> formats for filenames in the future, like //?/ or whatever.
> 
> cgf


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
