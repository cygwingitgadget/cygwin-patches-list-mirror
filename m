Return-Path: <cygwin-patches-return-3325-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6137 invoked by alias); 16 Dec 2002 14:54:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5954 invoked from network); 16 Dec 2002 14:54:42 -0000
Message-ID: <3DFDD027.8080300@yahoo.com>
Date: Mon, 16 Dec 2002 06:54:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hartmut Honisch <hartmut_honisch@web.de>
CC:  cygwin-patches@cygwin.com
Subject: Re: Minor additions to winbase.h and ntdll.def
References: <NFBBLLCAILKHOEOHEFMHGEBDCEAA.hartmut_honisch@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00276.txt.bz2

Hartmut Honisch wrote:
> Winbase.h
> - Changed NMPWAIT_WAIT_FOREVER constant from (-1) to 0xffffffff (like in
Why?

> Microsoft's header file)
> - Added LOGON32_LOGON_NETWORK
> 
 > ntdll.def:
 > - Added Nt-/ZwConnectPort, Nt-/ZwOpenEvent,
 > Nt-/ZwRequestWaitReplyPort,
 > Nt-/ZwWaitForSingleObject

Looking at Microsoft's header files and making changes to w32api is not 
allowed.  You'll have to find the MSDN documentation and provide the 
references.

Earnie.
