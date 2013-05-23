Return-Path: <cygwin-patches-return-7888-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8608 invoked by alias); 23 May 2013 19:03:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8589 invoked by uid 89); 23 May 2013 19:03:42 -0000
X-Spam-SWARE-Status: No, score=-4.3 required=5.0 tests=AWL,BAYES_00,KHOP_THREADED,RP_MATCHES_RCVD autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Thu, 23 May 2013 19:03:41 +0000
Received: (qmail 96254 invoked by uid 13447); 23 May 2013 19:03:40 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 23 May 2013 19:03:40 -0000
Message-ID: <519E680A.8010308@etr-usa.com>
Date: Thu, 23 May 2013 19:03:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
References: <51782505.5020502@etr-usa.com> <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <5181AF17.2090409@etr-usa.com> <20130523140211.GA5525@calimero.vinschen.de> <20130523141140.GB5525@calimero.vinschen.de>
In-Reply-To: <20130523141140.GB5525@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q2/txt/msg00026.txt.bz2

On 5/23/2013 08:11, Corinna Vinschen wrote:
> On May 23 16:02, Corinna Vinschen wrote:
>> For some reason doc/Makefile.in has lost all dependencies

I noted that in the original proposal: one of the things you got from 
doctool is automatic dependency generation.  I'd put an item on the 
Wishlist to this effect, saying I needed to replace it.

At your prompting, I now have.  There is a new script called xidepend 
which generates Makefile.dep, which is included (and cleaned, if asked) 
by Makefile.in.

It's not perfect.  Because of the time it takes to run the dependency 
chaser, I've elected to make it dependent on only changes to the 
top-level XML files.  This means that if you add an XInclude to one of 
the leaf files, the referenced file won't get added to the dependency 
list for the top-level file that indirectly depends on it until you 
remove Makefile.dep, forcing its re-generation.

> Never mind cygwin-api.  This seems to work fine.

Yes, because it's still using doctool.
