Return-Path: <cygwin-patches-return-3154-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30062 invoked by alias); 12 Nov 2002 03:03:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30053 invoked from network); 12 Nov 2002 03:03:52 -0000
Message-ID: <3DD06F9B.1010102@netstd.com>
Date: Mon, 11 Nov 2002 19:03:00 -0000
From: Wu Yongwei <adah@netstd.com>
Organization: Kingnet Security, Inc.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en, en-us, zh-cn, zh
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: Make ip.h and tcp.h work under -fnative-struct or -mms-bitfields
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00105.txt.bz2

Sorry for my ignorance and noise, but I still want to ask what problems 
could occur if I use u_char instead of u_int to denote bit fields.

Any answer is appreciated.

(Of course I would like to have a header file working across all my 
Windows compilers. Others may appreciate it too.)

Best regards,

Wu Yongwei

--- Original Message from Christopher Faylor ---

Danny's suggestion is correct.  The rest of the header files which 
accomodate this are probably using __attribute__((packed)) .  The 
argument that the header works ok for you on MSVC is a non-issue for cygwin.

cgf
