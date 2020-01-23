Return-Path: <cygwin-patches-return-9986-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16119 invoked by alias); 23 Jan 2020 13:40:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16109 invoked by uid 89); 23 Jan 2020 13:40:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=apologize
X-HELO: mail-lf1-f66.google.com
Received: from mail-lf1-f66.google.com (HELO mail-lf1-f66.google.com) (209.85.167.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 13:40:05 +0000
Received: by mail-lf1-f66.google.com with SMTP id z18so2329265lfe.2        for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 05:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;        bh=Dbv26DR4Eu/UnvLv3Bwyn/KpLKRKhSOdA4qPoxnLm2c=;        b=olqdVAHgtMTQDyOSNT6xMiVzG97ez/4/0/cBmukZ0bVT3Bzn4IPO9dNrpyL/Yxwyja         OL28nRVw+DUE59VSeh+lYGzUKBFquyeqpaX7l0r/evRVUbUpZ1rG5pLdpBXP08L3IRXo         gBKeA304hho8mfixgvo0lOze5d1Ioca0KqzoWGFVvOQHr4LJjb3CndG7qtqPA4p6wxkA         gN6DaEdKdNWaiua1J0FUedvygXenTRjDSxI0/CTxWnxmPyLPN9OUo0NvcRwM4vWQ2qeH         QNUSmvhGieZLeJwZGUhh9TYZzfHmaVUOpg22geMgJvizu+8z68cjxtXM18nUDLQHWWBT         FOSg==
MIME-Version: 1.0
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp> <20200123043007.1364-1-takashi.yano@nifty.ne.jp> <20200123125154.GD263143@calimero.vinschen.de>
In-Reply-To: <20200123125154.GD263143@calimero.vinschen.de>
From: Koichi Murase <myoga.murase@gmail.com>
Date: Thu, 23 Jan 2020 13:40:00 -0000
Message-ID: <CAFLRLk_XGNXX+ot4+CTRsQ_mPRhJgcK9MKEzv3MtGvQR550fcA@mail.gmail.com>
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00092.txt

> On Jan 23 13:30, Takashi Yano wrote:
> > - After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
> >   cygwin programs which call both printf() and WriteConsole() are
> >   frequently distorted. This patch reverts waiting function to dumb
> >   Sleep().

    Hi, I have a question related to this patch. (When I have a
question on a specific patch like this, which mailing list should I
come?  If I should not make a reply to the original cygwin-patch
mailing list, let me apologize in advance.  If so, I'll move to
cygwin mailing list.)

    When I try to use the recent commit 6d79e0a58 (tag: newlib-3.3.0),
any Cygwin program fails to start leaving the following message:

      0 [main] XXXX (YYYY) shared_info::initialize: size of shared
      memory region changed from 50104 to 49080

where XXXX and YYYY are the program name and PID.  I also tried with
the current master branch 8f502bd33, and the result was the same.  I
tested each commit one by one, and found that this problem is caused
after this patch:

  6cc299f0e - (2 days ago) Cygwin: pty: Revise code waiting for
  forwarding by master_fwd_thread. - Takashi Yano

In fact, if I drop this commit from the master branch, the problem
disappears.


    But, as there are no related reports here, I suspect this is the
problem specific to my environment.  In particular, I suspect that
this is caused by the compatibility of different versions of
`cygwin1.dll'.  Currently, when I try to use the new `cygwin1.dll', I
just replace `C:\cygwin64\bin\cygwin1.dll' with the version I built
from recent a commit (`new-cygwin1.dll') following the instruction for
snapshots which is found at

  https://cygwin.com/faq.html#faq.setup.snapshots

Here my question is, if this is caused by the way I try the new
version, what is the correct way to try the latest version built from
a commit in the git repository (do I need to rebuild all the
toolchain)?  Or, is this problem caused by other conditions?  I would
appreciate it if you could provide me some hints.


    Here is some trials in command prompt:

  C:\cygwin64\bin>bash
        0 [main] bash (18936) shared_info::initialize: size of shared
  memory region changed from 50104 to 49080

  C:\cygwin64\bin>dash
        0 [main] dash (7900) shared_info::initialize: size of shared
  memory region changed from 50104 to 49080

  C:\cygwin64\bin>stty
        0 [main] stty (2920) shared_info::initialize: size of shared
  memory region changed from 50104 to 49080

  C:\cygwin64\bin>cat
        0 [main] cat (21340) shared_info::initialize: size of shared
  memory region changed from 50104 to 49080

  C:\cygwin64\bin>mintty

mintty fails without any messages.


Thank you,

Koichi
