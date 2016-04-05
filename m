Return-Path: <cygwin-patches-return-8554-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105275 invoked by alias); 5 Apr 2016 14:02:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105178 invoked by uid 89); 5 Apr 2016 14:02:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f68.google.com
Received: from mail-oi0-f68.google.com (HELO mail-oi0-f68.google.com) (209.85.218.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Tue, 05 Apr 2016 14:02:34 +0000
Received: by mail-oi0-f68.google.com with SMTP id q133so2040591oib.1        for <cygwin-patches@cygwin.com>; Tue, 05 Apr 2016 07:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=5gQI/bDvH9AT9vIRUgvoIvNziny55FaRUyhkUp5bwqY=;        b=WvyZIPxPh7feAbmyaVbqLKAGAqmtsq9r8i9uiR8zJs1iOGCJ1zFEYNiQD7Rr6wpraB         CwWpwcRcCory03SkCw4ctYR8xC+szXHPCpNm/0KhvN8z8VVhPM43E9/+owD0ShvCktGj         IJ8VfGf7RzB3Q53EOk7wwxNwOWljSr2v4ajd4ki0SsLYmMIumyRkFtaDFj58xRbCrJJk         1769+uS1rwxXmogAjGVdX3zutkuwc/8Pc5OjF1YOA1FJXINGkpinbbvcSnT3BIIdPHZU         9LkLlyElK27Q9IfmR660XEx9X8jZTNkfGqB/GYXV0btRnPa0Wg8+92elgoJEaGqqEaEa         eM9Q==
X-Gm-Message-State: AD7BkJKb9m1iI+wFfgBFGEd4WkbUiLQYIkCLH2/ZmBW43s8oAP4LYMD7yOzn6xYCaMlGEbRmvuBgoUx37eRo7A==
X-Received: by 10.157.14.183 with SMTP id 52mr7172055otj.83.1459864952048; Tue, 05 Apr 2016 07:02:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.42.108 with HTTP; Tue, 5 Apr 2016 07:02:12 -0700 (PDT)
In-Reply-To: <20160405083220.GA31359@calimero.vinschen.de>
References: <1459611378-25476-1-git-send-email-pefoley2@pefoley.com> <20160404145242.GC13238@calimero.vinschen.de> <20160405083220.GA31359@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Tue, 05 Apr 2016 14:02:00 -0000
Message-ID: <CAOFdcFONAnpNK=+ShwavZ-idVCm2rpFzOaajEPFA-T8WViBJag@mail.gmail.com>
Subject: Re: [PATCH v3] Refactor to avoid nonnull checks on "this" pointer.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00029.txt.bz2

On Tue, Apr 5, 2016 at 4:32 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> And reverted.  This patch is the culprit for the problem reported in
> https://cygwin.com/ml/cygwin/2016-04/msg00085.html
>
> Can you please take another look, Peter?

Huh, that's odd...
I'll take a look when I have some free time.

Thanks,

Peter
