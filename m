Return-Path: <cygwin-patches-return-4217-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16593 invoked by alias); 15 Sep 2003 11:19:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16576 invoked from network); 15 Sep 2003 11:18:58 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3F65A007.80406@gmx.net>
Date: Mon, 15 Sep 2003 11:19:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread patch - Thomas Pfaff, please note
References: <20030913012508.GA2870@redhat.com>
In-Reply-To: <20030913012508.GA2870@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00233.txt.bz2

Christopher Faylor wrote:
> Thomas, I made the change below to stop a SEGV on thread exit as evinced
> by the threadidafterfork test in the testsuite.
> 
> The problem is that this code overwrites impure_ptr with the contents of
> the thread which called fork, which is not the correct thing to do since
> _impure_ptr contains global information not present in the calling threads
> reent structure.
> 
> I hope it makes sense.  If there is some better way to do this, please
> feel free to check it in.  This looked right to me, though.

It is ok for me.

I was not sure whether the thread local reent contains something 
important that should be restored after a fork, but with the 
_GLOBAL_REENT patches to newlib it is better to keep _impure_ptr unchanged.

Thomas
