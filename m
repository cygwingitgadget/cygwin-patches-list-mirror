Return-Path: <cygwin-patches-return-7965-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13928 invoked by alias); 9 Feb 2014 00:26:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13914 invoked by uid 89); 9 Feb 2014 00:26:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-we0-f176.google.com
Received: from mail-we0-f176.google.com (HELO mail-we0-f176.google.com) (74.125.82.176) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Sun, 09 Feb 2014 00:25:59 +0000
Received: by mail-we0-f176.google.com with SMTP id q58so3221126wes.7        for <cygwin-patches@cygwin.com>; Sat, 08 Feb 2014 16:25:56 -0800 (PST)
X-Received: by 10.180.75.202 with SMTP id e10mr5107377wiw.50.1391905556054;        Sat, 08 Feb 2014 16:25:56 -0800 (PST)
Received: from ArchVMl702x.cable.virginmedia.net (cpc1-bagu4-0-0-cust54.1-3.cable.virginm.net. [82.23.84.55])        by mx.google.com with ESMTPSA id xt1sm22363289wjb.17.2014.02.08.16.25.55        for <multiple recipients>        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 08 Feb 2014 16:25:55 -0800 (PST)
From: Ray Donnelly <mingw.android@gmail.com>
To: cygwin-patches@cygwin.com
Cc: Ray Donnelly <mingw.android@gmail.com>
Subject: [PATCH] Expand $CYGWIN error_start processing
Date: Sun, 09 Feb 2014 00:26:00 -0000
Message-Id: <1391905541-986-1-git-send-email-mingw.android@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2014-q1/txt/msg00038.txt.bz2

I want to use QtCreator as my debugger but the hardcoded
nature of error_start makes that impossible.

This change allows a formatted commandline to be used where
'|' is used to represent spaces and <program-name> and
<process-id> are special tokens.

In my case, I set my CYGWIN env. var to
error_start:C:/Qt/bin/qtcreator.exe|-debug|<process-id>

.. note, QtCreator doesn't work if passed the program name
and must be invoked with the -debug option.

Ray Donnelly (1):
  * winsup/cygwin/exceptions.cc: Expand $CYGWIN error_start          
    processing so that custom commandlines can be passed to          
    the debugger program using '|' as an argument delimiter          
    and <program-name> and <process-id> as special tokens.

 winsup/cygwin/exceptions.cc | 50 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

-- 
1.8.5.4
