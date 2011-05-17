Return-Path: <cygwin-patches-return-7370-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19869 invoked by alias); 17 May 2011 10:19:56 -0000
Received: (qmail 19745 invoked by uid 22791); 17 May 2011 10:19:28 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 17 May 2011 10:19:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8852B2C02D5; Tue, 17 May 2011 12:19:09 +0200 (CEST)
Date: Tue, 17 May 2011 10:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] CPU-time clocks
Message-ID: <20110517101909.GA28443@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1305484641.6124.31.camel@YAAKOV04> <20110515191123.GC21667@calimero.vinschen.de> <1305487887.6000.1.camel@YAAKOV04> <20110516104304.GA5248@calimero.vinschen.de> <1305587458.4248.3.camel@YAAKOV04> <20110517055858.GA9013@calimero.vinschen.de> <1305623445.7016.1.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1305623445.7016.1.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00136.txt.bz2

On May 17 04:10, Yaakov (Cygwin/X) wrote:
> On Tue, 2011-05-17 at 07:58 +0200, Corinna Vinschen wrote:
> > Thank you.  You can apply it, but while I was looking into it,
> > this occured to me:
> > 
> > This conversion arithmetic from FILETIME to long long happens a lot
> > in times.cc, even though it's absolutely not necessary.
> > 
> > The FILETIME struct is actually a LARGE_INTEGER in which just the
> > QuadPart member is missing, unfortunately.  What we can do is to
> > replace the bit shifting stuff with a simple cast:
> > 
> >   x = ((PLARGE_INTEGER) &kernel_time)->QuadPart
> >       + ((PLARGE_INTEGER) &user_time)->QuadPart;
> 
> The MSDN docs on FILETIME[1] state:
> 
> > Do not cast a pointer to a FILETIME structure to either a ULARGE_INTEGER*
> > or __int64* value because it can cause alignment faults on 64-bit Windows.
> 
> As I am by no means an expert on Win32 programming, I take that at face
> value.

I don't think that has anything to do with Win32, it's a potential CPU
problem.  Why this should be the case beats me, though.  Maybe 8 byte
values are supposed to be 8 byte aligned on x86_64.  However, in 32 bit
mode it's definitely no problem.  I tested it:

  FILETIME x;
  printf ("&x = %p\n", &x);
  ((LARGE_INTEGER *) &x)->QuadPart = 0x123456789abcdefLL;
  printf ("x = %llx\n", ((LARGE_INTEGER *) &x)->QuadPart);

  ==>

  &x = 0x28ccb4
  x = 123456789abcdef

If that would have been a problem, we should see a core dump.

> > Alternatively we can define kernel_time etc as LARGE_INTEGER and cast in
> > the call to GetProcessTimes or just call NtQueryInformationProcess.
> 
> I have chosen the latter.  Revised patch attached.

Thanks, please apply.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
