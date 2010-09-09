Return-Path: <cygwin-patches-return-7083-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3357 invoked by alias); 9 Sep 2010 19:41:36 -0000
Received: (qmail 3345 invoked by uid 22791); 9 Sep 2010 19:41:35 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ey0-f171.google.com (HELO mail-ey0-f171.google.com) (209.85.215.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 09 Sep 2010 19:41:30 +0000
Received: by eyg7 with SMTP id 7so1717527eyg.2        for <cygwin-patches@cygwin.com>; Thu, 09 Sep 2010 12:41:28 -0700 (PDT)
Received: by 10.216.38.84 with SMTP id z62mr188662wea.70.1284061281608;        Thu, 09 Sep 2010 12:41:21 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.5-4.cable.virginmedia.com [82.6.108.62])        by mx.google.com with ESMTPS id k46sm1125157weq.34.2010.09.09.12.41.20        (version=SSLv3 cipher=RC4-MD5);        Thu, 09 Sep 2010 12:41:20 -0700 (PDT)
Message-ID: <4C893D9C.6040406@gmail.com>
Date: Thu, 09 Sep 2010 19:41:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx>
In-Reply-To: <20100908224108.GB13153@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q3/txt/msg00043.txt.bz2

On 08/09/2010 23:41, Christopher Faylor wrote:
>  Corinna may disagree,

  Needless to say, I'm not Corinna!

> but I think we
> should keep the parsing of /etc/fstab as lean as possible; 

  I don't understand why.  How many times per second does /etc/fstab get parsed?

    cheers,
      DaveK
