Return-Path: <cygwin-patches-return-6893-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30667 invoked by alias); 9 Jan 2010 19:30:47 -0000
Received: (qmail 30646 invoked by uid 22791); 9 Jan 2010 19:30:47 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f222.google.com (HELO mail-ew0-f222.google.com) (209.85.219.222)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 09 Jan 2010 19:30:41 +0000
Received: by ewy22 with SMTP id 22so24373391ewy.19         for <cygwin-patches@cygwin.com>; Sat, 09 Jan 2010 11:30:38 -0800 (PST)
Received: by 10.213.41.142 with SMTP id o14mr1045141ebe.70.1263065438408;         Sat, 09 Jan 2010 11:30:38 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm55531eyh.16.2010.01.09.11.30.36         (version=SSLv3 cipher=RC4-MD5);         Sat, 09 Jan 2010 11:30:37 -0800 (PST)
Message-ID: <4B48DD4E.1080701@gmail.com>
Date: Sat, 09 Jan 2010 19:30:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix misc aliasing warnings.
References: <4B486906.4000600@gmail.com> <20100109133348.GO23992@calimero.vinschen.de>
In-Reply-To: <20100109133348.GO23992@calimero.vinschen.de>
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
X-SW-Source: 2010-q1/txt/msg00009.txt.bz2

Corinna Vinschen wrote:

> Concerning fstat_helper, I don't like to slip another layer into these
> calls to pamper an anal-retentive compiler.  I would rather like to fix
> this by removing the FILETIME type from the affected places and use
> LARGE_INTEGER throughout.  It's not overly tricky, given that FILETIME
> time == LARGE_INTEGER kernel time.

  I'll give that patch you posted a test.

>> -	  di = &((DISK_GEOMETRY_EX *) dbuf)->Geometry;
>> +	  DISK_GEOMETRY_EX *dgx = (DISK_GEOMETRY_EX *) dbuf;
>> +	  di = &dgx->Geometry;
> 
> That's ok, even though I don't understand what gcc has to grouch about
> it.  The expressions should be identical.

  I don't always understand the aliasing rules.  Maybe it's the introduction
of a sequence point between the cast and the dereference that pacifies it.

> Shouldn't defining szBuffer as a union pointer avoid the need to memcpy?
> Like this:

  Well yeh, but it's a far bigger change, which was why I didn't.  Don't mind
giving it a test though.

> Wouldn't temporary pointers
> avoid the memcpy?

  Probably, but I was expecting the compiler to thoroughly optimize those
memcpys anyway.  I'll double-check with this and the previous one how the
generated code looks.

>>  #define IN6_ARE_ADDR_EQUAL(a, b) \
>> -	(((const uint32_t *)(a))[0] == ((const uint32_t *)(b))[0] \
>> -	 && ((const uint32_t *)(a))[1] == ((const uint32_t *)(b))[1] \
>> -	 && ((const uint32_t *)(a))[2] == ((const uint32_t *)(b))[2] \
>> -	 && ((const uint32_t *)(a))[3] == ((const uint32_t *)(b))[3])
>> +	(!memcmp ((a), (b), 4 * sizeof (uint32_t)))
> 
> Hang on.  That's almost exactly the definition of IN6_ARE_ADDR_EQUAL as
> on Linux and on other systems.  If that doesn't work anymore, not only
> this one has to be changed, but all the equivalent expressions
> throughout netinet/in.h.  The gcc guys aren';t serious about that,
> are they?

  I'll ask upstream about this one, and perhaps the disk geometry thing as
well.  It's not like any of this is urgent, 4.5 is still a little ways off
release so I'm just trying to lay some groundwork in advance.

  So, I'll test your version of the fhandler patch, and consult upstream about
a couple of the others, and we'll come back to this shortly.  Thanks for the
reviews.

    cheers,
      DaveK
