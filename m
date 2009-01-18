Return-Path: <cygwin-patches-return-6408-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10694 invoked by alias); 18 Jan 2009 21:38:47 -0000
Received: (qmail 10660 invoked by uid 22791); 18 Jan 2009 21:38:46 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.147)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Jan 2009 21:38:42 +0000
Received: by ey-out-1920.google.com with SMTP id 4so263689eyg.20         for <cygwin-patches@cygwin.com>; Sun, 18 Jan 2009 13:38:39 -0800 (PST)
Received: by 10.210.38.17 with SMTP id l17mr3420849ebl.168.1232314719335;         Sun, 18 Jan 2009 13:38:39 -0800 (PST)
Received: by 10.210.81.20 with HTTP; Sun, 18 Jan 2009 13:38:39 -0800 (PST)
Message-ID: <2ca21dcc0901181338l41a01dafm256938683877ce59@mail.gmail.com>
Date: Sun, 18 Jan 2009 21:38:00 -0000
From: "Dave Korn" <dave.korn.cygwin@googlemail.com>
To: "DJ Delorie" <dj@redhat.com>
Subject: Re: [PATCH/libiberty] Fix PR38903 Cygwin GCC bootstrap failure [was Re: Libiberty issue vs cygwin [was Re: This is a Cygwin failure yeah?]]
Cc: gcc-patches@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org,  	cygwin-patches@cygwin.com, kirkshorts@googlemail.com
In-Reply-To: <200901181707.n0IH7AGJ013144@greed.delorie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ca21dcc0901171652s44c72ca7teb1ca6041344e4a4@mail.gmail.com> 	 <200901181707.n0IH7AGJ013144@greed.delorie.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00006.txt.bz2

DJ Delorie wrote:
>>   Ok for HEAD of both gcc/ and src/ ?
>
> Ok.

  Thanks, applied.  I'm feeling lazy: there's still an auto-merger that'll
port it across to src/ for me, isn't there?

    cheers,
      DaveK
