Return-Path: <cygwin-patches-return-3807-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8609 invoked by alias); 14 Apr 2003 08:19:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8594 invoked from network); 14 Apr 2003 08:19:42 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3E9A6F15.6060506@gmx.net>
Date: Mon, 14 Apr 2003 08:19:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] enable -finline-functions optimization
References: <Pine.WNT.4.44.0304091020470.272-200000@algeria.intern.net> <20030409154807.GD5879@redhat.com>
In-Reply-To: <20030409154807.GD5879@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00034.txt.bz2

Christopher Faylor wrote:
> On Wed, Apr 09, 2003 at 11:03:42AM +0200, Thomas Pfaff wrote:
> 
>>This patch enables inline optimization for the c++ source files
>>in winsup/cygwin.
>>
>>I tried several attributes for std_dll_init, wsock_init and
>>unused_sig_wrapper without success, the only working solution was to
>>change the functions from static to global to avoid its removal.
>>
>>And the new_muto in the pwdgrp constructors can not be inlined for more
>>than one instance.
>>
> Sorry but I'm not going to change something that should be a valid static into
> a global just to accommodate the compiler.  There should be compiler attributes
> which allow this to behave normally.

As i already mentioned i have tried several attributes.
According to
http://gcc.gnu.org/onlinedocs/gcc-3.2.1/gcc/Function-Attributes.html
__attribute__((used)) should do the trick, but it doesn't seem to work.

> Also, minor point of order:  This a [RFA], not a [PATCH].

Excuse my ignorance.

Thomas
