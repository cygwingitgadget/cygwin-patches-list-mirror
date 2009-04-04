Return-Path: <cygwin-patches-return-6479-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10613 invoked by alias); 4 Apr 2009 12:17:54 -0000
Received: (qmail 10114 invoked by uid 22791); 4 Apr 2009 12:17:52 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 12:17:48 +0000
Received: by ewy21 with SMTP id 21so1331372ewy.2         for <cygwin-patches@cygwin.com>; Sat, 04 Apr 2009 05:17:45 -0700 (PDT)
Received: by 10.210.30.10 with SMTP id d10mr9410ebd.33.1238847464974;         Sat, 04 Apr 2009 05:17:44 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm4194486eyf.22.2009.04.04.05.17.44         (version=SSLv3 cipher=RC4-MD5);         Sat, 04 Apr 2009 05:17:44 -0700 (PDT)
Message-ID: <49D75253.4030506@gmail.com>
Date: Sat, 04 Apr 2009 12:17:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add uchar.h
References: <49D60CC2.8090205@gmail.com> <20090403143528.GA468@calimero.vinschen.de> <49D69271.7040805@gmail.com> <20090404094450.GA7844@calimero.vinschen.de>
In-Reply-To: <20090404094450.GA7844@calimero.vinschen.de>
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
X-SW-Source: 2009-q2/txt/msg00021.txt.bz2

Corinna Vinschen wrote:
> On Apr  3 23:49, Dave Korn wrote:

>> http://www.open-std.org/jtc1/sc22/WG14/www/projects#19769
>>
>> TR 19769: New character types in C

> Thank you, I read it now.  Apart from thinking that it's a tad bit early
> to introduce this header, 

  I thought so too, but since there's a draft spec, and since there are
starting to spring up autoconf checks for this header, I didn't see why not to
offer it.

> I also think this would better fit into newlib.

  I'm not sure.  My reasoning was that since we override newlib's types system
by providing our own stdint.h, it made sense to provide our own uchar.h as well.

> Btw, the functionality is quite easy to hack.  If this actually
> becomes a standard, we can very quickly introduce the header *and* the
> implementation.

  Heh, I didn't even read the function descriptions, I literally just skimmed
the document and blindly copypasta'd the prototypes.

    cheers,
      DaveK
