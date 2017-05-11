Return-Path: <cygwin-patches-return-8766-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102422 invoked by alias); 11 May 2017 14:05:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102386 invoked by uid 89); 11 May 2017 14:05:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=transmitted, bray, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f44.google.com
Received: from mail-wm0-f44.google.com (HELO mail-wm0-f44.google.com) (74.125.82.44) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 11 May 2017 14:05:55 +0000
Received: by mail-wm0-f44.google.com with SMTP id u65so3270503wmu.1        for <cygwin-patches@cygwin.com>; Thu, 11 May 2017 07:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id;        bh=VJCi+Z64mc1nP+ureaE6w/UMYcWYjLlMa/Y6K8CLOnY=;        b=iUUcvTTMhVVZVRfLazuFWLo0vpMG+Fak45G+TRIdMLbtOtejxDyHz3wqJIKTfYlXkp         BbpWd6dUbCncE3Wkae0VktGnS+trP3KI0V1LB+rTMDqF3MFlrNmzwn94QM8CgETOzbf0         FroUlk/VnmKgH3KpslPE2oW2zaKvxEf/H67IgFKGUSbtUXSoKBOPjpJmG0xTVM3dwUNr         nbyWRUIltC7U2k0Dq/+PBy6+k8LDqVFMvPTVgPd+tq1bGbFRgUfwRdVH8+TZ0y0GkdYQ         aeOQWL4LpEW8eeKUu7FDNIW6cRIucQ5abtrh5UEkBJiaV0Nu+nOg+nO0oMrFMulzsDTD         TlWQ==
X-Gm-Message-State: AODbwcCMo3IcY70v5z/jQ7VY8ubi0lMkcm9/Dgt3/kRNXA+L7hyp+tuK	h491ZD5sxTyFS2eVSq4=
X-Received: by 10.28.62.81 with SMTP id l78mr4869701wma.105.1494511556194;        Thu, 11 May 2017 07:05:56 -0700 (PDT)
Received: from localhost.localdomain (vbo91-1-82-238-216-179.fbx.proxad.net. [82.238.216.179])        by smtp.gmail.com with ESMTPSA id k18sm305636wre.9.2017.05.11.07.05.54        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 11 May 2017 07:05:55 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix bug with blocking send interrupted by a signal
Date: Thu, 11 May 2017 14:05:00 -0000
Message-Id: <20170511140534.26860-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00037.txt.bz2

The following patch fixes an issue I found via the Python test suite--when a
large send() on a socket has to be chunked, if part of the data has already
been transmitted, a signal will not cause the send() to be interrupted even
if SA_RESTART is not set.

For the sake of consistency with Linux's behavior (which recv() already has)
send() should return successfully in this case.  On the other hand, if
SA_RESTART is set, send() will continue to block with this patch.  The only
issue here was that while fhandler_socket::wait_for_events can set a socket
error (particularly WSAEINTR) when an interrupted has been handled, that error
was not being checked.

Erik M. Bray (1):
  Ensure that a blocking send() on a socket returns (with success) if a
    signal is handled mid-transition and SA_RESTART is not set.

 winsup/cygwin/fhandler_socket.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.8.3
