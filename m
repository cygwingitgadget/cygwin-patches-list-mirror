Return-Path: <cygwin-patches-return-5336-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26355 invoked by alias); 7 Feb 2005 21:37:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26331 invoked from network); 7 Feb 2005 21:37:34 -0000
Received: from unknown (HELO pmesmtp02.mci.com) (199.249.20.2)
  by sourceware.org with SMTP; 7 Feb 2005 21:37:34 -0000
Received: from pmismtp02.mcilink.com ([166.38.62.37])
 by firewall.wcom.com (Iplanet MTA 5.2)
 with ESMTP id <0IBK008589EM7H@firewall.wcom.com> for
 cygwin-patches@cygwin.com; Mon, 07 Feb 2005 21:37:34 +0000 (GMT)
Received: from pmismtp02.mcilink.com by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0IBK009019993U@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Mon, 07 Feb 2005 21:37:34 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.133.100])
 by pmismtp02.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0IBK008D09EKWQ@pmismtp02.mcilink.com> for
 cygwin-patches@cygwin.com; Mon, 07 Feb 2005 21:37:32 +0000 (GMT)
Date: Mon, 07 Feb 2005 21:37:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
In-reply-to: <20050207171925.GG19096@cygbert.vinschen.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0IBK008D19EKWQ@pmismtp02.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2005-q1/txt/msg00039.txt.bz2

So, what it really seems to boil down to is 
for those filesystems that support doing timestamp 
updating via FILE_WRITE_ATTRIBUTES (NTFS systems)
we should use FILE_WRITE_ATTRIBUTES, and for those that
don't (HPFS, etc), they should use GENERIC_WRITE?

Unfortunately, during my brief perusal of MSDN, I didn't see
an easy way to determine the file system type.  

I also see from the message you quoted that ntsec comes 
into play, but I think it still goes back to the filesystem, since
I have ntsec set, and the touch works on my box (using NTFS,
on our PDS shares (also running NTFS, I assume), but not
on my OS2/HPFS box.

On Mon, 07 Feb 2005 18:19:25 +0100, Corinna Vinschen wrote:

>On Feb  7 09:34, Mark Paulus wrote:
>> Attached is a patch that works to allow me to do a 
>> touch on my mounted HPFS filesystem.  I'm not sure
>> about clearcase, or others, but it works on HPFS and
>> NTFS. 
>> 
>> 	* times.cc: Use GENERIC_WRITE instead of FILE_WRITE_ATTRIBUTES.

>That's reverting a more than three years old patch.  Please read
>http://cygwin.com/ml/cygwin/2001-08/msg00666.html which explains why
>opening with GENERIC_WRITE is not generally a good idea.  If you want
>to get it working for HPFS or whatever, use the FS flags present in
>the local path_conv variable called win32 to conditionalize the call.


>Corinna

>-- 
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
>Red Hat, Inc.


