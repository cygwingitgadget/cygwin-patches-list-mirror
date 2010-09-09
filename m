Return-Path: <cygwin-patches-return-7086-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12128 invoked by alias); 9 Sep 2010 21:21:50 -0000
Received: (qmail 12117 invoked by uid 22791); 9 Sep 2010 21:21:49 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ey0-f171.google.com (HELO mail-ey0-f171.google.com) (209.85.215.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 09 Sep 2010 21:21:43 +0000
Received: by eyg7 with SMTP id 7so1844361eyg.2        for <cygwin-patches@cygwin.com>; Thu, 09 Sep 2010 14:21:41 -0700 (PDT)
Received: by 10.216.47.196 with SMTP id t46mr352209web.13.1284067300912;        Thu, 09 Sep 2010 14:21:40 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.5-4.cable.virginmedia.com [82.6.108.62])        by mx.google.com with ESMTPS id k46sm1202561weq.10.2010.09.09.14.21.39        (version=SSLv3 cipher=RC4-MD5);        Thu, 09 Sep 2010 14:21:39 -0700 (PDT)
Message-ID: <4C89551E.9040304@gmail.com>
Date: Thu, 09 Sep 2010 21:21:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx> <4C893D9C.6040406@gmail.com> <4C894949.4050908@ixiacom.com>
In-Reply-To: <4C894949.4050908@ixiacom.com>
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
X-SW-Source: 2010-q3/txt/msg00046.txt.bz2

On 09/09/2010 21:53, Earl Chew wrote:
> On 09/09/2010 1:03 PM, Dave Korn wrote:
>>> but I think we
>>> should keep the parsing of /etc/fstab as lean as possible; 
>>   I don't understand why.  How many times per second does /etc/fstab get parsed?
> 
> I interpreted cgf's comment as not wishing to add to the amount of coupling
> with /etc/fstab.
> 
> /etc/fstab is already parsed for /usr/bin and /usr/lib, so in my mind
> the additional query for /tmp doesn't seem to add significantly.

  Right, in case I wasn't clear, my question was really shorthand for "it
can't just be a matter of cycle count, so what is the exact problem?"

    cheers,
      DaveK
