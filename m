Return-Path: <cygwin-patches-return-7085-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10217 invoked by alias); 9 Sep 2010 21:17:33 -0000
Received: (qmail 10204 invoked by uid 22791); 9 Sep 2010 21:17:32 -0000
X-SWARE-Spam-Status: No, hits=4.7 required=5.0	tests=AWL,BAYES_20,BOTNET,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from vms173005pub.verizon.net (HELO vms173005pub.verizon.net) (206.46.173.5)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 09 Sep 2010 21:16:58 +0000
Received: from PHUMBLETLAPXP ([unknown] [131.239.32.100]) by vms173005.mailsrvcs.net (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009)) with ESMTPA id <0L8I00MJH0FKIOL8@vms173005.mailsrvcs.net> for cygwin-patches@cygwin.com; Thu, 09 Sep 2010 16:16:38 -0500 (CDT)
Message-id: <0af101cb5064$386d4cf0$2a0010ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com> <20100908224108.GB13153@ednor.casa.cgf.cx> <4C893D9C.6040406@gmail.com>
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
Date: Thu, 09 Sep 2010 21:17:00 -0000
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
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
X-SW-Source: 2010-q3/txt/msg00045.txt.bz2

----- Original Message ----- 
From: "Dave Korn" 
To: <cygwin-patches>
Sent: Thursday, September 09, 2010 16:03


| On 08/09/2010 23:41, Christopher Faylor wrote:
| >  Corinna may disagree,
| 
|  Needless to say, I'm not Corinna!
| 
| > but I think we
| > should keep the parsing of /etc/fstab as lean as possible; 
| 
|  I don't understand why.  How many times per second does /etc/fstab get parsed?

My problem with the original patch is that the mountinfo is kept per user, if my
memory is correct, and /etc/fstab is parsed by the first process of a user.

So, for example, if the user logs in interactively while a cron job (or another service)
is running, /tmp may be mapped differently than if no cron job is running, because
TMP may be defined differently in the service environment.
That is not desirable.

Corinna's suggestions are more appealing. If there are objections to using a 
/etc/profile.d/tmp-mnt.sh or an installer script, why not have /etc/profile 
(or such) create /etc/fstab.d/$USER on the fly if needed ?

Pierre 
