Return-Path: <cygwin-patches-return-3810-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2332 invoked by alias); 14 Apr 2003 14:31:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2319 invoked from network); 14 Apr 2003 14:31:17 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3E9AC616.8040905@gmx.net>
Date: Mon, 14 Apr 2003 14:31:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] enable -finline-functions optimization
References: <Pine.WNT.4.44.0304091020470.272-200000@algeria.intern.net> <20030409154807.GD5879@redhat.com> <3E9A6F15.6060506@gmx.net> <20030414140539.GA28133@redhat.com>
In-Reply-To: <20030414140539.GA28133@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00037.txt.bz2

Christopher Faylor wrote:
> On Mon, Apr 14, 2003 at 10:19:33AM +0200, Thomas Pfaff wrote:
> 
>>According to
>>http://gcc.gnu.org/onlinedocs/gcc-3.2.1/gcc/Function-Attributes.html
>>__attribute__((used)) should do the trick, but it doesn't seem to work.
> 
> Look at exceptions.cc: unused_sig_wrapper.

Look at my patch: unused_sig_wrapper is removed when the code is 
compiled with -finline-functions.

I tried
static void unused_sig_wrapper () __attribute__((const, used, noinline));

and __attribute__((used)) should prevent the removal, but it didn't.

Thomas


