Return-Path: <cygwin-patches-return-2035-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1648 invoked by alias); 9 Apr 2002 07:55:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1561 invoked from network); 9 Apr 2002 07:55:51 -0000
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: ip.h & tcp.h
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Apr 2002 00:55:00 -0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008AC84@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <adah@netstd.com>,
	<cygwin-patches@cygwin.com>
X-SW-Source: 2002-q2/txt/msg00019.txt.bz2

You are missing the formatting and the header. ChangeLogs are TAB and
space sensitive - and have nothing to do with CVS.

Rob



-----Original Message-----
From: adah@netstd.com [mailto:adah@netstd.com]=20
Sent: Tuesday, April 09, 2002 3:38 PM
To: cygwin-patches@cygwin.com
Subject: Re: ip.h & tcp.h



Sorry but what more can I do? I consulted already=20

http://cygwin.com/contrib.html=20
http://www.gnu.org/prep/standards_42.html=20
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/ChangeLog
?cvsroot=3Dsrc=20

Should I add the struct names in parentheses?=20=20

[=20
        * ip.h (ip): Add definition for struct ip instead of including
<cygwin/ip.h>.
       * tcp.h (tcphdr): Add definition for struct tcphdr.
       * udp.h (udphdr): New file. Definition for struct udphdr.
]=20

Or what else am I missing?=20

Wu Yongwei=20

--- Original Message from Christopher Faylor ---=20

I give up.  Does someone else want to take a stab at this?

cgf
