Return-Path: <cygwin-patches-return-7032-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22662 invoked by alias); 6 May 2010 19:02:41 -0000
Received: (qmail 22587 invoked by uid 22791); 6 May 2010 19:02:40 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-wy0-f171.google.com (HELO mail-wy0-f171.google.com) (74.125.82.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 06 May 2010 19:02:36 +0000
Received: by wya21 with SMTP id 21so98068wya.2        for <cygwin-patches@cygwin.com>; Thu, 06 May 2010 12:02:34 -0700 (PDT)
Received: by 10.216.87.204 with SMTP id y54mr1658232wee.142.1273172552563;        Thu, 06 May 2010 12:02:32 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])        by mx.google.com with ESMTPS id l46sm700643wed.10.2010.05.06.12.02.31        (version=SSLv3 cipher=RC4-MD5);        Thu, 06 May 2010 12:02:31 -0700 (PDT)
Message-ID: <4BE316D7.3070806@gmail.com>
Date: Thu, 06 May 2010 19:02:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
References: <1273170255.10571.1373764557@webmail.messagingengine.com>
In-Reply-To: <1273170255.10571.1373764557@webmail.messagingengine.com>
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
X-SW-Source: 2010-q2/txt/msg00015.txt.bz2

On 06/05/2010 19:24, Charles Wilson wrote:

> But...if I understand correctly, doing this moves the "fix" for the
> problem Dave identified into that internal code -- which means that the
> mingw guys won't benefit from it, unless they re-implement it in the
> "outside" code.  

  The mingw guys won't benefit from this fix until they implement fork
semantics, i.e. never...

    cheers,
      DaveK
