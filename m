Return-Path: <cygwin-patches-return-5921-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21554 invoked by alias); 7 Jul 2006 05:25:18 -0000
Received: (qmail 21531 invoked by uid 22791); 7 Jul 2006 05:25:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-44.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.44)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Jul 2006 05:25:14 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id BDF4013C021; Fri,  7 Jul 2006 01:25:11 -0400 (EDT)
Date: Fri, 07 Jul 2006 05:25:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: UTF-8 Cygwin
Message-ID: <20060707052511.GB8827@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <037101c6a0f5$749bb130$a501a8c0@CAM.ARTIMI.COM> <44ADADD0.8000803@oki.com> <20060707024219.GA8827@trixie.casa.cgf.cx> <44ADDFAC.3020200@oki.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ADDFAC.3020200@oki.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00016.txt.bz2

On Fri, Jul 07, 2006 at 01:14:36PM +0900, SUZUKI Hisao wrote:
>Christopher Faylor wrote:
>>I hate to say this but I really don't like doing things this way.  If
>>we need to use wide character support then it should just be a
>>wholesale replacement, not a bunch of wrappers around existing
>>functions.
>>
>>Corinna and I have talked about using the FooW functions for a long
>>time.  There are some fundamental changes required to incorporate these
>>into cygwin but I don't think that wrappers around everything are the
>>way to go.
>
>I hope you will understand that both approaches (wapper approach and
>non-wrapper approach) are _compatible_.
>
>In Cygwin-1.5.20-1 on Windows XP, fhandler_disk_file::readdir() at
>winsup/cygwin/fhandler_disk_file.cc does not use FindNextFileA, one of
>ANSI WIN32 APIs, anymore.  It use so-called undocumented APIs which are
>Unicode-base.  You have implemented your approach here a little,
>haven't you?

Hmm.  Two times in one day where people seem to think that they've made
a telling point by mentioning that cygwin uses the Nt routines.  What are
the odds.

Anyway, I know that you are proud of your patch and I really appreciate
the amount of work that went into it but I really don't want to do
things this way.

I'm really sorry about this.  If you had asked about your approach prior
to implementing it, I'm sure that either Corinna or I would have
expressed our reservations.

cgf
