Return-Path: <cygwin-patches-return-5210-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11936 invoked by alias); 16 Dec 2004 14:59:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11544 invoked from network); 16 Dec 2004 14:59:07 -0000
Received: from unknown (HELO omzesmtp02.mci.com) (199.249.17.9)
  by sourceware.org with SMTP; 16 Dec 2004 14:59:07 -0000
Received: from pmismtp01.mcilink.com ([166.38.62.36])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0I8T00IHTLMI8T@firewall.mci.com>; Thu,
 16 Dec 2004 14:59:06 +0000 (GMT)
Received: from pmismtp01.mcilink.com by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0I8T00H01LMESI@pmismtp01.mcilink.com>; Thu,
 16 Dec 2004 14:59:06 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.132.122])
 by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0I8T00H3TLMHQJ@pmismtp01.mcilink.com>; Thu,
 16 Dec 2004 14:59:06 +0000 (GMT)
Date: Thu, 16 Dec 2004 14:59:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: Patch to allow trailing dots on managed mounts
In-reply-to: <20041216023247.GA17763@trixie.casa.cgf.cx>
To: "cygwin@cygwin.com" <cygwin@cygwin.com>,
 "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0I8T00H3VLMIQJ@pmismtp01.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2004-q4/txt/msg00211.txt.bz2

On Wed, 15 Dec 2004 21:32:47 -0500, Christopher Faylor wrote:

>On Wed, Dec 15, 2004 at 04:04:13PM -0700, Mark Paulus wrote:
>>This patch is as trivial as I could get to allow trailing
>>dots to be used on a managed file system.
>>
>>Unfortunately, my company will not sign the waiver,
>>so I cannot sign up for any significant changes to
>>the cygwin sources.  So, hopefully, this patch is
>>small enough to squeek under the limit, or it can be a
>>starting point for discussions on how to fix the original
>>problem.
>>
>>    * path.cc (path_conv::check):  retain trailing dots and 
>>      spaces for managed mounts.

>Er, this patch apparently just leaves the trailing dots in the
>"converted" path, bypassing the loop which attempts to remove them.
>That's not the way to do this.  Sorry.


I am bypassing the loop which attemps to remove them, because for a
managed filesystem, I think they need to remain.

Consider the following snippets from my strace.out:

   40 2418062 [main] tar 1600 normalize_posix_path: /tmp1/usr/share/sgml/Netscape_Comm._Corp. = normalize_posix_path 
./usr/share/sgml/Netscape_Comm._Corp.)
   40 2418102 [main] tar 1600 mount_info::conv_to_win32_path: conv_to_win32_path (/tmp1/usr/share/sgml/Netscape_Comm._Corp)
   43 2418145 [main] tar 1600 set_flags: flags: binary (0x2)
   47 2418192 [main] tar 1600 mount_info::conv_to_win32_path: src_path /tmp1/usr/share/sgml/Netscape_Comm._Corp, dst c:\cygmanaged\usr\share\sgml\%
4Eetscape_%43omm._%43orp, flags 0x80A, rc 0

In the above, conv_to_win32_path removes the trailing dot, which creates a directory without the trailing dot.

now, further down the strace:
  265 2419810 [main] tar 1600 normalize_posix_path: src ./usr/share/sgml/Netscape_Comm._Corp./dtd
   41 2419851 [main] tar 1600 cwdstuff::get: posix /tmp1
   38 2419889 [main] tar 1600 cwdstuff::get: (/tmp1) = cwdstuff::get (0x22EA50,260, 1, 0), errno 0
   38 2419927 [main] tar 1600 normalize_posix_path: /tmp1/usr/share/sgml/Netscape_Comm._Corp./dtd = normalize_posix_path 
(./usr/share/sgml/Netscape_Comm._Corp./dtd)
   39 2419966 [main] tar 1600 mount_info::conv_to_win32_path: conv_to_win32_path (/tmp1/usr/share/sgml/Netscape_Comm._Corp./dtd)
   42 2420008 [main] tar 1600 set_flags: flags: binary (0x2)
   47 2420055 [main] tar 1600 mount_info::conv_to_win32_path: src_path /tmp1/usr/share/sgml/Netscape_Comm._Corp./dtd, dst c:\cygmanaged\usr\share
\sgml\%4Eetscape_%43omm._%43orp%2E\dtd, flags 0x80A, rc 0

Here, tar is going to look for a directory that cygwin clearly thinks should have a dot at the end (the %2E), and it's going to fail
because it's not going to find it, since the directory was created above without the %2E.  

Other than the way I proposed, I'm not sure how to fix this, since the issue seems to be that
conv_to_win32_path() needs to get the trailing dot in it's input argument, and check() is
stripping it out.  The only way I can see to fix this behaviour is to leave the trailing dots 
in the string.  Maybe conv_to_win32_path needs to deal/strip with the trailing dots, depending
upon whether it's a managed filesystem or not?


>cgf


