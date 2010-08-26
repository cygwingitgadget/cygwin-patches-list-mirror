Return-Path: <cygwin-patches-return-7070-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31887 invoked by alias); 26 Aug 2010 17:17:13 -0000
Received: (qmail 31868 invoked by uid 22791); 26 Aug 2010 17:17:12 -0000
X-SWARE-Spam-Status: No, hits=4.9 required=5.0	tests=AWL,BAYES_50,BOTNET,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from vms173013pub.verizon.net (HELO vms173013pub.verizon.net) (206.46.173.13)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 26 Aug 2010 17:17:05 +0000
Received: from PHUMBLETLAPXP ([unknown] [131.239.32.100]) by vms173013.mailsrvcs.net (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009)) with ESMTPA id <0L7R00EFGS011760@vms173013.mailsrvcs.net> for cygwin-patches@cygwin.com; Thu, 26 Aug 2010 12:17:02 -0500 (CDT)
Message-id: <00d601cb4542$7de440e0$2a0010ac@wirelessworld.airvananet.com>
From: "Pierre A. Humblet" <phumblet@phumblet.no-ip.org>
To: <cygwin-patches@cygwin.com>
References: <4e84197e3f02b0bbf6e190e78826148b.squirrel@pseudo.egg6.net> <20100826163812.GM6726@calimero.vinschen.de>
Subject: Re: res_send() doesn't work with osquery enabled
Date: Thu, 26 Aug 2010 17:17:00 -0000
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
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
X-SW-Source: 2010-q3/txt/msg00030.txt.bz2

----- Original Message ----- 
From: "Corinna Vinschen" 
To: <cygwin-patches>
Sent: Thursday, August 26, 2010 12:38


| Pierre, would you mind to take a look?
| 
| On Aug 26 19:07, pseudo@egg6.net wrote:
| > Currently res_init() checks for availability of the native windows
| > function DnsQuery_A. If the function is found, it's preferred over the
| > cygwin implementation and res_query is set up to use it.
| > As DnsQuery_A finds the configured name servers itself, the current code
| > assumes we can avoid loading the dns server list with GetNetworkParams().
| > 
| > However, the assumption that everybody would use res_query is wrong. Some
| > programs may use res_mkquery() and res_send() or may only read the list of
| > servers from _res.nsaddr_list and send/receive the queries/replies
| > themselves. res_send() also relies on nsaddr_list.

It's true that the behavior described above is legitimate, even if nobody had ever 
requested it. If people want to access nsaddr_list after calling res_ninit, loading 
iphlpapi.dll every time (as the patch does) is unavoidable.

The other change has res_nsend return an error if no server can be found.
Alternatively the error could be reported by res_ninit, by removing the second
condition in 
if (statp->nscount == 0 && !statp->os_query) {
    errno = ENONET;
    statp->res_h_errno = NETDB_INTERNAL;

Hypothetically this could affect some installations where iphlpapi doesn't report any
servers although the Windows resolver can find a server (but I don't see how this
could happen), so it's safer to proceed as in the patch.
However the patch should send errno to ENONET and set res_h_errno to
NETDB_INTERNAL

Except for the previous comment, I am fine with the patch.

Pierre
