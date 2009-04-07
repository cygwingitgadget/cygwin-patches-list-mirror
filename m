Return-Path: <cygwin-patches-return-6486-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7005 invoked by alias); 7 Apr 2009 12:38:01 -0000
Received: (qmail 6994 invoked by uid 22791); 7 Apr 2009 12:38:00 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.148)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 12:37:55 +0000
Received: by ey-out-1920.google.com with SMTP id 5so449447eyb.20         for <cygwin-patches@cygwin.com>; Tue, 07 Apr 2009 05:37:52 -0700 (PDT)
Received: by 10.216.11.66 with SMTP id 44mr18358wew.146.1239107871870;         Tue, 07 Apr 2009 05:37:51 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id t2sm323455gve.14.2009.04.07.05.37.50         (version=SSLv3 cipher=RC4-MD5);         Tue, 07 Apr 2009 05:37:51 -0700 (PDT)
Message-ID: <49DB4814.9030109@gmail.com>
Date: Tue, 07 Apr 2009 12:38:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49D70B05.6020509@gmail.com> <20090404094731.GA7383@calimero.vinschen.de> <20090407090305.GW852@calimero.vinschen.de>
In-Reply-To: <20090407090305.GW852@calimero.vinschen.de>
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
X-SW-Source: 2009-q2/txt/msg00028.txt.bz2

Corinna Vinschen wrote:

> OTOH, we already had to change int32_t and uint32_t from long to int to
> avoid warnings.  Given that we already changed that anyway, I'm wondering
> if it isn't more sane to align the least and fast types as well.

  Well, if there was ever a time to do it, now would be that time, and I'll
happily go update GCC to accord with whatever we decide to do.  I can't say
what kind of incompatibilities might arise, as it's not an easy thing to
google uses of these types specifically in exported rather than internal APIs.
 It's possible things like codec libraries and heavy graphics number-crunchers
might specify these types in externally-visible definitions but I haven't done
an audit.

  As long as we don't change the size, binaries will still interoperate fine,
except where changed name-mangling prevents linking, but e.g. structs and wire
or file formats will remain unchanged.

  I think on balance, it's probably a reasonable idea, but I haven't done a
detailed analysis of the risk so it's possible I've overlooked something
disastrous.  Since 1.7 is still experimental (albeit stabilising rapidly), I
guess we could even just go ahead, and revert it iff problems arise.

  CGF?  You asked a couple of questions and then dropped out of the thread for
a couple of days.  Have you reached any conclusions?

    cheers,
      DaveK

