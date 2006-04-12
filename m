Return-Path: <cygwin-patches-return-5818-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14418 invoked by alias); 12 Apr 2006 14:05:56 -0000
Received: (qmail 14407 invoked by uid 22791); 12 Apr 2006 14:05:56 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Apr 2006 14:05:55 +0000
Received: from mail.artimi.com ([192.168.1.3]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 12 Apr 2006 15:05:49 +0100
Received: from rainbow ([192.168.1.165]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Wed, 12 Apr 2006 15:05:49 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: "'Cygwin Patches'" <cygwin-patches@cygwin.com>
Subject: RE: Patch for silent crash with Cygwin1.dll v 1.5.19-4
Date: Wed, 12 Apr 2006 14:05:00 -0000
Message-ID: <00e001c65e3a$33421240$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060412135333.72244.qmail@web53003.mail.yahoo.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00006.txt.bz2

On 12 April 2006 14:54, Gary Zablackis wrote:

> +++ dll_init.cc 12 Apr 2006 13:41:24 -0000
> @@ -351,6 +351,8 @@ dll_list::load_after_fork (HANDLE
> parent
^^^^^^^^^^^
>  extern "C" int
>  dll_dllcrt0 (HMODULE h, per_process *p)
>  {
> +  _my_tls.init_exception_handler
> (_cygtls::handle_exceptions);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
>    if (p == NULL)
>      p = &__cygwin_user_data;
>    else

  :) Generally it's better to attach the diffs, so they don't get wrapped like
this!

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
