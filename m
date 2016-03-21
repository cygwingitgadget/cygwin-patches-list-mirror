Return-Path: <cygwin-patches-return-8448-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 106838 invoked by alias); 21 Mar 2016 16:44:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 106820 invoked by uid 89); 21 Mar 2016 16:44:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f45.google.com
Received: from mail-oi0-f45.google.com (HELO mail-oi0-f45.google.com) (209.85.218.45) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 16:43:55 +0000
Received: by mail-oi0-f45.google.com with SMTP id l76so55952401oig.1        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 09:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;        bh=6cvbO7M5JqaFAxtwH8rA7AP2ACzlFfPYOFzSqDnyWjA=;        b=aOyNhdegUsIiamKoL6b75zd+j8WZTFjxqwwk33/GZzhcSmqfaxJJa+hh09qflItxUv         4EyecmjFBBg8fqyYUhXlbkBfVDUg5Qf+8XSnmm+/4Wsy3LjMTACuKSv0SD2e+Z7WtOak         nPTr7e7q4gHGq+H+QORswm9y6maewoeBGTr1hcZtZsqqLKKOTZ6YU5lzjzTzGBPN5SuA         e+Eg3fAYzsUo+9jF322KFgev6NH1whOSTeL3FFsDEloPhzTAyNqC60usYcndSeAWlCB+         tpu1j81Fgr9qUIA2sAguTNrljYYf0NDUoVefonSxHt+VCbfSZflWRy+O1bZgL77gXR69         RCkA==
X-Gm-Message-State: AD7BkJKlcgR7thYHAwnfOW3+hVexQ+02wCwsrimwL0U27UDLPU7M+1etsOphxy86RH6JkuuJdxysgvz1Q/zGew==
X-Received: by 10.157.20.161 with SMTP id d30mr1402115ote.165.1458578633679; Mon, 21 Mar 2016 09:43:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.86.194 with HTTP; Mon, 21 Mar 2016 09:43:34 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
Date: Mon, 21 Mar 2016 16:44:00 -0000
Message-ID: <CAOFdcFNPgJrf3KcNaOvmoT+Aj3Gp46w=ob=okPT0vwJ4TvMTCg@mail.gmail.com>
Subject: Update toplevel files from gcc
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00154.txt.bz2

When building a cross compiler targeting cygwin, the target objcopy
binary wasn't properly picked up.
It appears that a fix for this has been commited to the gcc tree
https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=fc740d700395d97b6719e8a0e64f75d01ab0d8fd

A patch to copy the updated Makefile.def, Makefile.tpl and
configure.ac from gcc and regenerate Makefile.in and configure is
1.4M, so too large to send to the mailing list.

Would it be possible for someone to sync the latest toplevel files from gcc?

Thanks,

Peter Foley
