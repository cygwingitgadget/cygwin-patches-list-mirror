Return-Path: <cygwin-patches-return-2999-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17042 invoked by alias); 19 Sep 2002 04:15:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17026 invoked from network); 19 Sep 2002 04:15:47 -0000
Message-Id: <3.0.5.32.20020919001051.008234e0@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 18 Sep 2002 21:15:00 -0000
To: cygwin-patches@cygwin.com,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: More changes about open on Win95 directories.
In-Reply-To: <20020919033417.GA15825@redhat.com>
References: <3.0.5.32.20020918220225.00810100@mail.attbi.com>
 <3.0.5.32.20020918220225.00810100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00447.txt.bz2

At 11:34 PM 9/18/2002 -0400, Christopher Faylor wrote:
>>  if (fl->l_len < 0)
>>    {
>>      win32_start -= fl->l_len;
>>      win32_len = -fl->l_len;
>>    }
>I've looked at that code a few times and wondered about that.  It seems
>backwards but maybe someone else has more insight.
>
Like, if start = 20 and len = -10, the code above locks 30 to 39.
By changing -= to += it would become 10 to 19. 
But should it really be 11 to 20??? 

>>And yesterday's question: On line 173 of fhandler_disk_file.cc 
>>[strpbrk (get_win32_name (), "?*|<>|")] is there a need for the 
>>two '|'? Was something else meant?
>
>I removed it.  I don't know if there is another invalid character that
>should go there or not, though.

Is '!' invalid? It can easily be confused with '|'.

>It should be
>
>  if (foo)
>    bar = 1;
>
Sorry, I keep doing that.
But only once out of eleven "if"s, this time.

I am bothered that the code uses 0 as an illegal
handle value. Is that really the case?

Pierre
