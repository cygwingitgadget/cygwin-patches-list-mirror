Return-Path: <cygwin-patches-return-2034-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23148 invoked by alias); 9 Apr 2002 05:44:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23057 invoked from network); 9 Apr 2002 05:44:58 -0000
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: ip.h & tcp.h
Message-ID: <OFE233EE2E.A09ACC76-ON48256B96.001EBD45@netstd.com>
From: adah@netstd.com
Date: Mon, 08 Apr 2002 22:44:00 -0000
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=_alternative 001F94F448256B96_="
X-SW-Source: 2002-q2/txt/msg00018.txt.bz2

This is a multipart message in MIME format.
--=_alternative 001F94F448256B96_=
Content-Type: text/plain; charset="us-ascii"
Content-length: 627

Sorry but what more can I do? I consulted already

http://cygwin.com/contrib.html
http://www.gnu.org/prep/standards_42.html
http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/ChangeLog?cvsroot=src

Should I add the struct names in parentheses?
[
        * ip.h (ip): Add definition for struct ip instead of including 
<cygwin/ip.h>.
        * tcp.h (tcphdr): Add definition for struct tcphdr.
        * udp.h (udphdr): New file. Definition for struct udphdr.
]

Or what else am I missing?

Wu Yongwei

--- Original Message from Christopher Faylor ---

I give up.  Does someone else want to take a stab at this?

cgf
--=_alternative 001F94F448256B96_=
Content-Type: text/html; charset="us-ascii"
Content-length: 1470


<br><font size=2 face="Courier New">Sorry but what more can I do? I consulted already</font>
<br>
<br><a href=http://cygwin.com/contrib.html><font size=2 color=blue face="Courier New"><u>http://cygwin.com/contrib.html</u></font></a>
<br><a href=http://www.gnu.org/prep/standards_42.html><font size=2 color=blue face="Courier New"><u>http://www.gnu.org/prep/standards_42.html</u></font></a>
<br><a href="http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/ChangeLog?cvsroot=src"><font size=2 color=blue face="Courier New"><u>http://sources.redhat.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/ChangeLog?cvsroot=src</u></font></a>
<br>
<br><font size=2 face="Courier New">Should I add the struct names in parentheses?</font>
<br><font size=2 face="Courier New">[</font>
<br><font size=2 face="Courier New">&nbsp; &nbsp; &nbsp; &nbsp; * ip.h (ip): Add definition for struct ip instead of including &lt;cygwin/ip.h&gt;.<br>
 &nbsp; &nbsp; &nbsp; &nbsp;* tcp.h (tcphdr): Add definition for struct tcphdr.<br>
 &nbsp; &nbsp; &nbsp; &nbsp;* udp.h (udphdr): New file. Definition for struct udphdr.<br>
]</font>
<br>
<br><font size=2 face="Courier New">Or what else am I missing?</font>
<br>
<br><font size=2 face="Courier New">Wu Yongwei</font>
<br>
<br><font size=2 face="Courier New">--- Original Message from Christopher Faylor&nbsp;---</font>
<br>
<br><font size=2 face="Courier New">I give up.&nbsp; Does someone else want to take a stab at this?<br>
<br>
cgf</font>
--=_alternative 001F94F448256B96_=--
