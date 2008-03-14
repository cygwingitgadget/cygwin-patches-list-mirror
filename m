Return-Path: <cygwin-patches-return-6290-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13268 invoked by alias); 14 Mar 2008 01:57:01 -0000
Received: (qmail 13254 invoked by uid 22791); 14 Mar 2008 01:57:01 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta05.westchester.pa.mail.comcast.net (HELO QMTA05.westchester.pa.mail.comcast.net) (76.96.62.48)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 14 Mar 2008 01:56:35 +0000
Received: from OMTA02.westchester.pa.mail.comcast.net ([76.96.62.19]) 	by QMTA05.westchester.pa.mail.comcast.net with comcast 	id 0jTg1Z02N0QuhwU550GK00; Fri, 14 Mar 2008 01:55:28 +0000
Received: from [192.168.0.103] ([67.166.125.73]) 	by OMTA02.westchester.pa.mail.comcast.net with comcast 	id 0pwP1Z0011b8C2B3N00000; Fri, 14 Mar 2008 01:56:24 +0000
X-Authority-Analysis: v=1.0 c=1 a=a9zRemn3zEgA:10 a=xe8BsctaAAAA:8  a=vBzBCeV9Z6l-T5khuK4A:9 a=tpXSmbZIh-U-qjDcuYyNRipiLw0A:4 a=eDFNAWYWrCwA:10  a=rPt6xJ-oxjAA:10
Message-ID: <47D9DB58.3090800@byu.net>
Date: Fri, 14 Mar 2008 01:57:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] recognise when an exec()d process terminates due to unhandled    exception
References: <47D9D8D3.17BC1E3B@dessent.net>
In-Reply-To: <47D9D8D3.17BC1E3B@dessent.net>
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
X-SW-Source: 2008-q1/txt/msg00064.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Brian Dessent on 3/13/2008 7:45 PM:
| Anyway, the attached patch fixes all that by adding logic to let the
| actual NTSTATUS logic percolate up to the waiting parent, so that it can
| recognise these kinds of common(ish) faults and print a friendly message
| -- or at least something other than silently dieing with no output.

Cool!  However, I haven't looked at the patch itself, yet.

| $ ./dll_not_found
| dll_not_found.exe: one or more DLLs that this program requires cannot be
| located by the system.  Make sure the PATH is correct and re-run the
| setup program to install any packages indicated as necessary to satisfy
| library dependencies.
| Killed

Should we also mention 'cygcheck ./dll_not_found' to find out which ones
are missing?

|
| $ ./missing_import
| missing_import.exe: an entry point for one of more symbols could not be
| found during program initialization.  Usually this means an incorrect
| or out of date version of one or more DLLs is being erroniously found
| on the PATH.
| Killed

s/erroniously/erroneously/

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkfZ21gACgkQ84KuGfSFAYCjQwCfdmAdES3oXUTF0rf9eMFCvDBJ
SbIAn1xfTEwKHZDUAloRo4VdvEt99xWJ
=W9DL
-----END PGP SIGNATURE-----
