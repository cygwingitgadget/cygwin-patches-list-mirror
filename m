Return-Path: <cygwin-patches-return-8445-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35250 invoked by alias); 21 Mar 2016 15:52:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35237 invoked by uid 89); 21 Mar 2016 15:52:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f196.google.com
Received: from mail-ob0-f196.google.com (HELO mail-ob0-f196.google.com) (209.85.214.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 15:52:36 +0000
Received: by mail-ob0-f196.google.com with SMTP id cf7so15037621obc.3        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 08:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=g3QQ74Zf0U46IF6REKwLrJgd1EP2FwcTimQtlYFeF8Y=;        b=DBlIZfOa0IRisyxMxZUysmxdbk/C7JnyPQ90p0B3+KMIZxwiJk/n3sdlYo/VNvHrsF         zKO2H+w0HqoMz5r/z+ceew1lR+hvX7Tgk3MHScDbLXUvNbFJUMoxhXE9+Ktu877ewAk6         fvoxxcuEWob/XXxXQTpRqLUdyAlCT4yVnnU2ViaqAMCv5p2QG7e2ufw/uWiznE/+C4IM         4RUuZo0aCki8CxLsUekUWNZ3Ig7P84g5rWuL6TL2mpoil98lU5lFatzkoTxPQJSyseBy         3ERjxmjtH05Dk3q+Bwj56PylVaWh3zZZkVWT9+XZzI4k9Bys3jMoN6KTckbigZrB+gvO         Qi2g==
X-Gm-Message-State: AD7BkJLsFSRsPPwR9J7s+KIoOzVQvwnNIDcqzNL4NeGYlTborWPMUOozv3FuqT6O343gn210YfdCBGiHkTfpIQ==
X-Received: by 10.60.117.102 with SMTP id kd6mr17707193oeb.73.1458575554322; Mon, 21 Mar 2016 08:52:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 08:52:14 -0700 (PDT)
In-Reply-To: <20160321150514.GB7179@calimero.vinschen.de>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-5-git-send-email-pefoley2@pefoley.com> <20160320111558.GG25241@calimero.vinschen.de> <CAOFdcFPN1q8L6qmbORVogvxs5rsETjSs9_9_QnAfFm3YT++6Mw@mail.gmail.com> <20160321150514.GB7179@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 15:52:00 -0000
Message-ID: <CAOFdcFPxwdnyjbtAm5FVD6d4DhZB9Cm80kPzzNVaCPKfN9yX9Q@mail.gmail.com>
Subject: Re: [PATCH 05/11] A pointer to a pointer is nonnull.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00151.txt.bz2

On Mon, Mar 21, 2016 at 11:05 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Yes, but in glibc this is combined with a header disallowing a non-NULL
> argument.  This is missing in newlib yet.  I guess this would make the
> change acceptable.  Alternatively a __try/__except block in
> posix_memalign.

Ah, I'll look into improving the newlib header then.

Thanks,

Peter
