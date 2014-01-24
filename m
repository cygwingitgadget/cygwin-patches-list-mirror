Return-Path: <cygwin-patches-return-7952-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8995 invoked by alias); 24 Jan 2014 23:14:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8982 invoked by uid 89); 24 Jan 2014 23:14:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS,WEIRD_QUOTING autolearn=ham version=3.3.2
X-HELO: mail-la0-f42.google.com
Received: from mail-la0-f42.google.com (HELO mail-la0-f42.google.com) (209.85.215.42) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Fri, 24 Jan 2014 23:14:34 +0000
Received: by mail-la0-f42.google.com with SMTP id hr13so3087829lab.1        for <cygwin-patches@cygwin.com>; Fri, 24 Jan 2014 15:14:30 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.152.163.69 with SMTP id yg5mr7424092lab.33.1390605270435; Fri, 24 Jan 2014 15:14:30 -0800 (PST)
Received: by 10.112.167.35 with HTTP; Fri, 24 Jan 2014 15:14:30 -0800 (PST)
In-Reply-To: <20140124203415.GA6857@ednor.casa.cgf.cx>
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com>	<20140124203415.GA6857@ednor.casa.cgf.cx>
Date: Fri, 24 Jan 2014 23:14:00 -0000
Message-ID: <CABDpyCg40oJeq=TJxFqidVsuVKRfZycLkK+kCz=Td-QgJafu4g@mail.gmail.com>
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
From: Daniel Dai <daijyc@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00025.txt.bz2

Hi, Christopher,

The current logic is: if the parameter contains quote, then put a
quote around the parameter (winf.cc:78). However, if the quote is in
the beginning/end, cygwin will still quote it, and thus double quoted
parameter (such as ""a=b"").

In the previous example, I want to pass equal sign into a bat file, I
know Windows bat will not see equal sign unless it is surrender by
quote, so I have to quote it (that's not true now with auto quote for
equal sign you just checked in). Then winf.cc:78 will detect the
quote, and put another quote around, so what Windows bat see is a
double quoted parameter. And surprisingly in this case, bat file does
not treat ""a=b"" as a single parameter, %1 becomes ""a, %2 becomes
b"". Anyway, my point for #2 is, if the parameter is quoted, it
usually means user want the executable see the parameter inside the
quote, it should be treated differently than quote in the middle of
the parameter, we shall not add another quote around it in this
scenario.

And thanks for checkin #1.

Thanks,
Daniel
