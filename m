Return-Path: <cygwin-patches-return-4518-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28598 invoked by alias); 16 Jan 2004 13:57:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28587 invoked from network); 16 Jan 2004 13:57:53 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <4007EDC8.5020003@gmx.net>
Date: Fri, 16 Jan 2004 13:57:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
MIME-Version: 1.0
To: cygpatches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: Thread safe stdio
References: <Pine.WNT.4.44.0401121110300.1304-200000@algeria.intern.net>
In-Reply-To: <Pine.WNT.4.44.0401121110300.1304-200000@algeria.intern.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00008.txt.bz2

Please ignore this patch, i will generate a new one soon.

Thomas

Thomas Pfaff wrote:
> This patch adds support for thread safe stdio.
> 
> It will add 3 new header files three which supersedes newlib ones.
> 
> One of these (_types.h) is just a copy of newlibs _types.h with a
> modified _lock_t. It is not strictly necessary since sizeof(int)
> == sizeof(void*).
> 
> This patch makes only sense when my patch for newlib will be accepted.
> 
