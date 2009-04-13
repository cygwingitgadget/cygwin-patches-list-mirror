Return-Path: <cygwin-patches-return-6509-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12248 invoked by alias); 13 Apr 2009 17:23:42 -0000
Received: (qmail 12236 invoked by uid 22791); 13 Apr 2009 17:23:41 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f176.google.com (HELO mail-fx0-f176.google.com) (209.85.220.176)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Apr 2009 17:23:37 +0000
Received: by fxm24 with SMTP id 24so2280487fxm.2         for <cygwin-patches@cygwin.com>; Mon, 13 Apr 2009 10:23:34 -0700 (PDT)
Received: by 10.103.6.18 with SMTP id j18mr3443531mui.33.1239643413910;         Mon, 13 Apr 2009 10:23:33 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id y6sm10558915mug.27.2009.04.13.10.23.33         (version=SSLv3 cipher=RC4-MD5);         Mon, 13 Apr 2009 10:23:33 -0700 (PDT)
Message-ID: <49E3778C.2020706@gmail.com>
Date: Mon, 13 Apr 2009 17:23:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add libz to dumper.exe link  [was Re: Re: speclib vs.  -lc  trouble.]
References: <49E3641E.6040407@gmail.com> <20090413165923.GA13222@ednor.casa.cgf.cx>
In-Reply-To: <20090413165923.GA13222@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00051.txt.bz2

Christopher Faylor wrote:

> I think you can get by with just adding -lz to the ALL_LDFLAGS line and
> removing the other stuff.  The tests for libintl and libbfd are supposed
> to just detect if the appropriate directories are available.  There
> isn't likely going to be a libz two levels above cygwin's source
> directory so I don't see any reason to specfically check for it.

  I thought that might happen in a combined tree build with /src and /gcc
together?

    cheers,
      DaveK
