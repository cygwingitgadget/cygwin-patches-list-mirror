Return-Path: <cygwin-patches-return-6698-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18934 invoked by alias); 5 Oct 2009 19:08:55 -0000
Received: (qmail 18924 invoked by uid 22791); 5 Oct 2009 19:08:54 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f225.google.com (HELO mail-ew0-f225.google.com) (209.85.219.225)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 19:08:50 +0000
Received: by ewy25 with SMTP id 25so3433841ewy.45         for <cygwin-patches@cygwin.com>; Mon, 05 Oct 2009 12:08:48 -0700 (PDT)
Received: by 10.210.160.10 with SMTP id i10mr3688474ebe.10.1254769727939;         Mon, 05 Oct 2009 12:08:47 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm62174eyh.24.2009.10.05.12.08.46         (version=SSLv3 cipher=RC4-MD5);         Mon, 05 Oct 2009 12:08:47 -0700 (PDT)
Message-ID: <4ACA47AF.7070703@gmail.com>
Date: Mon, 05 Oct 2009 19:08:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm>
In-Reply-To: <4ACA4323.5080103@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00029.txt.bz2

Charles Wilson wrote:

> int main(int argc, char* argv[])
> {
> //cygwin_terminate_process (GetCurrentProcess(),
>                             STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION);
>   cygwin_exit_process (STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION);
>   exit (1);
> }

  Heh.  I see what you did there!

    cheers,
      DaveK
