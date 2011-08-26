Return-Path: <cygwin-patches-return-7497-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10136 invoked by alias); 26 Aug 2011 14:08:03 -0000
Received: (qmail 10079 invoked by uid 22791); 26 Aug 2011 14:08:00 -0000
X-SWARE-Spam-Status: No, hits=-7.1 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 26 Aug 2011 14:07:44 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7QE7iMn011816	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2011 10:07:44 -0400
Received: from [10.3.113.46] (ovpn-113-46.phx2.redhat.com [10.3.113.46])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p7QE7haT011900	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2011 10:07:43 -0400
Message-ID: <4E57A8AF.3000703@redhat.com>
Date: Fri, 26 Aug 2011 14:08:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110817 Fedora/3.1.12-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.12
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
References: <4E570027.9050300@cs.utoronto.ca>
In-Reply-To: <4E570027.9050300@cs.utoronto.ca>
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
X-SW-Source: 2011-q3/txt/msg00073.txt.bz2

On 08/25/2011 08:08 PM, Ryan Johnson wrote:

> Based on the feedback on cygwin-dev, I've put together a revised pair of faq.using entries: one listing briefly the symptoms of fork failures and what to do about it, and the other giving some details about why fork fails (sometimes in spite of everything we do to compensate).

> +
> +<listitem>DLL injection by BLODA. Badly-behaved applications which
> +    inject dlls into other processes often manage to clobber important
> +    sections of the child's address space, leading to base address
> +    collisions which rebasing cannot fix.

I would suggest adding an <a href=> tag around BLODA, to point users to 
the list of known bad software.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
