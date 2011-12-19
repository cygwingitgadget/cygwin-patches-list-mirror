Return-Path: <cygwin-patches-return-7567-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13886 invoked by alias); 19 Dec 2011 19:31:48 -0000
Received: (qmail 13870 invoked by uid 22791); 19 Dec 2011 19:31:47 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM
X-Spam-Check-By: sourceware.org
Received: from mail-wi0-f171.google.com (HELO mail-wi0-f171.google.com) (209.85.212.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 19 Dec 2011 19:31:30 +0000
Received: by wico1 with SMTP id o1so1108940wic.2        for <cygwin-patches@cygwin.com>; Mon, 19 Dec 2011 11:31:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.180.77.42 with SMTP id p10mr1574801wiw.5.1324323089427; Mon, 19 Dec 2011 11:31:29 -0800 (PST)
Received: by 10.227.165.4 with HTTP; Mon, 19 Dec 2011 11:31:29 -0800 (PST)
In-Reply-To: <20111219155948.GA7148@calimero.vinschen.de>
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>	<20111205101715.GA13067@calimero.vinschen.de>	<CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com>	<CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com>	<20111219155948.GA7148@calimero.vinschen.de>
Date: Mon, 19 Dec 2011 19:31:00 -0000
Message-ID: <CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com>
Subject: Re: Add support for creating native windows symlinks
From: Russell Davis <russell.davis@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2011-q4/txt/msg00057.txt.bz2

> I don't think it's the right approach to let Cygwin create symlinks
> which are only partially usable in the POSIX environment...

Huh? I think you're not fully understanding my suggested approach. As
I pointed out in my previous message, it should be 100%, fully usable
in the POSIX environment. Again: any path that might be problematic as
a Win32 path can just be stored as a POSIX path, and would fall into
the bucket of "works inside cygwin but not outside".
