Return-Path: <cygwin-patches-return-8675-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10946 invoked by alias); 10 Jan 2017 15:02:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10935 invoked by uid 89); 10 Jan 2017 15:02:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_20,FREEMAIL_FROM,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=no version=3.3.2 spammy=profits, BUSINESS, DIRECT, incidental
X-HELO: mail-wj0-f176.google.com
Received: from mail-wj0-f176.google.com (HELO mail-wj0-f176.google.com) (209.85.210.176) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 10 Jan 2017 15:02:22 +0000
Received: by mail-wj0-f176.google.com with SMTP id tn15so84369550wjb.1        for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2017 07:02:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:cc:subject:date:message-id;        bh=UZvFnmQAF/ztwran6SJ7faIYM+oBa3qxdH53yv8X7q8=;        b=FSJbrm6mDbPicU1XZ+BC0NKXOPCQiFFnFHfWzGqg/3j+CMzh8ZWzYKdxP+A3fIsDpH         OK7kdP5bqYsFpTXlj0jczvbu6DwdLsZ3d0ysXmUYyYOcyk7gqm6d3KkLZBvdKItebcXE         T/uwJbhoDc68Rx0fyEIXK8tIP3N4ln7rhdCUUlrW3nxJ7PH46HKvcjIQWTkRSYhMJYTq         8pGFPxta/ikgK2k6Q40p478m0zBw3hONpqhv7fa4OmFNPQU9f82il16vKDyDdmdyFZ11         uFrMrwKszVXwqEn507kCTDAA3BrfUNxLdYX9/wFqz/moH9by6zGjjgpGbbLGmWHtD2iC         vMbA==
X-Gm-Message-State: AIkVDXIEUpZ5UrzTvs+rO9ksr446eczhF248kaHfr36TS5b4kJ/vumfGtB47+aXGNN+q5A==
X-Received: by 10.194.77.129 with SMTP id s1mr2081270wjw.82.1484060540559;        Tue, 10 Jan 2017 07:02:20 -0800 (PST)
Received: from localhost.localdomain (lri30-45.lri.fr. [129.175.30.45])        by smtp.gmail.com with ESMTPSA id c81sm4166722wmf.22.2017.01.10.07.02.19        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Tue, 10 Jan 2017 07:02:19 -0800 (PST)
From: Erik Bray <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Cc: "Erik M. Bray" <erik.bray@lri.fr>
Subject: [PATCH 0/3] Updated patches for /proc/<pid>/environ
Date: Tue, 10 Jan 2017 15:02:00 -0000
Message-Id: <20170110150209.87028-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00016.txt.bz2

From: "Erik M. Bray" <erik.bray@lri.fr>

Updated versions of the patch set originally submitted at
https://cygwin.com/ml/cygwin-patches/2017-q1/msg00000.html

I think all the indentation/whitespace/braces are cleaned up and consistent.

I've also made sure that /proc/self/environ works now.

All new code in these patches is licensed under the 2-clause BSD:

==============================================================================
Copyright (c) 2017, Erik M. Bray
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

===============================================================================

Erik M. Bray (3):
  Move the core environment parsing of environ_init into a new
    win32env_to_cygenv function.
  Add a _pinfo.environ() method analogous to _pinfo.cmdline(), and
    others.
  Add a /proc/<pid>/environ proc file handler, analogous to
    /proc/<pid>/cmdline.

 winsup/cygwin/environ.cc          | 84 +++++++++++++++++++++++----------------
 winsup/cygwin/environ.h           |  2 +
 winsup/cygwin/fhandler_process.cc | 22 ++++++++++
 winsup/cygwin/pinfo.cc            | 83 +++++++++++++++++++++++++++++++++++++-
 winsup/cygwin/pinfo.h             |  4 +-
 5 files changed, 157 insertions(+), 38 deletions(-)

-- 
2.8.3
