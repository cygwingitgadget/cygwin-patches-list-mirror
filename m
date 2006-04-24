Return-Path: <cygwin-patches-return-5842-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12423 invoked by alias); 24 Apr 2006 16:43:07 -0000
Received: (qmail 12409 invoked by uid 22791); 24 Apr 2006 16:43:07 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 24 Apr 2006 16:43:05 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id A2AF313C02B; Mon, 24 Apr 2006 12:43:03 -0400 (EDT)
Date: Mon, 24 Apr 2006 16:43:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
Message-ID: <20060424164303.GF3753@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com> <20060421172328.GD7685@calimero.vinschen.de> <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com> <20060421191314.GA11311@trixie.casa.cgf.cx> <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com> <20060421201200.GA8588@trixie.casa.cgf.cx> <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com> <20060421213928.GC31141@trixie.casa.cgf.cx> <029001c667ba$754ff470$280010ac@wirelessworld.airvananet.com> <20060424163558.GE3753@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424163558.GE3753@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00030.txt.bz2

On Mon, Apr 24, 2006 at 12:35:59PM -0400, Christopher Faylor wrote:
>I get a "it works" when I do this.
>
>#include <stdio.h>
>
>int
>main (int argc, char **argv)
>{
>  if (*argv[0] == 'f')
>    puts ("it works");
>}

But, in keeping with my previously noticed propensity for gaining
intelligence five seconds after hitting 'y', it occurred to me that my
test case was flawed.  Changing the above 'if' so that it did this:

  if (*argv[1] == 'o')

resulted in a SEGV.  So I got the precedence of '*' wrong.  I've checked
in a patch to deal with this problem.

cgf
