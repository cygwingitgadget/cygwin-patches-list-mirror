Return-Path: <cygwin-patches-return-6469-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25804 invoked by alias); 3 Apr 2009 22:39:19 -0000
Received: (qmail 25792 invoked by uid 22791); 3 Apr 2009 22:39:18 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f176.google.com (HELO mail-fx0-f176.google.com) (209.85.220.176)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 22:39:07 +0000
Received: by fxm24 with SMTP id 24so1293667fxm.2         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 15:39:04 -0700 (PDT)
Received: by 10.86.76.16 with SMTP id y16mr1379496fga.46.1238798344460;         Fri, 03 Apr 2009 15:39:04 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 4sm9494976fge.23.2009.04.03.15.39.03         (version=SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 15:39:04 -0700 (PDT)
Message-ID: <49D69271.7040805@gmail.com>
Date: Fri, 03 Apr 2009 22:39:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add uchar.h
References: <49D60CC2.8090205@gmail.com> <20090403143528.GA468@calimero.vinschen.de>
In-Reply-To: <20090403143528.GA468@calimero.vinschen.de>
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
X-SW-Source: 2009-q2/txt/msg00011.txt.bz2

Corinna Vinschen wrote:
> On Apr  3 14:18, Dave Korn wrote:
>> Dave Korn wrote:
>>>  I've got a bit of a load on right now what with gcc back in stage1.
>>   However, as part of dealing with that I did try throwing together one of
>> these.  I wrote this from scratch based solely on reading n1040; it's
>> skeletal, but at least provides the two new unicode typedefs.  Want it?
> 
> Care to explain?
> 
> - What's n1040?

  An extension to the language standard specified by the ISO/IEC
JTC1/SC22/WG14 working group for the C language and targeted for the
forthcoming C1X update.

http://www.open-std.org/jtc1/sc22/WG14/

and specifically

http://www.open-std.org/jtc1/sc22/WG14/www/projects#19769

TR 19769: New character types in C

WG14 is working on a TR on new character types, including support for UTF-16.
The title is: TR 19769 - Extensions for the programming language C to support
new character data types. The latest draft, approved for publication, is in
document N1040.

    cheers,
      DaveK
