Return-Path: <cygwin-patches-return-8532-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51902 invoked by alias); 1 Apr 2016 13:31:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51877 invoked by uid 89); 1 Apr 2016 13:31:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f181.google.com
Received: from mail-ob0-f181.google.com (HELO mail-ob0-f181.google.com) (209.85.214.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 01 Apr 2016 13:31:36 +0000
Received: by mail-ob0-f181.google.com with SMTP id x3so121667213obt.0        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2016 06:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=7ojixXHfm4UiOPzITUvUJZlWJoOsoD0xI/vUjdWoDNs=;        b=NH+ToTCCrKy+SjC9q0YgZ64RTtlJZ3ma1o0kVWwvZS86XTW78s8qtdCk2NdbcHDNUe         /Bvj4kUw7SPb3T3U9kio3UgFTRtX8+lrU46oRX7l4g0/7b8FbsQM73wiQaEFKEkElHv4         m9NPq15B9pry7mQRn25UIaA5FbumsUVwixW9vQHyja3ksYFMkm2M1xcVj15ii1qQfgoS         urOyLBBUsCTsi9StTkwXt1x8W3HXppMPn5hxcMj9r3RveF/qA2RO3bDW+zYcKQqX7vxJ         v/FaxKq4iWECXbfm8AStWheMdIQnd2KF3q+bJOihqJvp2ZowK2vc6O6vDsU23dGdx6xb         43oA==
X-Gm-Message-State: AD7BkJJtm9c+e9evXyuyDja9wFLhV15DqQUGXisGOSlppicrVPSR4VTZCAx/k0/p4X7az5hfEQPUl7kJwnsQDg==
X-Received: by 10.60.141.227 with SMTP id rr3mr4980447oeb.57.1459517494446; Fri, 01 Apr 2016 06:31:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Fri, 1 Apr 2016 06:31:14 -0700 (PDT)
In-Reply-To: <20160401121601.GB16660@calimero.vinschen.de>
References: <1459442026-4544-1-git-send-email-pefoley2@pefoley.com> <20160401121601.GB16660@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Fri, 01 Apr 2016 13:31:00 -0000
Message-ID: <CAOFdcFO8cMnFLcYb=_++65JW0xu+YYAzC98bJ83McfsFFMY_RA@mail.gmail.com>
Subject: Re: [PATCH] Add without-library-checks
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00007.txt.bz2

On Fri, Apr 1, 2016 at 8:16 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Can we please fold the --without-mingw-progs and --without-library-checks
> into a single option?  Given the task is basically the same, the option
> name should reflect something along the lines of "cross-build",
> "bootstrap", and "stage 1", IMO.

Sure,
Maybe --with-cross-bootstrap?
I'll respin this when I get a chance.
