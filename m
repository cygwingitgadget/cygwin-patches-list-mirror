Return-Path: <cygwin-patches-return-7877-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8399 invoked by alias); 2 May 2013 00:14:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8388 invoked by uid 89); 2 May 2013 00:14:41 -0000
X-Spam-SWARE-Status: No, score=-5.0 required=5.0 tests=AWL,BAYES_00,KHOP_THREADED,RP_MATCHES_RCVD autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Thu, 02 May 2013 00:14:41 +0000
Received: (qmail 98179 invoked by uid 13447); 2 May 2013 00:14:39 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 2 May 2013 00:14:39 -0000
Message-ID: <5181AFEA.9010301@etr-usa.com>
Date: Thu, 02 May 2013 00:14:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
References: <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx> <51803D76.5010302@etr-usa.com> <20130501003154.GB3781@ednor.casa.cgf.cx> <51806FB3.5040902@etr-usa.com>
In-Reply-To: <51806FB3.5040902@etr-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2013-q2/txt/msg00015.txt.bz2

On 4/30/2013 19:28, Warren Young wrote:
>
> I have decided: the script shall be called bodysnatcher.pl. :)

I've created this.  There is a new output, winsup/doc/faq/faq.body, 
generated from faq.html whenever it changes.

The core of the script is only about 10 lines, as expected.  Comments, 
whitespace and error checking balloon that to 44 LOC.
