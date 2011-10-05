Return-Path: <cygwin-patches-return-7512-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14085 invoked by alias); 5 Oct 2011 13:55:18 -0000
Received: (qmail 14074 invoked by uid 22791); 5 Oct 2011 13:55:17 -0000
X-SWARE-Spam-Status: No, hits=-7.1 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,SPF_HELO_PASS,TW_DR
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 Oct 2011 13:54:43 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p95DsguM027645	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Wed, 5 Oct 2011 09:54:43 -0400
Received: from [10.3.113.98] (ovpn-113-98.phx2.redhat.com [10.3.113.98])	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p95DsgVh014959	for <cygwin-patches@cygwin.com>; Wed, 5 Oct 2011 09:54:42 -0400
Message-ID: <4E8C61A2.9000608@redhat.com>
Date: Wed, 05 Oct 2011 13:55:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.22) Gecko/20110906 Fedora/3.1.14-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.4 Thunderbird/3.1.14
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow usage of union wait for wait() functions and macros
References: <4E8C3828.4010009@t-online.de>
In-Reply-To: <4E8C3828.4010009@t-online.de>
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00002.txt.bz2

On 10/05/2011 04:57 AM, Christian Franke wrote:
> The file include/sys/wait.h provides union wait but neither the wait()
> functions nor the W*() macros allow to actually use it. Compilation of
> cdrkit 1.1.11 fails because the configure check assumes that union wait
> is the status parameter type if its declaration exists.
>
> The attached patch fixes this. It uses GCC extensions for C and
> overloading for C++. Works also with the old Cygwin gcc-3.
>

> +/* Will be redefined in sys/wait.h.  */
> +#define __wait_status_to_int(w)  (w)
> +
>   /* A status looks like:
>         <2 bytes info>  <2 bytes code>

As long as you're touching this code, fix this incorrect comment.

A status is 16 bits, and looks like:
   <1 byte info> <1 byte code>

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
