Return-Path: <cygwin-patches-return-6692-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10953 invoked by alias); 5 Oct 2009 04:25:52 -0000
Received: (qmail 10905 invoked by uid 22791); 5 Oct 2009 04:25:51 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 04:25:45 +0000
Received: by ewy18 with SMTP id 18so2904550ewy.43         for <cygwin-patches@cygwin.com>; Sun, 04 Oct 2009 21:25:42 -0700 (PDT)
Received: by 10.211.143.13 with SMTP id v13mr6519573ebn.21.1254716742419;         Sun, 04 Oct 2009 21:25:42 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 24sm385921eyx.33.2009.10.04.21.25.40         (version=SSLv3 cipher=RC4-MD5);         Sun, 04 Oct 2009 21:25:41 -0700 (PDT)
Message-ID: <4AC978B4.4040206@gmail.com>
Date: Mon, 05 Oct 2009 04:25:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
References: <4AC66C72.7070102@gmail.com> <4AC93DB5.5020303@byu.net>
In-Reply-To: <4AC93DB5.5020303@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00023.txt.bz2

Eric Blake wrote:

> I just noticed that the gcc-4 available on 1.5 is no longer sufficient to
> do a self-hosted build of 1.7.  

  Maybe that should be considered cross- rather than self-hosting?

> Not a show-stopper, since I have
> successfully built self-hosted under 1.7 using the latest patch, but it
> was kind of kind of convenient being able to build under 1.5, as it meant
> fewer cygwin 1.7 processes to stop before installing a just-built dll.

  Anyway, 4.3.4-2 will be out shortly, with a 1.5 version.

    cheers,
      DaveK
