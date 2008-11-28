Return-Path: <cygwin-patches-return-6365-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23136 invoked by alias); 28 Nov 2008 21:34:19 -0000
Received: (qmail 23124 invoked by uid 22791); 28 Nov 2008 21:34:17 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout05.t-online.de (HELO mailout05.t-online.de) (194.25.134.82)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 28 Nov 2008 21:33:09 +0000
Received: from fwd10.aul.t-online.de  	by mailout05.sul.t-online.de with smtp  	id 1L6AxW-0005oV-05; Fri, 28 Nov 2008 22:33:06 +0100
Received: from [10.3.2.2] (XRDQScZpQhz+5xYKyFUzY8-awjmX1LNehkgZNHU0m9RGtkIqdJPshgleMh61vTnwnV@[217.235.218.233]) by fwd10.aul.t-online.de 	with esmtp id 1L6AxL-0OIcxk0; Fri, 28 Nov 2008 22:32:55 +0100
Message-ID: <49306387.3090906@t-online.de>
Date: Fri, 28 Nov 2008 21:34:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to Cygwin 1.7 ?
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx> <492DD7D0.6050001@t-online.de> <20081127093023.GA9487@calimero.vinschen.de> <1L5eGn-03rme80@fwd09.aul.t-online.de> <20081127111502.GF30831@calimero.vinschen.de> <492F1424.5000004@t-online.de> <20081128021554.GF16768@ednor.casa.cgf.cx> <20081128091049.GA12905@calimero.vinschen.de>
In-Reply-To: <20081128091049.GA12905@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00009.txt.bz2

Corinna Vinschen wrote:
> On Nov 27 21:15, Christopher Faylor wrote:
>   
>> ...
>> If Corinna's ok with this then so am I.
>>     
>
> Yep.  Applied with just a minor change to the ChangeLog entry.
>
>   

Thanks.

Attn maintainers:
If package with dirent.d_type support is rebuild with new sys/dirent.h, 
it is no longer backward compatible with older Cygwin releases. This is 
IMO no problem for packages rebuild for 1.7.

If desired, this can be fixed by initializing d_type after opendir:

   DIR * dir = opendir(path);
   if (!dir) {...}
+#if defined(__CYGWIN__) && defined(_DIRENT_HAVE_D_TYPE)
+  dir->__d_dirent->d_type = DT_UNKNOWN;
+#endif


Probably OT: Current CVS does not work for me, bash fails when first 
command is run:

[C:\cygwin-1.7\bin].\bash
bash-3.2$ ./true
    419 [sig] bash 3016 _cygtls::handle_exceptions: Exception: 
STATUS_ACCESS_VIOLATION
   1032 [sig] bash 3016 open_stackdumpfile: Dumping stack trace to 
bash.exe.stackdump

Using exception.cc 1.326 instead of 1.327 fixes the problem.

Christian
