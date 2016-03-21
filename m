Return-Path: <cygwin-patches-return-8442-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82324 invoked by alias); 21 Mar 2016 01:44:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82307 invoked by uid 89); 21 Mar 2016 01:44:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f68.google.com
Received: from mail-oi0-f68.google.com (HELO mail-oi0-f68.google.com) (209.85.218.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 01:44:33 +0000
Received: by mail-oi0-f68.google.com with SMTP id e22so7198190oib.0        for <cygwin-patches@cygwin.com>; Sun, 20 Mar 2016 18:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=ZgOooglcqHyPum1YKpEmxsemer1sxC4xrrKT1p7Bek4=;        b=Vs/CtvMRY+BF3PFhFs3nzO9nJTMMeyLwfx/9S3Z7x2K3J2DgIzIzhcPzFIGniKvG2j         rjyXBN3Jf4UZoMYFdQRV1sW0Zup1q27AqIMuNWyJsCZu7zNlgMvQq+1NgnWTuuc3snsv         VMCmNPC29WCw2dKAVci2X6RpCroVrA22G85Gn3XYaxjgNmA6CYp1Sho1qG4qLm4l1Lyt         O5AJVRwJgh5zeEjHg55QGYHA+jx4L5OQXoaioktTlhaHWKAqNbwhnpqBoc1T6pZIzs93         e8xM02hjFCRgksqH3oHGb8sWMtRy7Ydly4O3cgHCi5XyhevUNiHUhSTtFsE79Uscezw0         2uwA==
X-Gm-Message-State: AD7BkJISzxdZ6pamSmHcooaE+7S3jZ7rW7iVgarVoQ0mPxZYnES74olw9E0FZ7zWHRdB4OJ60SrXeKZbTRTsig==
X-Received: by 10.202.88.130 with SMTP id m124mr15534851oib.52.1458524671219; Sun, 20 Mar 2016 18:44:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Sun, 20 Mar 2016 18:44:11 -0700 (PDT)
In-Reply-To: <20160320095559.GB25241@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <20160320095559.GB25241@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 01:44:00 -0000
Message-ID: <CAOFdcFPuVS7B342TFmo0zDFpxrr2YJhZeQ6VbQny2UAY+SpVXw@mail.gmail.com>
Subject: Re: [PATCH 01/11] Remove unused and unsafe call to __builtin_frame_address
To: cygwin-patches@cygwin.com, Peter Foley <pefoley2@pefoley.com>
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00148.txt.bz2

On Sun, Mar 20, 2016 at 5:55 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> There's an assign.txt document you (and potentiall your employer) can
> sign and send as PDF.  It's usually rather painless.
>
>
> Thanks,
> Corinna

Copyright assignment form signed and emailed.

Thanks,

Peter Foley
