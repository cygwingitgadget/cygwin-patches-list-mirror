Return-Path: <cygwin-patches-return-2703-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17925 invoked by alias); 24 Jul 2002 11:01:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17774 invoked from network); 24 Jul 2002 11:01:38 -0000
Date: Wed, 24 Jul 2002 04:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: serial patch - second attempt
Message-ID: <20020724130136.M13588@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3D327F4D.C8E80EB8@certum.pl> <20020723165007.E13588@cygbert.vinschen.de> <3D3E5EE3.874A9705@certum.pl> <20020724100802.K13588@cygbert.vinschen.de> <3D3E610C.7C73346B@certum.pl> <20020724101302.L13588@cygbert.vinschen.de> <3D3E65BC.5863C1E@certum.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3E65BC.5863C1E@certum.pl>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00151.txt.bz2

On Wed, Jul 24, 2002 at 10:30:52AM +0200, Jacek Trzcinski wrote:
> What can I say ? I do not know reason You changed wincap.is_winnt() on
> wincap.must_init_serial_line(). In my opinion conditionals utilizing

The reason to use wincap is to not ask for operating systems as far
as possible but instead to ask for a specific capabilities of the
system we're just running on.  Nobody actually cares if the system
is a 95 OSR2 or a NT4 SP5.  CInstead, by using specific capabilities
the code itself answers the question "why are we doing this" e. g.:

  if (wincap.has_lseek_bug ())
    workaround;

Doesn't that make sense?

> is_wint() are better but if You do want to change it I suggest something
> like wincap.support_modem_output_lines_reading
> which is accurate to function it serves to.

Ok, I've choosen 'supports_reading_modem_output_lines'

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
