Return-Path: <cygwin-patches-return-5339-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9827 invoked by alias); 8 Feb 2005 21:38:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9782 invoked from network); 8 Feb 2005 21:38:37 -0000
Received: from unknown (HELO omzesmtp03.mci.com) (199.249.17.11)
  by sourceware.org with SMTP; 8 Feb 2005 21:38:37 -0000
Received: from pmismtp01.mcilink.com ([166.38.62.36])
 by firewall.mci.com (Iplanet MTA 5.2)
 with ESMTP id <0IBM00MKI44DTZ@firewall.mci.com> for cygwin-patches@cygwin.com;
 Tue, 08 Feb 2005 21:38:37 +0000 (GMT)
Received: from pmismtp01.mcilink.com by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with SMTP id <0IBM009013XLT8@pmismtp01.mcilink.com> for
 cygwin-patches@cygwin.com; Tue, 08 Feb 2005 21:38:37 +0000 (GMT)
Received: from WS117V6220509.mcilink.com ([166.34.133.100])
 by pmismtp01.mcilink.com
 (iPlanet Messaging Server 5.2 HotFix 1.14 (built Mar 18 2003))
 with ESMTP id <0IBM0096S43FSM@pmismtp01.mcilink.com> for
 cygwin-patches@cygwin.com; Tue, 08 Feb 2005 21:38:04 +0000 (GMT)
Date: Tue, 08 Feb 2005 21:38:00 -0000
From: Mark Paulus <mark.paulus@mci.com>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
In-reply-to: <20050208091029.GM19096@cygbert.vinschen.de>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-id: <0IBM0096T43FSM@pmismtp01.mcilink.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Priority: Normal
X-SW-Source: 2005-q1/txt/msg00042.txt.bz2

Well, all I can say, is "That's Uuuugggllleeeyyyyy".....

When I print fsname on the HPFS mounted volume, 
I get back '??SS'.  What the heck is that???  Somehow,
I'm guessing that's not something I want to be doing a 
string comparison on, for any kind of stability purpose.

Guess I'll live with not being able to 'touch' on mounted
HPFS volumes, and not do builds on that remote volume.

Sheesh, what a pain.  Thanks for the pointers, tho.



On Tue, 08 Feb 2005 10:10:29 +0100, Corinna Vinschen wrote:

>On Feb  7 14:37, Mark Paulus wrote:
>> So, what it really seems to boil down to is 
>> for those filesystems that support doing timestamp 
>> updating via FILE_WRITE_ATTRIBUTES (NTFS systems)
>> we should use FILE_WRITE_ATTRIBUTES, and for those that
>> don't (HPFS, etc), they should use GENERIC_WRITE?

>Yes.  I'm wondering though, if that's the filesystem or OS/2 which
>choke on FILE_WRITE_ATTRIBUTES.

>> Unfortunately, during my brief perusal of MSDN, I didn't see
>> an easy way to determine the file system type.  

>Have a look into path.cc, fs_info::update ().  Test the filesystem
>name in fs_info::update and add a flag to fs_info which tells us that
>FILE_WRITE_ATTRIBUTES is supported (which is valid for NTFS and FAT,
>btw.).


>Corinna

>-- 
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
>Red Hat, Inc.


