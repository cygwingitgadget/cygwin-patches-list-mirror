Return-Path: <cygwin-patches-return-8531-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50401 invoked by alias); 1 Apr 2016 13:30:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50356 invoked by uid 89); 1 Apr 2016 13:30:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=letter, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f182.google.com
Received: from mail-ob0-f182.google.com (HELO mail-ob0-f182.google.com) (209.85.214.182) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 01 Apr 2016 13:30:14 +0000
Received: by mail-ob0-f182.google.com with SMTP id j9so862362obd.3        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2016 06:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=I6hMRrEUq32Hyfj+M63YFfsJOkQZyNnrpIWKe+Y6D2Q=;        b=bci60Q1jEqo6mqiGpJYzR9PAp/ZmvP6g8OjT/mt30r33pHyo9dPJlHfWgFPrzMOKnH         PD9GlGLLHnH2zZQDQ4PesV59x4vGS62zM5Sg1IOBaH05+seiLKpVcbCAAMXgu/sINhS6         vJ+0iygwg1Z+nPxeaq+kzmf/X9vfqNR+J1fSA6D5mdNPpEDTWfngSvViKAd/4tGnsaKT         x7/+TeOUfJIqYsT8V/bGnNabg4JINpUnZ7wJwcDDY6riqBiuhFU1towyhQlsr2PpgUQe         nN2pd8rvwrS4yQY8gU+Vm+XshQSa6garemo0qDb0W/EC6DeKvv15ToDdS28u5ql2a37D         EEmg==
X-Gm-Message-State: AD7BkJLM93RW0TLUKd4FXMiol9rR8JHBPv3KuhUCSMhwNLqbT490ONmTl06iXDqIqwHePblU7ak+vsu1bJ7eTw==
X-Received: by 10.182.47.165 with SMTP id e5mr2855211obn.69.1459517412128; Fri, 01 Apr 2016 06:30:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Fri, 1 Apr 2016 06:29:52 -0700 (PDT)
In-Reply-To: <20160401122742.GE16660@calimero.vinschen.de>
References: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com> <20160401122742.GE16660@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Fri, 01 Apr 2016 13:30:00 -0000
Message-ID: <CAOFdcFM3r1uM8sgpb1Q20OvKKgd1=gySBb80v7OdupYTeOSkvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] Remove leftover cruft from config.h.in
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00006.txt.bz2

On Fri, Apr 1, 2016 at 8:27 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Btw., if it's not asked too much I'd be glad if a patch series like this
> comes with a cover letter (e.g. git format-patch --cover-letter).

Sure, will do in future.
