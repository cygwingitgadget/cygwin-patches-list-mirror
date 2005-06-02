Return-Path: <cygwin-patches-return-5505-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24823 invoked by alias); 2 Jun 2005 12:45:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24656 invoked by uid 22791); 2 Jun 2005 12:45:05 -0000
Received: from [82.139.192.138] (HELO koeln.convey.de) (82.139.192.138)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 02 Jun 2005 12:45:05 +0000
Received: from [192.168.1.12] (192.168.1.12:3983)
	by koeln.convey.de with [XMail 1.20 ESMTP Server]
	id <SEF7BE> for <cygwin-patches@cygwin.com> from <gerrit@familiehaase.de>;
	Thu, 2 Jun 2005 14:45:01 +0200
Message-ID: <429EFF4D.4080603@familiehaase.de>
Date: Thu, 02 Jun 2005 12:45:00 -0000
From: "Gerrit P. Haase" <gerrit@familiehaase.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
MIME-Version: 1.0
To: Brian Dessent <brian@dessent.net>
CC:  cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
References: <428A7520.7FD9925C@dessent.net> <20050518080133.GA25438@calimero.vinschen.de> <20050518133417.GB19793@trixie.casa.cgf.cx> <428B480D.E465C6E8@dessent.net>
In-Reply-To: <428B480D.E465C6E8@dessent.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00101.txt.bz2

Brian Dessent wrote:

> Christopher Faylor wrote:
> 
> 
>>>While this might help to avoid... something, I'm seriously wondering
>>>what's wrong with this expression.  Why does each new version of gcc
>>>add new incompatibilities?
>>
>>Well, it might actually be "a gcc bug".
> 
> 
> Here I admit to using a snapshot verion of gcc and not the 4.0 release,
> primarily because I had read of bug reports e.g. KDE blacklisting 4.0
> entirely in their build scripts due to compiler problems.  So who knows,
> maybe I should try with a release build.
> 
> $ g++-4 -v
> Using built-in specs.
> Target: i686-pc-cygwin
> Configured with: ../gcc-4.1-20050501/configure --verbose
> --prefix=/usr/local --exec-prefix=/usr/local --sysconfdir=/etc
> --libdir=/usr/local/lib --libexecdir=/usr/local/lib
> --mandir=/usr/local/man --infodir=/usr/local/info --program-suffix=-4
> --enable-languages=c,c++ --disable-nls --without-included-gettext
> --with-system-zlib --enable-interpreter --enable-threads=posix
> --enable-sjlj-exceptions --disable-version-specific-runtime-libs
> --disable-win32-registry
> Thread model: posix
> gcc version 4.1.0 20050501 (experimental)

I want to switch using --disable-sjlj-exceptions with gcc-4.x, could you 
try to build with this instead of --enabl-sjlj?


Gerrit
-- 
=^..^=
