Return-Path: <cygwin-patches-return-3698-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27250 invoked by alias); 12 Mar 2003 08:52:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27239 invoked from network); 12 Mar 2003 08:52:29 -0000
Date: Wed, 12 Mar 2003 08:52:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_socket::dup
Message-ID: <20030312085227.GL13544@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030310200902.007f3100@mail.attbi.com> <20030311102431.GB13544@cygbert.vinschen.de> <3E6DF617.CA7DC2C0@ieee.org> <3.0.5.32.20030312001525.007f5310@incoming.verizon.net> <20030312055720.GB10425@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312055720.GB10425@redhat.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00347.txt.bz2

On Wed, Mar 12, 2003 at 12:57:20AM -0500, Christopher Faylor wrote:
> On Wed, Mar 12, 2003 at 12:15:25AM -0500, Pierre A. Humblet wrote:
> >At 04:20 PM 3/11/2003 +0100, Corinna Vinschen wrote:
> >
> >>> > I'm seriously concidering to remove all the fixup_before/fixup_after
> >>> > from fhandler_socket::dup() and just call fhandler_base::dup() on
> >>> > NT systems.
> >
> >Corinna,
> >
> >I like that and I have pushed the logic to also do it on Win9X, without
> >apparent bad effects. I just delivered 140 e-mails from a WinME to an exim 
> >server on Win98, ran inetd, ssh, etc... I also tried duping a socket after a 
> >fork, it worked fine.
> 
> I think it doesn't work fine on Windows 95, IIRC.

I search email archives and MSDN again and it is possible that I used
the same fixup_before/fixup_after technique in dup for... well, symmetry.
All errors mentioned in KB on sockets are actually related to sockets
duplicated between processes.  Win95 wasn't related, AFAIR, since it
didn't even have WinSock2 installed by default.

Anyway, the question is if it's worth the risk to break anything again
by reverting to DupHandle also for 9x.  What's the gain of doing this?
AFAICS, just speed.  It's not expected to work "better".

I'm not using 9x on a daily basis (all my 98 installations are very
unstable for no apparent reason) and so my tests are very brief.

Hesitant,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
