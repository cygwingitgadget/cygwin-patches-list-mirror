Return-Path: <cygwin-patches-return-6722-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1618 invoked by alias); 6 Oct 2009 18:46:22 -0000
Received: (qmail 1607 invoked by uid 22791); 6 Oct 2009 18:46:21 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 18:46:16 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id D151488741 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 14:46:11 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Tue, 06 Oct 2009 14:46:11 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id A85517C96; 	Tue,  6 Oct 2009 14:45:28 -0400 (EDT)
Message-ID: <4ACB9042.3070104@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 18:46:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <20091005202722.GG12789@calimero.vinschen.de>  <4ACA5BC7.6090908@cwilson.fastmail.fm>  <20091006034229.GA12172@ednor.casa.cgf.cx>  <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm> <20091006182221.GD18135@ednor.casa.cgf.cx>
In-Reply-To: <20091006182221.GD18135@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00053.txt.bz2

Christopher Faylor wrote:

> Looks good with a minor kvetch: Could you use "bool" instead of "BOOL"
> for variables that don't have to be passed to a Windows function that
> takes a BOOL argument?

For the static function exit_process(), sure. But the argument list
accepted by cygwin_internal() should be C-compatible, shouldn't it? So,
how about the following?

static void exit_process (UINT, bool) __attribute__((noreturn));
...
static void
exit_process (UINT status, bool useTerminateProcess)
{
...
}
...
      case CW_EXIT_PROCESS:
        {
          UINT status = va_arg (arg, UINT);
          BOOL useTerminateProcess = va_arg (arg, BOOL);
          exit_process (status, !!useTerminateProcess); /* no return */
        }

--
Chuck
