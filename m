Return-Path: <cygwin-patches-return-7691-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4897 invoked by alias); 3 Aug 2012 09:09:40 -0000
Received: (qmail 4883 invoked by uid 22791); 3 Aug 2012 09:09:38 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from enfirhets1.metaswitch.com (HELO ENFIRHETS1.metaswitch.com) (192.91.191.166)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Aug 2012 09:09:25 +0000
Received: from ENFICSCAS1.datcon.co.uk (172.18.4.13) by ENFIRHETS1.metaswitch.com (172.18.209.22) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 3 Aug 2012 10:08:31 +0100
Received: from ENFIRHMBX1.datcon.co.uk ([fe80::b06d:4d13:5f63:3715]) by ENFICSCAS1.datcon.co.uk ([::1]) with mapi id 14.02.0298.004; Fri, 3 Aug 2012 10:09:23 +0100
From: Adam Dinwoodie <Adam.Dinwoodie@metaswitch.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Make `makewhatis` FAQ entry explicitly refer to `whatis`
Date: Fri, 03 Aug 2012 09:09:00 -0000
Deferred-Delivery: Fri, 3 Aug 2012 09:07:00 +0000
Message-ID: <CE9C056E12502146A72FD81290379E9A4365635D@ENFIRHMBX1.datcon.co.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
X-SW-Source: 2012-q3/txt/msg00012.txt.bz2

All,

Minor FAQ patch below to make it explicit that `makewhatis` is used for
`whatis` as well as `man -k` and `apropos`. Inspired by someone [apparently
being confused][0] on Stack Overflow (yes, they were almost certainly being
lazy, but I figure being more explicit will do no harm).

[0]: http://stackoverflow.com/questions/11774230/unix-cygwin-whatis-returns=
-all-commands-as-nothing-appropriate/11782300#comment15656666_11782300

I'm hoping this doesn't count as "significant" with regard to copyright
assignment. I'd really rather not have to deal with that tedium.

This is my first submitted patch; I *think* I've got everything right, but
apologies if not.

2012-08-03  Adam Dinwoodie  <Adam.Dinwoodie@...>

	* faq-using.xml (faq.using.man): Make relevance to whatis explicit.

Index: faq-using.xml
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/doc/faq-using.xml,v
retrieving revision 1.45
diff -u -p -r1.45 faq-using.xml
--- faq-using.xml       23 Apr 2012 22:10:37 -0000      1.45
+++ faq-using.xml       3 Aug 2012 08:55:03 -0000
@@ -238,7 +238,8 @@ related messages.
 </answer></qandaentry>

 <qandaentry id=3D"faq.using.man">
-<question><para>Why doesn't man -k (or apropos) work?</para></question>
+<question><para>Why doesn't <literal>man -k</literal>, <literal>apropos<li=
teral>
+or <literal>whatis</literal> work?</para></question>
 <answer>

 <para>Before you can use <literal>man -k</literal> or <literal>apropos</li=
teral>, you
