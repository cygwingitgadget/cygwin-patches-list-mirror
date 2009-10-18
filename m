Return-Path: <cygwin-patches-return-6783-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26774 invoked by alias); 18 Oct 2009 15:53:42 -0000
Received: (qmail 26764 invoked by uid 22791); 18 Oct 2009 15:53:41 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 15:53:37 +0000
Received: by ey-out-1920.google.com with SMTP id 3so2801653eyh.14         for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2009 08:53:34 -0700 (PDT)
Received: by 10.210.3.21 with SMTP id 21mr3704536ebc.15.1255881214298;         Sun, 18 Oct 2009 08:53:34 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm2342666eyb.32.2009.10.18.08.53.33         (version=SSLv3 cipher=RC4-MD5);         Sun, 18 Oct 2009 08:53:33 -0700 (PDT)
Message-ID: <4ADB3D80.4050108@gmail.com>
Date: Sun, 18 Oct 2009 15:53:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de> <4ADB22B8.5060108@cwilson.fastmail.fm>
In-Reply-To: <4ADB22B8.5060108@cwilson.fastmail.fm>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00114.txt.bz2

Charles Wilson wrote:
> Corinna Vinschen wrote:
> 
>> The Mingw developers should approve mingw stuff, usually.
> 
> Then any interested parties should read the ongoing thread here:
> http://thread.gmane.org/gmane.comp.gnu.mingw.devel/3478
> 
> IMO, Keith is being unreasonable about "if DESTDIR doesn't work on
> win32, we shouldn't add support for it even for those platforms where it
> will work".  He's graciously allowed that this patch could go in, IF I
> convince the automake and autoconf developers to completely redesign the
>  way DESTDIR works so that it accommodates X: paths.

  Well, I can think of a possible counter-proposal: how about a patch that
adds DESTDIR in the normal manner, but only on platforms that support DESTDIR
correctly?  This could be done by testing the --host setting in the Makefile
and either warning, erroring, or just silently overriding the definition of
DESTDIR to empty on platforms that don't can't or won't honour it.  There
shouldn't be anything particularly controversial about the concept of using a
feature on some platforms where it's implemented and not on others where it isn't.

    cheers,
      DaveK
