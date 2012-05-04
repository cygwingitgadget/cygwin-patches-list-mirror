Return-Path: <cygwin-patches-return-7660-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30009 invoked by alias); 4 May 2012 05:49:46 -0000
Received: (qmail 29997 invoked by uid 22791); 4 May 2012 05:49:45 -0000
X-SWARE-Spam-Status: No, hits=-2.8 required=5.0	tests=BAYES_00,KHOP_RCVD_UNTRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,SPF_NEUTRAL,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from bureau83.ns.utoronto.ca (HELO bureau83.ns.utoronto.ca) (128.100.132.183)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 04 May 2012 05:49:32 +0000
Received: from [192.168.2.111] (66.219.228.149.provo.dynamic.broadweavenetworks.net [66.219.228.149])	(authenticated bits=0)	by bureau83.ns.utoronto.ca (8.13.8/8.13.8) with ESMTP id q445nRoA031135	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 4 May 2012 01:49:30 -0400
Message-ID: <4FA36DE9.6090404@cs.utoronto.ca>
Date: Fri, 04 May 2012 05:49:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: elf.h incomplete
References: <4FA281E3.4020008@samsung.com> <CA+sc5mnHw0CuSzaPiAV4ALQVEKs6_Nc20JrEvu-r121nZU3REg@mail.gmail.com> <4FA2870D.1030604@samsung.com> <4FA28961.2010407@cs.utoronto.ca> <4FA28F35.6060000@samsung.com> <4FA29070.1060300@gmail.com> <20120503152458.GB22355@ednor.casa.cgf.cx> <4FA300AB.3080306@users.sourceforge.net> <20120504054649.GA30831@ednor.casa.cgf.cx>
In-Reply-To: <20120504054649.GA30831@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2012-q2/txt/msg00029.txt.bz2

On 03/05/2012 11:46 PM, Christopher Faylor wrote:
> On Thu, May 03, 2012 at 05:03:23PM -0500, Yaakov (Cygwin/X) wrote:
>> On 2012-05-03 10:24, Christopher Faylor wrote:
>>> Right.  I've noticed the incompleteness of elf.h from time to time too but
>>> extending it would be tedious since you can't just cut/paste from a GPLv*
>>> file.  Maybe one of the BSDs has something more complete these days?  We
>>> could use one of those.
>> This patch is a direct copy from FreeBSD HEAD.  I have NOT tested it,
>> though.
> I think this really needs to be tested against something that uses it.
>
> Anyone have an application that could exercise this?
Linux kernel build's "modpost" utility that started off this whole 
discussion? I'm not going to be able to test it any time soon, myself, tho.

Also, libelf might use it, since it supplies its own values only if it 
can't find them in system headers, IIRC.

Ryan
