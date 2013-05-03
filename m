Return-Path: <cygwin-patches-return-7879-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6749 invoked by alias); 3 May 2013 22:22:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6734 invoked by uid 89); 3 May 2013 22:22:47 -0000
X-Spam-SWARE-Status: No, score=-5.1 required=5.0 tests=AWL,BAYES_00,KHOP_THREADED,RP_MATCHES_RCVD autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Fri, 03 May 2013 22:22:46 +0000
Received: (qmail 86607 invoked by uid 13447); 3 May 2013 22:22:44 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 3 May 2013 22:22:44 -0000
Message-ID: <518438B0.1080206@etr-usa.com>
Date: Fri, 03 May 2013 22:22:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
References: <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx> <51803D76.5010302@etr-usa.com> <20130501003154.GB3781@ednor.casa.cgf.cx> <51806FB3.5040902@etr-usa.com> <5181AFEA.9010301@etr-usa.com> <20130503203001.GA6868@ednor.casa.cgf.cx>
In-Reply-To: <20130503203001.GA6868@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q2/txt/msg00017.txt.bz2

On 5/3/2013 14:30, Christopher Faylor wrote:
> It looks like you broke the ability to build outside of the source tree.

Sorry about that.

It looks like you're in the middle of fixing it, so rather than fight 
with you over the tree, I'll just let you continue.

I've got one element of the fix here that you haven't yet checked in, 
though.  You need to change the XInclude in cygwin-api.in.xml back to a 
DOCTOOL directive:

<               <xi:include href="legal.xml"/>
---
 > DOCTOOL-INSERT-legal

This is because xsltproc (via xmlto) doesn't know about $(srcdir) for 
XIncludes.  It looks in the same directory as the input XML and doesn't 
see legal.xml, and dies.  If you "#include" this via doctool, problem 
solved.

Bottom line, you can't mix doctool includes and XIncludes.
