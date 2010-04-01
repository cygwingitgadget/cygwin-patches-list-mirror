Return-Path: <cygwin-patches-return-7019-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12996 invoked by alias); 1 Apr 2010 04:41:23 -0000
Received: (qmail 12970 invoked by uid 22791); 1 Apr 2010 04:41:22 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-55-5.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.55.5)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 01 Apr 2010 04:41:16 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id EF34513C061 	for <cygwin-patches@cygwin.com>; Thu,  1 Apr 2010 00:41:14 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id D755E2B352; Thu,  1 Apr 2010 00:41:14 -0400 (EDT)
Date: Thu, 01 Apr 2010 04:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: special font characters in rxvt
Message-ID: <20100401044114.GA28174@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4BABAE0A.7090903@bopp.net>  <2BF01EB27B56CC478AD6E5A0A28931F2D14369@A1DAL1SWPES19MB.ams.acs-inc.net>  <4BB3CD56.1040901@cwilson.fastmail.fm>  <20100401002731.GB24706@ednor.casa.cgf.cx>  <4BB403D7.5030909@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB403D7.5030909@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00002.txt.bz2

On Wed, Mar 31, 2010 at 10:24:23PM -0400, Charles Wilson wrote:
>On 3/31/2010 8:27 PM, Christopher Faylor wrote:
>> On Wed, Mar 31, 2010 at 06:31:50PM -0400, Charles Wilson wrote:
>>> Good idea. How about this (followup to cygwin-patches):
>> 
>> I think you need to do a "cvs update".
>
>Ah.  OK...how about this slight tweak...
>Index: winsup/doc/setup-net.sgml
>===================================================================
>RCS file: /cvs/src/src/winsup/doc/setup-net.sgml,v
>retrieving revision 1.23
>diff -u -p -r1.23 setup-net.sgml
>--- winsup/doc/setup-net.sgml	31 Mar 2010 21:06:43 -0000	1.23
>+++ winsup/doc/setup-net.sgml	1 Apr 2010 02:20:52 -0000
>@@ -215,8 +215,9 @@ shows progress bars for the current task
> <para>
> You may choose to install shortcuts on the Desktop and/or Start Menu
> to start a <literal>bash</literal> shell. If you prefer to use a different
>-shell or the native Windows version of <literal>mintty</literal> or <literal>rxvt</literal>, you can
>-use these shortcuts as a guide to creating your own. 
>+shell or terminal emulator such as <literal>mintty</literal> or
>+<literal>xterm</literal>, you can use these shortcuts as a guide to
>+creating your own. 
> </para>
> </sect2>

Sure.  Please check in.

cgf
