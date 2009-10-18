Return-Path: <cygwin-patches-return-6788-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32296 invoked by alias); 18 Oct 2009 18:18:56 -0000
Received: (qmail 32284 invoked by uid 22791); 18 Oct 2009 18:18:55 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f223.google.com (HELO mail-ew0-f223.google.com) (209.85.219.223)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 18:18:51 +0000
Received: by ewy23 with SMTP id 23so3528079ewy.2         for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2009 11:18:48 -0700 (PDT)
Received: by 10.211.173.14 with SMTP id a14mr3830459ebp.39.1255889928226;         Sun, 18 Oct 2009 11:18:48 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm148034eyg.4.2009.10.18.11.18.47         (version=SSLv3 cipher=RC4-MD5);         Sun, 18 Oct 2009 11:18:47 -0700 (PDT)
Message-ID: <4ADB5F8A.7080902@gmail.com>
Date: Sun, 18 Oct 2009 18:18:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de> <4ADB22B8.5060108@cwilson.fastmail.fm> <4ADB3D80.4050108@gmail.com> <4ADB542B.6020701@cwilson.fastmail.fm>
In-Reply-To: <4ADB542B.6020701@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00119.txt.bz2

Charles Wilson wrote:
> Dave Korn wrote:
>>   Well, I can think of a possible counter-proposal: how about a patch that
>> adds DESTDIR in the normal manner, but only on platforms that support DESTDIR
>> correctly?  This could be done by testing the --host setting in the Makefile
> 
> Don't you mean the --build setting?  If I'm using a cross-compiler (such
> as, say, gcc3 -mno-cygwin on cygwin, or i686-pc-mingw32-gcc anywhere),
> then so long as my 'make' and 'sh' use posixy paths, I should be ok with
> DESTDIR, right?

  Yes, of course I did.  Thanks.

> This leads to attitudes such as "so what if /src/*/ supports DESTDIR. We
> don't and here's why."  Never mind that this refusal /breaks/ DESTDIR
> support for the entire combined tree, if you're so audacious as to TRY
> to use DESTDIR from a super-directory of src/winsup/mingw/.

  Yes, I think everything that lives in the /src repository should consider
itself obliged to adhere to the common conventions.  If they really find it
onerous, it occurs to me that they could always move mingw sideways - to a
different repository still on the sourceware.org cvs server - and we could
import a mildly-forked version of their packages into winsup just like we
would with any other external library.  That ought to be able to accommodate
everyone's wishes, no?

    cheers,
      DaveK
