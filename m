Return-Path: <cygwin-patches-return-4982-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19882 invoked by alias); 22 Sep 2004 22:05:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19858 invoked from network); 22 Sep 2004 22:05:22 -0000
Date: Wed, 22 Sep 2004 22:05:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still path.cc
Message-ID: <20040922220723.GA7717@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040921215840.0081d100@incoming.verizon.net> <Pine.CYG.4.58.0409220918030.2736@fordpc.vss.fsi.com> <20040922143054.GF26453@trixie.casa.cgf.cx> <Pine.CYG.4.58.0409221047150.2736@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0409221047150.2736@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00134.txt.bz2

On Wed, Sep 22, 2004 at 11:07:09AM -0500, Brian Ford wrote:
>You can't win here.  If you're a developer like person, the answer to
>bug reports is usually "fix it yourslef if it's important to you".  If
>you don't report it, but say thank you when someone fixes it, you get
>"shame on you for not reporting this serious bug".

You apparently aren't paying very close attention.

If you provide a simple test case to the cygwin list, you are generally
thanked for the simple test case and eventually someone will fix it.

If you report a vague bug, you will either be ignored or there will be
some attempt from cygwin mailing list regulars to purify the problem
from, e.g., into "cygwin bash hangs when I do something.  Please help!"
to "cygwin bash hangs when I type 'cd ..somewhere' using cygwin 1.5.11
(cygcheck output included)"

If you report a bug to the cygwin-developers list, you are either
ignored or (more likely) told to fix it yourself since everyone who
joins cygwin-developers is supposed to be at least mildly familiar with
the DLL and has claimed to want to improve cygwin.  cygwin-developers
is also not a bug-reporting list.

If you provide a patch, you are generally thanked for the patch although
there is often some back and forth before the patch goes in.  (Some people
become outraged by this and never send a patch again)

If you mention that you saw the same simple bug long ago and never
reported it (and why you'd bother to do that is perplexing), then you
will probably be matter-of-factly told that you should have reported
it earlier.

And, predictably the response to that will generally be "I didn't have
enough time", "It wasn't my fault", or "It's your fault".

Actually, now that I think of it it's usually all three.

HTH.

cgf
