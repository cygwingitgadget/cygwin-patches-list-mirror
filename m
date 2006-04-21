Return-Path: <cygwin-patches-return-5836-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3770 invoked by alias); 21 Apr 2006 20:33:50 -0000
Received: (qmail 3758 invoked by uid 22791); 21 Apr 2006 20:33:50 -0000
X-Spam-Check-By: sourceware.org
Received: from vms042pub.verizon.net (HELO vms042pub.verizon.net) (206.46.252.42)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Apr 2006 20:33:48 +0000
Received: from PHUMBLETXP ([12.6.244.2])  by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005)) with ESMTPA id <0IY3006TBAG61OH3@vms042.mailsrvcs.net> for  cygwin-patches@cygwin.com; Fri, 21 Apr 2006 15:33:42 -0500 (CDT)
Date: Fri, 21 Apr 2006 20:33:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Make getenv() functional before the environment is  initialized
To: <cygwin-patches@cygwin.com>
Message-id: <022b01c66582$b3d396a0$280010ac@wirelessworld.airvananet.com>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-transfer-encoding: 7bit
References: <027701c65998$178103f0$280010ac@wirelessworld.airvananet.com>  <20060421172328.GD7685@calimero.vinschen.de>  <01ca01c66574$b295c7d0$280010ac@wirelessworld.airvananet.com>  <20060421191314.GA11311@trixie.casa.cgf.cx>  <01fc01c6657c$347794c0$280010ac@wirelessworld.airvananet.com>  <20060421201200.GA8588@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00024.txt.bz2


----- Original Message ----- 
From: "Christopher Faylor" <cgf-no-personal-reply-please@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, April 21, 2006 4:12 PM
Subject: Re: [Patch] Make getenv() functional before the environment is 
initialized


>>
>>But doesn't the program then have a pointer to memory that has been freed?
>>That pointer can also be accessed after forks.
>
> Isn't that always a possibility?  You can't rely on the persistence of
> the stuff returned from getenv().

That's not my reading of 
http://www.opengroup.org/onlinepubs/000095399/functions/getenv.html

"The string pointed to may be overwritten by a subsequent call to getenv(),
 but shall not be overwritten by a call to any other function in this volume of 
IEEE Std 1003.1-2001."

Athough Posix allows the string to be overwritten, indicating that persistence 
is implied,
it does not allow the pointer to become invalid.

See also
http://developer.apple.com/documentation/Darwin/Reference/Manpages/man3/getenv.3.html
which says that the environment semantics make it inherently leaky.
That's why I didn't hesitate calling cmalloc

Pierre
