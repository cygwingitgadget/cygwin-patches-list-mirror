Return-Path: <cygwin-patches-return-6685-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2992 invoked by alias); 4 Oct 2009 13:53:23 -0000
Received: (qmail 2982 invoked by uid 22791); 4 Oct 2009 13:53:22 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 13:53:19 +0000
Received: by ewy18 with SMTP id 18so2551029ewy.43         for <cygwin-patches@cygwin.com>; Sun, 04 Oct 2009 06:53:16 -0700 (PDT)
Received: by 10.211.132.37 with SMTP id j37mr5809595ebn.76.1254664394676;         Sun, 04 Oct 2009 06:53:14 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm2367591eyb.13.2009.10.04.06.53.13         (version=SSLv3 cipher=RC4-MD5);         Sun, 04 Oct 2009 06:53:14 -0700 (PDT)
Message-ID: <4AC8AC37.4050306@gmail.com>
Date: Sun, 04 Oct 2009 13:53:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de> <4AC75235.1070403@gmail.com> <4AC84E5A.7040203@gmail.com> <20091004112648.GE4563@calimero.vinschen.de>
In-Reply-To: <20091004112648.GE4563@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00016.txt.bz2

Corinna Vinschen wrote:

> Since I have a running gcc-4.34 now, do you still want me to do that?
> Plaese keep in mind that I'm a lazy cow...

  Efficient use of resources != laziness.  No, I wouldn't suggest doing that,
what you ended up with by hacking the header files should (in theory, anyway)
be the same as what you would get if the autoconf tests had done it for you.

  Now that all the related mysteries are solved, I'll go ahead and commit that
patch to the build flags.  (I just thought it would be kind of wrong of me to
leave HEAD in a state where the one and only actual RedHat staffer working on
the project couldn't compile it!)

    cheers,
      DaveK
