Return-Path: <cygwin-patches-return-3090-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11831 invoked by alias); 28 Oct 2002 09:39:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11626 invoked from network); 28 Oct 2002 09:39:06 -0000
Message-ID: <3DBD0587.7050208@netstd.com>
Date: Mon, 28 Oct 2002 01:39:00 -0000
From: Wu Yongwei <adah@netstd.com>
Organization: Kingnet Security, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en, en-us, zh-cn, zh
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: Make ip.h and tcp.h work under -fnative-struct or -fms-bitfields
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00041.txt.bz2

Oops, what kind of problem can occur? I did not think of that. But I 
suppose u_char is symmetric with other definitions, and it always works 
for me under GCC or MSVC (while __attribute__((packed)) works only for GCC).

Best regards,

Wu Yongwei

--- Original Message from Danny Smith ---

  --- Wu Yongwei <adah@netstd.com> wrote:
 > These header files use "u_int xxx:4, yyy:4", which in the MS convetion
 > will generate 4-byte instead of 1-byte bit fields.
 >
 > ChangeLog:
 >
 > 2002-10-28  Wu Yongwei <adah@netstd.com>
 >
 > 		 * ip.h (struct ip): Use u_char to indicate bitfields to make it
 > 		 work with -fnative-struct/-fms-bitfields.
 > 		 (struct ip_timestamp): Ditto.
 > 		 * tcp.h (struct tcphdr): Ditto.


Changing types like that can cause problems.
Wouldn't it be better to just use __attribute__((packed)) to pack the 
fields?
Danny

