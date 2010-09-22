Return-Path: <cygwin-patches-return-7114-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21735 invoked by alias); 22 Sep 2010 09:59:35 -0000
Received: (qmail 21655 invoked by uid 22791); 22 Sep 2010 09:59:15 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 22 Sep 2010 09:59:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8F6D16D416D; Wed, 22 Sep 2010 11:59:06 +0200 (CEST)
Date: Wed, 22 Sep 2010 09:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100922095906.GG13235@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx> <20100910183940.GA14132@calimero.vinschen.de> <4C8C9408.3060304@gmail.com> <20100912114115.GA1113@calimero.vinschen.de> <4C8E0AC7.9080409@gmail.com> <20100914100533.GC15121@calimero.vinschen.de> <4C99980F.5010202@gmail.com> <20100922093208.GF13235@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20100922093208.GF13235@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00074.txt.bz2

On Sep 22 11:32, Corinna Vinschen wrote:
> On Sep 22 07:45, Yoni Londner wrote:
> > I checked out why, and found out that #1 and #2 don't modify the
> > access time of the file, whereas #3 does. This already immediately
> 
> I just checked this and I can't see that it does.  If it would do
> so, shouldn't the access time be different every time I call stat?
> 
>   $ stat foo | grep 'Access: [0-9]'
>   Access: 2010-09-09 16:27:20.769055700 +0200
>   $ stat foo | grep 'Access: [0-9]'
>   Access: 2010-09-09 16:27:20.769055700 +0200
>   $ stat foo | grep 'Access: [0-9]'
>   Access: 2010-09-09 16:27:20.769055700 +0200
> 
> I tried it on Windows XP SP3 and Windows 7.

Did you test this on a "noacl" mount, or on a filesystem which doesn't
keep permissions, like FAT?  If so, then I know what happens.  This is
the executable test in fhandler_base::fstat_helper.  It reads the first
two bytes from the file to identify executables by their magic number.
This is especially done to identify shell scripts by their "#!" magic,
so that they are marked as executable in st_mode.  You can switch this
off by specifing the "exec" or "notexec" mount options.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
