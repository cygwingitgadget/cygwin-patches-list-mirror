Return-Path: <cygwin-patches-return-3150-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4897 invoked by alias); 11 Nov 2002 08:55:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4613 invoked from network); 11 Nov 2002 08:55:24 -0000
Message-ID: <3DCF707D.2010205@netstd.com>
Date: Mon, 11 Nov 2002 00:55:00 -0000
From: Wu Yongwei <adah@netstd.com>
Organization: Kingnet Security, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en, en-us, zh-cn, zh
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: Make ip.h and tcp.h work under -fnative-struct or -fms-bitfields
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00101.txt.bz2

Hi,

What's the status of this patch?

----------
ChangeLog:

2002-10-28  Wu Yongwei <adah@netstd.com>

     * ip.h (struct ip): Use u_char to indicate bitfields to make it
     work with -fnative-struct/-fms-bitfields.
     (struct ip_timestamp): Ditto.
     * tcp.h (struct tcphdr): Ditto.
----------

Am I really going the wrong way (any examples)? Or should I submit a new 
patch as Danny suggests?

Best regards,

Wu Yongwei
