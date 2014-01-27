Return-Path: <cygwin-patches-return-7954-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9697 invoked by alias); 27 Jan 2014 06:53:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9682 invoked by uid 89); 27 Jan 2014 06:53:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-la0-f41.google.com
Received: from mail-la0-f41.google.com (HELO mail-la0-f41.google.com) (209.85.215.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Mon, 27 Jan 2014 06:53:00 +0000
Received: by mail-la0-f41.google.com with SMTP id mc6so4178676lab.14        for <cygwin-patches@cygwin.com>; Sun, 26 Jan 2014 22:52:57 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.112.175.43 with SMTP id bx11mr69293lbc.51.1390805576880; Sun, 26 Jan 2014 22:52:56 -0800 (PST)
Received: by 10.112.167.35 with HTTP; Sun, 26 Jan 2014 22:52:56 -0800 (PST)
In-Reply-To: <20140125063503.GA4898@ednor.casa.cgf.cx>
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>	<20140124203415.GA6857@ednor.casa.cgf.cx>	<CABDpyCg40oJeq=TJxFqidVsuVKRfZycLkK+kCz=Td-QgJafu4g@mail.gmail.com>	<20140125063503.GA4898@ednor.casa.cgf.cx>
Date: Mon, 27 Jan 2014 06:53:00 -0000
Message-ID: <CABDpyCjGbQo6qCJFCfpY1HwY2EL5b5EAVQuRui2QJWw4cE+dvA@mail.gmail.com>
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
From: Daniel Dai <daijyc@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00027.txt.bz2

Yes, that's the Unix behavior. However, bat file will eat the quote.
If you pass "a=b" to bat, you will only get a=b. That's why I can
quote the parameters containing equal sign. But anyway, if cygwin
automatically quote equal sign, I don't need to quote the parameter.
That should enough to solve my problem. Thanks Christopher!
