Return-Path: <cygwin-patches-return-6489-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12795 invoked by alias); 7 Apr 2009 13:12:19 -0000
Received: (qmail 12785 invoked by uid 22791); 7 Apr 2009 13:12:19 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 13:12:14 +0000
Received: by ewy21 with SMTP id 21so2457103ewy.2         for <cygwin-patches@cygwin.com>; Tue, 07 Apr 2009 06:12:11 -0700 (PDT)
Received: by 10.216.72.85 with SMTP id s63mr35174wed.0.1239109931268;         Tue, 07 Apr 2009 06:12:11 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id g11sm502394gve.17.2009.04.07.06.12.10         (version=SSLv3 cipher=RC4-MD5);         Tue, 07 Apr 2009 06:12:10 -0700 (PDT)
Message-ID: <49DB5398.2090403@gmail.com>
Date: Tue, 07 Apr 2009 13:12:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net>
In-Reply-To: <49DB4D95.7000903@byu.net>
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
X-SW-Source: 2009-q2/txt/msg00031.txt.bz2

Eric Blake wrote:

> According to Christopher Faylor on 4/4/2009 12:24 AM:
>>> Because our stdint.h types are divergent from Linux, and changing them
>>> instead could cause yet another ABI break.
>> Why would changing uint32_t from 'unsigned long' to 'unsigned int' break
>> anything?  It looks to me like that is a disaster waiting to happen if
>> we ever provide a 64-bit port.
> 
> If we ever provide a 64-bit port, then we are free to use #ifdef magic to
> select a different underlying type on 64-bit compiles than on 32-bit
> compiles.  

  Indeed, that would be more linux like, because that's how linux does it, e.g
(from http://linux.die.net/include/stdint.h):

# if __WORDSIZE == 64
typedef long int		int64_t;
# else
__extension__
typedef long long int		int64_t;
# endif

    cheers,
      DaveK

