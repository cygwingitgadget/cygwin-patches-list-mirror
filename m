Return-Path: <cygwin-patches-return-9990-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75117 invoked by alias); 23 Jan 2020 14:30:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75099 invoked by uid 89); 23 Jan 2020 14:30:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=remained, screen, Manager, you!
X-HELO: mail-lf1-f47.google.com
Received: from mail-lf1-f47.google.com (HELO mail-lf1-f47.google.com) (209.85.167.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 14:30:37 +0000
Received: by mail-lf1-f47.google.com with SMTP id b15so2451193lfc.4        for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=mime-version:references:in-reply-to:from:date:message-id:subject:to         :content-transfer-encoding;        bh=dO91y7UvRjf9cNKShl7+oNer53CNcene3jkx6/NOs/k=;        b=EmvRaV5cUJ8qQMp5V+m/bvYLtZKytUuDAAdSqKOFaaZ+qOz/WYB8PBPBGTgtdHZDpv         zE1/QrmI9BP2+KBoXkLTrrKWF1R6TGubkUXDY9toK6HrezUtN5lOVp3ycr0mSxj1oNlS         qfoR1NwU8TWJJInrxD/aqLFYKhwD8donU32XV7FVIuYDJo8MOBuix66K6QVYJrFjnpgp         fli/ClYCRlCPitHh6qRWMVEi0WZB1ZDtW3W1gFYfg7EOiljrqKiD+6qwlZkaqQLJP621         QI9F0klBLVrX6eUIxSssilc53P3HTz3xcFNmdeineIf48FZwQQ3DmfJs45IUAIMveh6Q         yZnw==
MIME-Version: 1.0
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp> <20200123043007.1364-1-takashi.yano@nifty.ne.jp> <20200123125154.GD263143@calimero.vinschen.de> <CAFLRLk_XGNXX+ot4+CTRsQ_mPRhJgcK9MKEzv3MtGvQR550fcA@mail.gmail.com> <20200123230027.4d1bb55023f7b75c3655fced@nifty.ne.jp>
In-Reply-To: <20200123230027.4d1bb55023f7b75c3655fced@nifty.ne.jp>
From: Koichi Murase <myoga.murase@gmail.com>
Date: Thu, 23 Jan 2020 14:30:00 -0000
Message-ID: <CAFLRLk9KBeoGfyLaiur+VC15oiwiA-n4gM9XVEsP2MUe4eNVnw@mail.gmail.com>
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00096.txt

2020=E5=B9=B41=E6=9C=8823=E6=97=A5(=E6=9C=A8) 22:00 Takashi Yano <takashi.y=
ano@nifty.ne.jp>:
> Is there any process alived using diffrent version of cygwin1.dll?

Ah, you were right!  Actually there were no *real* processes remained
(Otherwise I could not have overwritten cygwin1.dll, I think), but I
remembered that there is a remaining *fake entry* in the result of
`ps' as follows (for which `kill' produces error `No such process' and
also I cannot find any corresponding process in Windows Task Manager).

  $ ps uaxf
      PID    PPID    PGID     WINPID   TTY         UID    STIME COMMAND

     1416       1    1416      11160  ?         197610   Jan 20
  /home/murase/opt/screen/4.7.0m/bin/screen-4.7.0

After a reboot of Windows, the problem has resolved!  Thank you!

Koichi
