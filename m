Return-Path: <cygwin-patches-return-2030-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30533 invoked by alias); 9 Apr 2002 02:55:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30513 invoked from network); 9 Apr 2002 02:55:03 -0000
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: ip.h & tcp.h
Message-ID: <OF4012B05E.A8B4D21F-ON48256B96.000E68E5@netstd.com>
From: adah@netstd.com
Date: Mon, 08 Apr 2002 19:55:00 -0000
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=_alternative 000FFE5148256B96_="
X-SW-Source: 2002-q2/txt/msg00014.txt.bz2

This is a multipart message in MIME format.
--=_alternative 000FFE5148256B96_=
Content-Type: text/plain; charset="us-ascii"
Content-length: 2347

OK, I am trying again.

ChangeLog:

Definitions for struct ip, tcphdr, and udphdr from BSD are added.


I hope I can do better next time. Sorry for not reading the contrib page 
very carefully.

Regards,

Wu Yongwei




On Tue, Apr 09, 2002 at 09:56:37AM +0800, Wu Yongwei wrote:
>ChangeLog: BSD-style header files ip.h, tcp.h, and udp.h are added, which
>include definitions for IP, TCP, and UDP packet header structures.

>Positions:
>* ip.h.diff is against /usr/include/netinet/ip.h
>* tcp.h.diff is against /usr/include/netinet/tcp.h
>* udp.h should be added to /usr/include/netinet
>* ip.h in /usr/include/cygwin contains only a comment and I suppose it 
could
>be dropped.
>
>
>BSD licence:
>1. Redistributions of source code must retain the above copyright
>   notice, this list of conditions and the following disclaimer.
>2. Redistributions in binary form must reproduce the above copyright
>   notice, this list of conditions and the following disclaimer in the
>   documentation and/or other materials provided with the distribution.
>3. All advertising materials mentioning features or use of this software
>   must display the following acknowledgement:
>     This product includes software developed by the University of
>     California, Berkeley and its contributors.
>4. Neither the name of the University nor the names of its contributors
>   may be used to endorse or promote products derived from this software
>   without specific prior written permission.
>
>Best regards,

1) Patches just to cygwin-patches, please.

2) Your ChangeLog is incorrect.

3) Please submit 1 (one) patch for everything rather than one patch per 
file.
   It just makes a reviewer's life harder if you submit multiple patches 
as
   attachments.  If your mailer allows you to submit patches inline 
without
   screwing up spacing that is preferred.

4) The diffs and ChangeLog should make it very obvious what is being 
changed.
   There is no need for more words at this point.  If this was your first
   submission asking for a change to Cygwin, then, sure, add a 
description.
   You've already beaten this subject to death, however, so there is no 
need
   for more justification.

None of the above is a show stopper except for 2.  As I predicted, your
ChangeLog is incorrect.  Go back to the web page that I keep mentioning
to see why.

cgf


--=_alternative 000FFE5148256B96_=
Content-Type: text/html; charset="us-ascii"
Content-length: 3041


<br><font size=2 face="sans-serif">OK, I am trying again.</font>
<br>
<br><font size=2 face="sans-serif">ChangeLog:</font>
<br>
<br><font size=2 face="sans-serif">Definitions for struct ip, tcphdr, and udphdr from BSD are added.</font>
<br>
<br>
<br><font size=2 face="sans-serif">I hope I can do better next time. Sorry for not reading the contrib page very carefully.</font>
<br>
<br><font size=2 face="sans-serif">Regards,</font>
<br>
<br><font size=2 face="sans-serif">Wu Yongwei</font>
<br>
<br>
<br>
<br>
<br><font size=2><tt>On Tue, Apr 09, 2002 at 09:56:37AM +0800, Wu Yongwei wrote:<br>
&gt;ChangeLog: BSD-style header files ip.h, tcp.h, and udp.h are added, which<br>
&gt;include definitions for IP, TCP, and UDP packet header structures.<br>
<br>
&gt;Positions:<br>
&gt;* ip.h.diff is against /usr/include/netinet/ip.h<br>
&gt;* tcp.h.diff is against /usr/include/netinet/tcp.h<br>
&gt;* udp.h should be added to /usr/include/netinet<br>
&gt;* ip.h in /usr/include/cygwin contains only a comment and I suppose it could<br>
&gt;be dropped.<br>
&gt;<br>
&gt;<br>
&gt;BSD licence:<br>
&gt;1. Redistributions of source code must retain the above copyright<br>
&gt; &nbsp; notice, this list of conditions and the following disclaimer.<br>
&gt;2. Redistributions in binary form must reproduce the above copyright<br>
&gt; &nbsp; notice, this list of conditions and the following disclaimer in the<br>
&gt; &nbsp; documentation and/or other materials provided with the distribution.<br>
&gt;3. All advertising materials mentioning features or use of this software<br>
&gt; &nbsp; must display the following acknowledgement:<br>
&gt; &nbsp; &nbsp; This product includes software developed by the University of<br>
&gt; &nbsp; &nbsp; California, Berkeley and its contributors.<br>
&gt;4. Neither the name of the University nor the names of its contributors<br>
&gt; &nbsp; may be used to endorse or promote products derived from this software<br>
&gt; &nbsp; without specific prior written permission.<br>
&gt;<br>
&gt;Best regards,<br>
<br>
1) Patches just to cygwin-patches, please.<br>
<br>
2) Your ChangeLog is incorrect.<br>
<br>
3) Please submit 1 (one) patch for everything rather than one patch per file.<br>
 &nbsp; It just makes a reviewer's life harder if you submit multiple patches as<br>
 &nbsp; attachments. &nbsp;If your mailer allows you to submit patches inline without<br>
 &nbsp; screwing up spacing that is preferred.<br>
<br>
4) The diffs and ChangeLog should make it very obvious what is being changed.<br>
 &nbsp; There is no need for more words at this point. &nbsp;If this was your first<br>
 &nbsp; submission asking for a change to Cygwin, then, sure, add a description.<br>
 &nbsp; You've already beaten this subject to death, however, so there is no need<br>
 &nbsp; for more justification.<br>
<br>
None of the above is a show stopper except for 2. &nbsp;As I predicted, your<br>
ChangeLog is incorrect. &nbsp;Go back to the web page that I keep mentioning<br>
to see why.<br>
<br>
cgf<br>
</tt></font>
<br>
--=_alternative 000FFE5148256B96_=--
