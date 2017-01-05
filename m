Return-Path: <cygwin-patches-return-8659-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73464 invoked by alias); 5 Jan 2017 17:39:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73421 invoked by uid 89); 5 Jan 2017 17:39:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=Erik, erik, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f53.google.com
Received: from mail-wm0-f53.google.com (HELO mail-wm0-f53.google.com) (74.125.82.53) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Jan 2017 17:39:40 +0000
Received: by mail-wm0-f53.google.com with SMTP id t79so493364177wmt.0        for <cygwin-patches@cygwin.com>; Thu, 05 Jan 2017 09:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id;        bh=sivqEga3/mjoh5ymSH3X6ykUPItfjFrFyLEVpL50WA8=;        b=ab8PmaObXnmTxdzJAA+CIAWbIBMCHvLYVEvnRugqNuwyaVe5MTViVQvO0p0j2k7Q1D         3PqruaXVa+p3vmn+pBcUT3rJQt4r+cLOeC9350KEhgbPYFzLCSu6MtdoyMGj0FlhqbkA         LOmWQOi9nAyoyIBbVAv/h+CIvekgQ1qN/HqKvP4P74n+Cv90Udhu2hXt7EpRcgp5/kkB         f/bvCeRA0eLehbQqUXpBrv9YlimOusBsPW7Q/b7SDm7u7d8QD0IkwjczrlGSZS59EYXY         S4ciaWRw+cSdiS+mv8aa9y/omVH8V2hxtUbIlXWryrn/UO0X4AmEPiE0AJY6H6rH24Zi         Efbg==
X-Gm-Message-State: AIkVDXJQ2cMW0KK9iCy6AvviHrnhISf/yjwx8vapjEbrj4nCwMsQGxxOwchfd3mkDeF/Sg==
X-Received: by 10.28.54.90 with SMTP id d87mr1330091wma.89.1483637977872;        Thu, 05 Jan 2017 09:39:37 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id t194sm84773wmd.1.2017.01.05.09.39.37        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 05 Jan 2017 09:39:37 -0800 (PST)
From: erik.m.bray@gmail.com
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/3] Add support for /proc/<pid>/environ
Date: Thu, 05 Jan 2017 17:39:00 -0000
Message-Id: <20170105173929.65728-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00000.txt.bz2

From: "Erik M. Bray" <erik.bray@lri.fr>

Per this discussion started in this thread: https://cygwin.com/ml/cygwin/2016-11/msg00205.html

I finally got around to finishing a patch for this feature. It supports both Cygwin and
native Windows processes, more or less following the example of how /proc/<pid>/cmdline is
implemented.

Erik M. Bray (3):
  Move the core environment parsing of environ_init into a new
    win32env_to_cygenv function.
  Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and
    others.
  Add a /proc/<pid>/environ proc file handler, analogous to
    /proc/<pid>/cmdline.

 winsup/cygwin/environ.cc          | 84 +++++++++++++++++++++---------------
 winsup/cygwin/environ.h           |  2 +
 winsup/cygwin/fhandler_process.cc | 22 ++++++++++
 winsup/cygwin/pinfo.cc            | 89 ++++++++++++++++++++++++++++++++++++++-
 winsup/cygwin/pinfo.h             |  4 +-
 5 files changed, 163 insertions(+), 38 deletions(-)

-- 
2.8.3
