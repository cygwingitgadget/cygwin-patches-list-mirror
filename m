Return-Path: <cygwin-patches-return-4063-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7232 invoked by alias); 10 Aug 2003 00:12:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7223 invoked from network); 10 Aug 2003 00:12:28 -0000
Date: Sun, 10 Aug 2003 00:12:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030810001228.GB13380@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu> <20030809161211.GB9514@redhat.com> <1060465841.1475.34.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060465841.1475.34.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00079.txt.bz2

On Sun, Aug 10, 2003 at 07:50:41AM +1000, Robert Collins wrote:
>On Sun, 2003-08-10 at 02:12, Christopher Faylor wrote:
>> On Thu, Aug 07, 2003 at 06:50:10PM -0400, Igor Pechtchanski wrote:
>>Also some kind of functionality which would allow cygcheck to query the
>>same files as the web search would be really cool.  Something like a:
>>
>>cygcheck --whatprovides /usr/bin/ls.exe
>>
>>would be really useful.
>
>
>Hmm, I think we're getting into stuff that setup should do itself.  We
>-do- have command line functionality...

Can setup do a:

setup --whatprovides /bin/ls.exe > /tmp/foo

?

I don't see how that will ever be possible given the windows problems with
stdio and GUI apps.  I guess we could make setup a console utility but
that would result in the ugly black console box flashing up whenever
you start setup.exe.

In Red Hat terms, this would be like starting up anaconda (the
installer) every time you want to query RHN.  I don't see how that's
useful.

If the setup library abstraction ever shows up then this would be a
candidate for that.  It is not, IMO, a function for setup itself.

cgf
