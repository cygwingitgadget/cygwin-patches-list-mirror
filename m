Return-Path: <cygwin-patches-return-7291-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28529 invoked by alias); 4 May 2011 03:12:07 -0000
Received: (qmail 28518 invoked by uid 22791); 4 May 2011 03:12:06 -0000
X-SWARE-Spam-Status: No, hits=0.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 03:11:53 +0000
Received: by iyi20 with SMTP id 20so870476iyi.2        for <cygwin-patches@cygwin.com>; Tue, 03 May 2011 20:11:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.42.97.5 with SMTP id l5mr854158icn.504.1304478712502; Tue, 03 May 2011 20:11:52 -0700 (PDT)
Received: by 10.231.19.200 with HTTP; Tue, 3 May 2011 20:11:52 -0700 (PDT)
In-Reply-To: <BANLkTikUJ+opazYOga0URTKj6-6Nw_D+pw@mail.gmail.com>
References: <BANLkTikUJ+opazYOga0URTKj6-6Nw_D+pw@mail.gmail.com>
Date: Wed, 04 May 2011 03:12:00 -0000
Message-ID: <BANLkTinhei4VRcfFLeFAJfqwOD08W1Df+w@mail.gmail.com>
Subject: Re: initialize local variable wait_return
From: Chiheng Xu <chiheng.xu@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00057.txt.bz2

2011-05-04  Chiheng Xu  <chiheng.xu@gmail.com>

       * fhandler.cc (fhandler_base_overlapped::wait_overlapped): initialize
local variable wait_return , otherwise, gcc-4.3.4 will not compile it.



-- 
Chiheng Xu
