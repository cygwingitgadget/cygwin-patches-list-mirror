Return-Path: <cygwin-patches-return-4819-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16433 invoked by alias); 3 Jun 2004 21:38:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16399 invoked from network); 3 Jun 2004 21:38:54 -0000
Message-ID: <40BF9A29.80408@att.net>
Date: Thu, 03 Jun 2004 21:38:00 -0000
From: David Fritz <zeroxdf@att.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net> <40BF870A.B42E5C3E@phumblet.no-ip.org> <40BF9225.8040100@att.net>
In-Reply-To: <40BF9225.8040100@att.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00171.txt.bz2

I don't think the logic implemented by RtlIsDosDeviceName_U() is all that 
different from the logic in the patch.  Which is to say, it seems to use a 
hard-coded list of names and does not actually check for existing devices.  Do 
we want to block all names that could be DOS devices or just the names of 
devices that exist?

This is interesting:

http://msdn.microsoft.com/library/en-us/fileio/base/querydosdevice.asp

So is this:

-----
C:\>ver

Windows 98 [Version 4.10.2222]


C:\>type config$

Invalid device request reading device CONFIG$
Abort, Retry, Ignore, Fail?f
Fail on INT 24 - config$
-----

Cheers
