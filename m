Return-Path: <cygwin-patches-return-6724-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15215 invoked by alias); 6 Oct 2009 19:51:40 -0000
Received: (qmail 15203 invoked by uid 22791); 6 Oct 2009 19:51:39 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 19:51:34 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 3B0C688ABC 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 15:51:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Tue, 06 Oct 2009 15:51:33 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id CA597F2D; 	Tue,  6 Oct 2009 15:51:32 -0400 (EDT)
Message-ID: <4ACB9FBE.5080700@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 19:51:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <20091005202722.GG12789@calimero.vinschen.de>  <4ACA5BC7.6090908@cwilson.fastmail.fm>  <20091006034229.GA12172@ednor.casa.cgf.cx>  <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm> <20091006193502.GA18384@ednor.casa.cgf.cx>
In-Reply-To: <20091006193502.GA18384@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00055.txt.bz2

Christopher Faylor wrote:
> On Tue, Oct 06, 2009 at 02:45:22PM -0400, Charles Wilson wrote:
>> Christopher Faylor wrote:
>>
>>> Looks good with a minor kvetch: Could you use "bool" instead of "BOOL"
>>> for variables that don't have to be passed to a Windows function that
>>> takes a BOOL argument?
>> For the static function exit_process(), sure. But the argument list
>> accepted by cygwin_internal() should be C-compatible, shouldn't it? So,
>> how about the following?
> 
> "bool" is C-compatible.  You just have to #include <stdbool.h> .

I keep forgetting about stdbool.

> But now that you mention it, I wonder if we really should have to
> require an #include <windows.h> to use this.  Maybe it should just
> be unsigned long.

I don't see that /that/ makes much difference. Some of the existing
cygwin_internal calls already expect DWORD argument (sure, you could
pass them as unsigned long instead).  Or
CW_GET_POSIX_SECURITY_ATTRIBUTE, which expects a PSECURITY_ATTRIBUTES.

So, it's really a question of what do we want the user to have to
#include when they call, specifically, cygwin_internal(CW_EXIT_PROCESS,...).

Well, obviously, <sys/cygwin.h>.  They may or may not require <ntdef.h>
if they want to use pre-defined STATUS_* values.  But to me, the kicker
is: this is a wrapper/replacement for the w32 functions ExitProcess and
TerminateProcess. So...if someone *was* going to include <windows.h> in
order to call /those/ functions, I don't see why they'd object to doing
so to call the cygwin_internal(CW_EXIT_PROCESS,...) wrapper.

OTOH, this particular value is not even passed to those underlying w32
functions -- it's only used as part of the *cygwin* cygwin_internal
implementation.  Since we no longer pass a HANDLE to the
TerminateProcess wrapper, it does seem a bit icky to #include
<windows.h> only for a BOOL type that we don't even pass to the w32
functions.  Why should *cygwin* deliberately choose to use braindead w32
"types" when it doesn't need to?

...meh.

Having said all that, I really don't care one way or the other. We have
three possibilities:

1) current iteration (BOOL in cygwin_internal coerced to bool for static
function exit_process)
2) use bool throughout exceptions.cc, and expect caller to use C++ bool,
C99 bool, or stdbool.h bool.
3) use bool in static function exit_process, use unsigned long in
cygwin_internal and callers.

You guys pick one, and I'll do it that way.

--
Chuck
