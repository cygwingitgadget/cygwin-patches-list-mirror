Return-Path: <cygwin-patches-return-4350-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24734 invoked by alias); 10 Nov 2003 14:03:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24711 invoked from network); 10 Nov 2003 14:03:14 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3FAF9A9A.3070509@gmx.net>
Date: Mon, 10 Nov 2003 14:03:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] stdio initialization
References: <Pine.WNT.4.44.0311101211450.1520-200000@algeria.intern.net> <20031110135740.GA12455@redhat.com>
In-Reply-To: <20031110135740.GA12455@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00069.txt.bz2

Christopher Faylor wrote:
> On Mon, Nov 10, 2003 at 12:23:35PM +0100, Thomas Pfaff wrote:
> 
>>Attached patch fixes the memory leak reported by Arash Partow by
>>initializing stdio during startup and setting __sdidinit from thread
>>local clib appropriately.
>>
>>Thomas
>>
>>2003-11-10  Thomas Pfaff  <tpfaff@gmx.net>
>>
>>	* dcrt0.cc: Add prototype for __sinit.
>>	(dll_crt0_1): Initialize stdio.
> 
> 
> The above two things are already done in dcrt0.cc.  Why are you adding
> additional prototypes and going to additional work?
> 

Ouch. I should have stayed in bed today.

Thomas
