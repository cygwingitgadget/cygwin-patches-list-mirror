Return-Path: <cygwin-patches-return-9987-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39500 invoked by alias); 23 Jan 2020 13:53:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39445 invoked by uid 89); 23 Jan 2020 13:53:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.5 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*f:CAFLRLk_XGNXX, myogamurasegmailcom, H*i:ot4, H*i:CAFLRLk_XGNXX
X-HELO: mail-lj1-f193.google.com
Received: from mail-lj1-f193.google.com (HELO mail-lj1-f193.google.com) (209.85.208.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 23 Jan 2020 13:53:02 +0000
Received: by mail-lj1-f193.google.com with SMTP id o13so3489788ljg.4        for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=mime-version:references:in-reply-to:from:date:message-id:subject:to         :content-transfer-encoding;        bh=CxjvxsuuUPtmjqscJ93rzKobQrSN69vdbf/gf+xz7qU=;        b=MpTl7qDAMA38t6aElNyDb+AORGm/OgkLvqSYZiFRFKSLHfVY6D1BnQKgobonFNQvIN         DD60K6rk/TJXrWYJoHREKPai6YRjP2JCh3D7B0fCb9zxMqDv6Tpa/QpA+pwpKorLnrwS         SSmyeet3CJvNqiIFqKLhfLfEaftad1Z4hxOmksmMryeBFrTyojmZFPJfGrzcp9dUBxiV         17E06WTDTy6VKTUu4z5wCgczfWyPA1VQDQXjB8inPInokRzqj+0ccm1kwDMveYsVHtWR         WzLmVM23SzWYhs31CI86/VHIgyKsUt/8+1s4G/tGNprfIvaiohkMAd88TpQ+wVYmTc9X         2mqw==
MIME-Version: 1.0
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp> <20200123043007.1364-1-takashi.yano@nifty.ne.jp> <20200123125154.GD263143@calimero.vinschen.de> <CAFLRLk_XGNXX+ot4+CTRsQ_mPRhJgcK9MKEzv3MtGvQR550fcA@mail.gmail.com>
In-Reply-To: <CAFLRLk_XGNXX+ot4+CTRsQ_mPRhJgcK9MKEzv3MtGvQR550fcA@mail.gmail.com>
From: Koichi Murase <myoga.murase@gmail.com>
Date: Thu, 23 Jan 2020 13:53:00 -0000
Message-ID: <CAFLRLk8UttWiS3y=X5St-ESLUp2pkazp=6_+mDygLn=fS0-7oA@mail.gmail.com>
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00093.txt

2020=E5=B9=B41=E6=9C=8823=E6=97=A5(=E6=9C=A8) 21:39 Koichi Murase <myoga.mu=
rase@gmail.com>:
> > On Jan 23 13:30, Takashi Yano wrote:
> > > - After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
> > >   cygwin programs which call both printf() and WriteConsole() are
> > >   frequently distorted. This patch reverts waiting function to dumb
> > >   Sleep().

I'm sorry, I made a reply to a wrong mail (with a similar subject).  I
should have made this reply to the original version of the patch.
Sorry for the confusion.

Koichi
