Return-Path: <cygwin-patches-return-2705-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3424 invoked by alias); 24 Jul 2002 11:29:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3391 invoked from network); 24 Jul 2002 11:28:59 -0000
Message-ID: <3D3E8FD0.F8C9E01A@certum.pl>
Date: Wed, 24 Jul 2002 04:29:00 -0000
From: Jacek Trzcinski <jacek@certum.pl>
Reply-To: jacek@certum.pl
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: serial patch - second attempt
References: <3D327F4D.C8E80EB8@certum.pl> <20020723165007.E13588@cygbert.vinschen.de> <3D3E5EE3.874A9705@certum.pl> <20020724100802.K13588@cygbert.vinschen.de> <3D3E610C.7C73346B@certum.pl> <20020724101302.L13588@cygbert.vinschen.de> <3D3E65BC.5863C1E@certum.pl> <20020724130136.M13588@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00153.txt.bz2

OK, I see.
I have question concerned with minicom. Nicholas asked me about porting
it for serial patch testing so I guess nobody ported it for Cygwin so
far. I took some sources from internet designed for unix-like systems.
Creation of minicom.exe seemed to be  succesfull after some modification
but I have no possibility to test it. Other matter is if anybody is
going to  utilize this software. What do You think about it ?

Jacek

Corinna Vinschen wrote:
> 
> On Wed, Jul 24, 2002 at 10:30:52AM +0200, Jacek Trzcinski wrote:
> > What can I say ? I do not know reason You changed wincap.is_winnt() on
> > wincap.must_init_serial_line(). In my opinion conditionals utilizing
> 
> The reason to use wincap is to not ask for operating systems as far
> as possible but instead to ask for a specific capabilities of the
> system we're just running on.  Nobody actually cares if the system
> is a 95 OSR2 or a NT4 SP5.  CInstead, by using specific capabilities
> the code itself answers the question "why are we doing this" e. g.:
> 
>   if (wincap.has_lseek_bug ())
>     workaround;
> 
> Doesn't that make sense?
> 
> > is_wint() are better but if You do want to change it I suggest something
> > like wincap.support_modem_output_lines_reading
> > which is accurate to function it serves to.
> 
> Ok, I've choosen 'supports_reading_modem_output_lines'
> 
> Corinna
> 
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.
