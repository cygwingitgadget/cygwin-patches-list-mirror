Return-Path: <cygwin-patches-return-4815-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19097 invoked by alias); 3 Jun 2004 21:04:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19064 invoked from network); 3 Jun 2004 21:04:40 -0000
Message-ID: <40BF9225.8040100@att.net>
Date: Thu, 03 Jun 2004 21:04:00 -0000
From: David Fritz <zeroxdf@att.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch]: NUL and other special names
References: <3.0.5.32.20040531184611.0080be60@incoming.verizon.net> <40BF81C4.1020105@att.net> <40BF870A.B42E5C3E@phumblet.no-ip.org>
In-Reply-To: <40BF870A.B42E5C3E@phumblet.no-ip.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00167.txt.bz2

Pierre A. Humblet wrote:

[...]
> Does it handle conin$, conout$ and clocks$ ?

It would appear that it does not (under Win2k SP4):

0x00000000  foo
0x00000006  con
0x00000006  nul
0x00000006  prn
0x00000008  lpt1
0x00000000  lpt16
0x00000008  com1
0x00000000  com16
0x00000000  conin$
0x00000000  conout$
0x00000000  clock$

It also seems to only handle single digit com and lpt names.
