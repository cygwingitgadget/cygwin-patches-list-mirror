Return-Path: <cygwin-patches-return-7569-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27986 invoked by alias); 19 Dec 2011 20:18:07 -0000
Received: (qmail 27963 invoked by uid 22791); 19 Dec 2011 20:18:04 -0000
X-SWARE-Spam-Status: No, hits=1.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f45.google.com (HELO mail-ww0-f45.google.com) (74.125.82.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 19 Dec 2011 20:17:52 +0000
Received: by wgbds13 with SMTP id ds13so9236954wgb.2        for <cygwin-patches@cygwin.com>; Mon, 19 Dec 2011 12:17:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.216.133.106 with SMTP id p84mr7685750wei.5.1324325870079; Mon, 19 Dec 2011 12:17:50 -0800 (PST)
Received: by 10.227.165.4 with HTTP; Mon, 19 Dec 2011 12:17:50 -0800 (PST)
In-Reply-To: <4EEF914C.9090707@dancol.org>
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com>	<20111205101715.GA13067@calimero.vinschen.de>	<CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com>	<CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com>	<20111219155948.GA7148@calimero.vinschen.de>	<CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com>	<4EEF914C.9090707@dancol.org>
Date: Mon, 19 Dec 2011 20:18:00 -0000
Message-ID: <CAL-4N9sK1Nqz0xTOgRWhyaB0a3dozmA5PQMtdbiUpJM-1=EmzA@mail.gmail.com>
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
X-SW-Source: 2011-q4/txt/msg00059.txt.bz2

> That's only true until the mount table changes.

Can you elaborate on that? If I create a symlink pointing to /mnt/foo
(and store the actual POSIX path /mnt/foo in the symlink), and the
mount table changes, what's the problem?
