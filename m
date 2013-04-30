Return-Path: <cygwin-patches-return-7870-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24668 invoked by alias); 30 Apr 2013 20:09:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24656 invoked by uid 89); 30 Apr 2013 20:09:58 -0000
X-Spam-SWARE-Status: No, score=-4.8 required=5.0 tests=AWL,BAYES_00,KHOP_THREADED,RP_MATCHES_RCVD autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 30 Apr 2013 20:09:58 +0000
Received: (qmail 14070 invoked by uid 13447); 30 Apr 2013 20:09:56 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 30 Apr 2013 20:09:56 -0000
Message-ID: <51802510.5000803@etr-usa.com>
Date: Tue, 30 Apr 2013 20:09:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
References: <20130423152014.GG26397@calimero.vinschen.de> <5178049C.7000108@etr-usa.com> <20130424172039.GA27256@calimero.vinschen.de> <51782505.5020502@etr-usa.com> <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx>
In-Reply-To: <20130430190706.GC6865@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q2/txt/msg00008.txt.bz2

On 4/30/2013 13:07, Christopher Faylor wrote:
> On Tue, Apr 30, 2013 at 12:58:49PM -0600, Warren Young wrote:
>
>> Do you mean for me to check these changes in when I get my sourceware
>> account?
>
> Yes, with the implied assumption that you won't be breaking anything.

Of course.

Some questions from the original post:

- When a change is checked in to the docs, does it immediately propagate 
to the public web site, or is there a manual publication process?  I 
mean, if the build is technically broken for a few seconds while I check 
in a batch of changes, does it immediately break cygwin.com?  If so, 
that would require that I check in only self-contained change sets even 
if it means long CVS log messages.

- Am I right that we no longer need the second FAQ output format?

- http://cygwin.com/faq.html appears to be assembled from a site-wide 
style/navigation file and winsup/doc/faq/faq.html.  Is that right, and 
if so, do you mind if I add a target to the Makefile that gets you a 
secondary variant of faq.html containing just the <body> tag's contents? 
  Embedding <html> within <html> is eeevil.

- Do you want me to do the proposed doctool to Doxygen conversion, so we 
can get rid of doctool?

- If I get rid of doctool, do you agree that we no longer need Autoconf 
for the docs?

- Is someone using the @srcdir@ feature of the current doc build system 
to build outside the source tree?  (e.g. mkdir foo ; cd foo ; 
../configure && make)  If so, is my "SRCDIR=.. ; make -f ../Makefile" 
alternative acceptable?

(If no one is using the @srcdir@ feature, then we *definitely* don't 
need Autoconf any more after doctool goes away.)

- Any comments about the other items in my FUTURE WORK section? 
Unconditional green light, or do you want to approve them one by one?
