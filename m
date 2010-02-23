Return-Path: <cygwin-patches-return-6973-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12397 invoked by alias); 23 Feb 2010 10:00:41 -0000
Received: (qmail 12373 invoked by uid 22791); 23 Feb 2010 10:00:40 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0 	tests=AWL,BAYES_00,TBC
X-Spam-Check-By: sourceware.org
Received: from demumfd002.nsn-inter.net (HELO demumfd002.nsn-inter.net) (93.183.12.31)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 23 Feb 2010 10:00:31 +0000
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55]) 	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id o1NA0Tl5030576 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2010 11:00:29 +0100
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id o1NA0Ste030734 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2010 11:00:28 +0100
Message-ID: <4B83A73C.1000208@towo.net>
Date: Tue, 23 Feb 2010 10:00:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.7) Gecko/20100111 Lightning/1.0b1 Thunderbird/3.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: terminfo [Re: console enhancements: mouse events etc]
References: <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net>  <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net> <20100126161036.GA31281@calimero.vinschen.de> <4B718CB8.7070308@towo.net> <4B72083C.2090205@cwilson.fastmail.fm>
In-Reply-To: <4B72083C.2090205@cwilson.fastmail.fm>
Content-Type: multipart/mixed;  boundary="------------000907000206060202000102"
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
X-SW-Source: 2010-q1/txt/msg00089.txt.bz2

This is a multi-part message in MIME format.
--------------000907000206060202000102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1278

>
> Thomas Wolff wrote:
>    
>> Actually, I just remember again that I though I should change the
>> terminfo entry too. Just - where's the source to patch?
>>      
> http://mirrors.kernel.org/sources.redhat.com/cygwin/release/terminfo/terminfo-5.7_20091114-13-src.tar.bz2
>
> That -src package is basically just a wrapper around terminfo.src from
> ncurses-5.7 (as of patch level 20091114).  So, the ultimate upstream
> source is actually ncurses.  But I split it out specifically so that we
> could do faster updates of terminfo (rebuilding all of ncurses simply to
> change two characters in /usr/share/terminfo/[63|c]/cygwin is rather silly).
>
> So, send me patches against terminfo.src from that -src tarball, and
> once we've got it figured out, I'll push it upstream to the ncurses
> maintainer.
>
>    
Sorry for the slightly late response. Attached is a small patch.
Two notes:
* I used the occasion to add PC graphics mode to the linux console, too, 
which have always been missing there.
* I patched "cygwinDBG" only for now, because if the patch goes 
upstream, the new VT100 graphics mode will not be available for remote 
login from an older cygwin console for a while. Feel free to modify the 
entry "cygwin" accordingly if you feel confident with it.

Thomas

--------------000907000206060202000102
Content-Type: text/plain;
 name="terminfo-diff.1.7.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="terminfo-diff.1.7.2"
Content-length: 630

769a770
> 	smpch=\E[11m, rmpch=\E[10m,
5307d5307
< 	acsc=+\020\,\021-\030.^Y0\333`\004a\261f\370g\361h\260j\331k\277l\332m\300n\305o~p\304q\304r\304s_t\303u\264v\301w\302x\263y\363z\362{\343|\330}\234~\376,
5325c5325
< 	rc=\E8, rev=\E[7m, ri=\EM, rmacs=\E[10m, rmir=\E[4l,
---
> 	rc=\E8, rev=\E[7m, ri=\EM, rmir=\E[4l,
5329,5330c5329,5332
< 	sgr0=\E[0;10m, smacs=\E[11m, smir=\E[4h, smso=\E[7m,
< 	smul=\E[4m, tbc=\E[3g, vpa=\E[%i%p1%dd, use=vt102+enq,
---
> 	sgr0=\E[0;10m, smir=\E[4h, smso=\E[7m,
> 	smul=\E[4m, tbc=\E[3g, vpa=\E[%i%p1%dd,
> 	smpch=\E[11m, rmpch=\E[10m, smacs=\E(0, rmacs=\E(B, ech=\E[%p1%dX,
> 	use=vt102+enq,

--------------000907000206060202000102--
