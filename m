Return-Path: <cygwin-patches-return-8397-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 69779 invoked by alias); 14 Mar 2016 22:04:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69766 invoked by uid 89); 14 Mar 2016 22:04:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mail-ob0-f170.google.com
Received: from mail-ob0-f170.google.com (HELO mail-ob0-f170.google.com) (209.85.214.170) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 14 Mar 2016 22:03:51 +0000
Received: by mail-ob0-f170.google.com with SMTP id fp4so191194111obb.2        for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2016 15:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to:cc;        bh=XC5HvZ6t1x3oPMdj1ckZILEDRhjoW1CXAMSw11LLGJ0=;        b=NYCqU0UExKNUwiFXyj1odXYi22wm9KJGg74Xv+G4SaS84E8S48FNFSrKn0DmpMehHa         kyulN94hOyibqTROmzcTpERwsm/P76+4jSqC67TMAiL6T8CtfQf5mDVsQnJ/Y6cUDWn0         tZtv1G2jPg5Q6c4MU6+GpZKnf6s+oDgLiBAYFhwMkMYW5sKyM5Mvb5o7m7vG+wKcYZce         9bZ8NdGKBcOaIG1LoqJ0N/rjGHQYh1YZ4KSa0lX/TsgLVsrgWx5Uzc1g2K9J+m6yB9Td         a2o939PoP/0BzRXZ72vcHNHRTPDhd6tqV1JOEL/k97f996lvjoZIRsFwF3g8zBZ25hSv         djZg==
X-Gm-Message-State: AD7BkJJDvj3AAsBsP+QwNHkJ5HY82gJHruaXqw6DIcawSZhWXJuRAiIfzk6fS5joOpUmnwFLUHtuNZDzyas4/w==
X-Received: by 10.182.47.165 with SMTP id e5mr16593102obn.69.1457993029531; Mon, 14 Mar 2016 15:03:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 14 Mar 2016 15:03:29 -0700 (PDT)
In-Reply-To: <1457972589-7179-1-git-send-email-pefoley2@pefoley.com>
References: <1457972589-7179-1-git-send-email-pefoley2@pefoley.com>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 14 Mar 2016 22:04:00 -0000
Message-ID: <CAOFdcFMRUkXBfzf8fTZkEr_TZ=WWDfSchjZ4fzDrEHMgif9xBw@mail.gmail.com>
Subject: Re: [PATCH] Regenerate newlib/configure
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00103.txt.bz2

On Mon, Mar 14, 2016 at 12:23 PM, Peter Foley <pefoley2@pefoley.com> wrote:
> Fix undefined libtool macros _LT_DECL_SED and _LT_PROG_ECHO_BACKSLASH
>
> newlib/ChangeLog
> * configure: Regenerate.
>
> ---
>  newlib/configure | 9339 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 9306 insertions(+), 33 deletions(-)


Whoops,

Just realized that this should have been sent to the newlib list.
I'll re-submit this there.

Thanks,

Peter Foley
