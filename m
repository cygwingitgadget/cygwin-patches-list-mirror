Return-Path: <cygwin-patches-return-6527-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2953 invoked by alias); 3 Jun 2009 18:06:38 -0000
Received: (qmail 2940 invoked by uid 22791); 3 Jun 2009 18:06:38 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f224.google.com (HELO mail-fx0-f224.google.com) (209.85.220.224)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Jun 2009 18:06:33 +0000
Received: by fxm24 with SMTP id 24so198353fxm.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 11:06:30 -0700 (PDT)
Received: by 10.103.24.11 with SMTP id b11mr797258muj.90.1244052390390;         Wed, 03 Jun 2009 11:06:30 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id n7sm1073730mue.58.2009.06.03.11.06.28         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 11:06:28 -0700 (PDT)
Message-ID: <4A26BE6C.2020900@gmail.com>
Date: Wed, 03 Jun 2009 18:06:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Pthread fixes arising.
References: <4A26BDE4.5060308@gmail.com>
In-Reply-To: <4A26BDE4.5060308@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2009-q2/txt/msg00069.txt.bz2

Dave Korn wrote:

>   *** main is now taking and releasing it recursively with a bias of one ****

  Two, not one.

    cheers,
      DaveK
