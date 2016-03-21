Return-Path: <cygwin-patches-return-8470-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61313 invoked by alias); 21 Mar 2016 19:59:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61303 invoked by uid 89); 21 Mar 2016 19:59:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=sk:configu, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f193.google.com
Received: from mail-ob0-f193.google.com (HELO mail-ob0-f193.google.com) (209.85.214.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 19:59:47 +0000
Received: by mail-ob0-f193.google.com with SMTP id e7so15736568obv.2        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 12:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=IRkoag1HRlYTuS+s73HcPmqql7V6YQBEO8ls7e4klq0=;        b=Q66CwMzAPJno/wNfjp8vXzR0E8pkKSoQiQhznx3eY7hXKpYJRa0trkmWzX5rF0zFxh         rM+w27M7HEzLNGavUpREyfx8zINqkpOR/We/GaQx2DBw5VAUzLMFGwer+FqZopSpmiwe         EH93mjoFyGuB7qaQAYg8zI/U2sMKoYTdrcmAUXw05GaQBBpRCnoUzFxQcQuipuf0omIX         6uE//z7CAb8tMSjEtVhUHZoaIZ4YxII4kwU4QmTAU4TK7RvHJEF9lV0q0N29v9MeX2lb         ffISNK/GypknRqevjr7psRJd/E7xQVJWXb5bVIkBmLvNcQaxGGE/UPt23gm/bMbqcCnN         Ca3w==
X-Gm-Message-State: AD7BkJLc+J9oRdFUbeQRzAEXIikhDPiknKY4kCBhcoLeYf5HcYEELW15DyNangVKAn4jOQT1v5ALCrG+fOkHzQ==
X-Received: by 10.60.178.202 with SMTP id da10mr18148419oec.11.1458590386049; Mon, 21 Mar 2016 12:59:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 12:59:26 -0700 (PDT)
In-Reply-To: <20160321194758.GH14892@calimero.vinschen.de>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com> <20160321194758.GH14892@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 19:59:00 -0000
Message-ID: <CAOFdcFMC60YLscHWDzsRz3q9cF1-KAc-d=CPhS5W_LeFRb83tg@mail.gmail.com>
Subject: Re: [PATCH 5/5] Add with-only-headers
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00176.txt.bz2

On Mon, Mar 21, 2016 at 3:47 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> On Mar 21 13:15, Peter Foley wrote:
>> When cross-compiling a toolchan targeting cygwin, building cygwin1.dll
>> requires libstdc++v3 to be built.
>
> Building cygwin1.dll doesn't require libstdc++-v3.  The Cygwin DLL is
> never linked against it and never will be.  Only building the utils dir
> requires libstdc++ and that would be fixed by not builing utils as in
> your other patch, wouldn't it?

Sorry for being unclear.
Building cygwin1.dll requires the *headers* from libstdc++-v3.
To run configure-target-libstdc++-v3 (which generates necessary headers
and is a prereq for install-target-libstdc++-v3 which installs those headers),
libgcc must be able to compile. For libgcc to compile, the cygwin headers
must be available.

To summarize, configure-target-libstdc++-v3 depends on all-target-libgcc.
And all-target-libgcc requires the headers from cygwin to be installed.

Hopefully that makes more sense.

Thanks,

Peter
