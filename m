Return-Path: <cygwin-patches-return-8540-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100933 invoked by alias); 1 Apr 2016 16:26:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100914 invoked by uid 89); 1 Apr 2016 16:26:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:203, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-ob0-f181.google.com
Received: from mail-ob0-f181.google.com (HELO mail-ob0-f181.google.com) (209.85.214.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 01 Apr 2016 16:26:28 +0000
Received: by mail-ob0-f181.google.com with SMTP id fp4so50465809obb.2        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2016 09:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=PkkCV5en5eEy1rr0O/B0KNzjWRhjP6u5YWS8J36VUow=;        b=R5gOqMtwH3Ip6Jo7flq4bzKwlnYHhg5U0Mv4WAhUpR4yxQ1BKwAJSYSt2d/6s3KI3h         fJnLWJ4uQzf8dp3+Lachxq3JbXG/2Su8a0968/yDFzLC/AVbz6sduhQazX2tm/IkJIgC         fInTv5OAWR99rxsWVuVw/IfQjmAyWccbELAmMgpM6T/gBaynRXlM+4XkLAHV9rEhntpk         ilG/1LfziW/9oevVK+BWjQRl3ub2hlC4QHCp7LDr00UfT3DvEAxMcwBGO82KihQETBnb         hge0yIq9gUL3lKYUBb5w0fqHDaKWLwihbQNK0D+zJ622U7dkVP/8gifLWHKn/W8CSnrb         Cucw==
X-Gm-Message-State: AD7BkJL0f80nyYqbqVjfw5HrzcC0ncLdYWx11VzRdtKBG4bIOkFAMP6HfqE6jihU8u3NsWIAu34qZ4VIo38Riw==
X-Received: by 10.182.47.165 with SMTP id e5mr3747578obn.69.1459527986866; Fri, 01 Apr 2016 09:26:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Fri, 1 Apr 2016 09:26:07 -0700 (PDT)
In-Reply-To: <20160401162431.GD23707@calimero.vinschen.de>
References: <1459525365-21482-1-git-send-email-pefoley2@pefoley.com> <20160401162431.GD23707@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Fri, 01 Apr 2016 16:26:00 -0000
Message-ID: <CAOFdcFNiKsD2heJVd8yQVhDcorKEf83VSnneJZ7VMN7cSxDs0g@mail.gmail.com>
Subject: Re: [RFC PATCH v3] Refactor to avoid nonnull checks on "this" pointer.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00015.txt.bz2

On Fri, Apr 1, 2016 at 12:24 PM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> Other than that, please go ahead.

Will do.
