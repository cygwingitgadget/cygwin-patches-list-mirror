Return-Path: <cygwin-patches-return-8478-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 101397 invoked by alias); 21 Mar 2016 20:35:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101381 invoked by uid 89); 21 Mar 2016 20:35:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f193.google.com
Received: from mail-ob0-f193.google.com (HELO mail-ob0-f193.google.com) (209.85.214.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 20:35:23 +0000
Received: by mail-ob0-f193.google.com with SMTP id e7so15811651obv.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 13:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=47unqszqwHlRZpGyye1wBh9H6maEqw6cL0pCmQAMXzQ=;        b=PxQljyGlbZwF20SEw0X8Nrc7KnWyr6CE14iyEQboVyz8nWZyhKxDHCpxvKXrcbxCEG         0xGZr+qqfQsSY4UF+8pZLrPMGMvv3lMe/cu9my5GlaPGHUFfW1XUCSEFEfxrj3e+xJ/b         7KqkVOyildLGanD9sBz8VoBG1kGtOnJf84gkkoYjeXPUkGHb7OK0uM0vQ9KjFH3By/o1         LrY+SzHKcEPi2wH8Z/K23jMZNkEa4sFJFCJmhCiQ4M5qxiiAYtvf06VnnvVg0lyt0zjk         6f67ZJocbiaZE2P9Mm/6vIhzbKEA1kZ2Uwj0LPQNzVoTJpjQXBarmQpUHkkyq40JxDAD         G4NA==
X-Gm-Message-State: AD7BkJIyxjSioPfcQE5DWdAjHI7VDj12i2qltdrI9L1hsywVf8b0wSGblSh3Gq9LGHaLhuMRWKcXeIanNW9uiQ==
X-Received: by 10.60.178.202 with SMTP id da10mr18242108oec.11.1458592521555; Mon, 21 Mar 2016 13:35:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 13:35:01 -0700 (PDT)
In-Reply-To: <20160321203235.GM14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com> <20160321194758.GH14892@calimero.vinschen.de> <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com> <20160321203235.GM14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 20:35:00 -0000
Message-ID: <CAOFdcFMxqgni3-Xx_ajL2-8EpzWkzgaXh=6Dd5iHgGLnneJWVQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] Add with-only-headers
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00184.txt.bz2

On Mon, Mar 21, 2016 at 4:32 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Still hmm at this point.  AFAICS we only need the handful of definitions
> for new and delete operators, nothing else.  Is there perhaps a way to
> define this stuff by ourselves to avoid any requirement for libstdc++
> headers for building the DLL?  Or is that just not feasible?

Dunno, I'll look into this a bit more.

Thanks,

Peter
