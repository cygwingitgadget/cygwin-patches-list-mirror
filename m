Return-Path: <cygwin-patches-return-3576-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5796 invoked by alias); 17 Feb 2003 18:20:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5787 invoked from network); 17 Feb 2003 18:20:38 -0000
Date: Mon, 17 Feb 2003 18:20:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: Max Bowsher <maxb@ukf.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
In-Reply-To: <00cf01c2d6ae$d2b906b0$78d96f83@pomello>
Message-ID: <20030217190440.R97036-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-0.5 required=5.0
	tests=CARRIAGE_RETURNS,IN_REP_TO,QUOTED_EMAIL_TEXT,
	      SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00225.txt.bz2


> That's nice. Did you read the bit above where I quoted MSDN? Merely setting
> the file as sparse will NOT SAVE SPACE on Windows. So, no space gain, and a
> performance penalty of untested magnitude. I see only disadvantages.
>
>
> Max.

Oh yes, it will. Some applications do lseek() on rather long distances, then
write few bytes, then do another lseek() etc. Without this Windows will
physicaly write zeros to the file which takes time and space. With this patch
regions of the file between the written bytes are not written to the file and
do not occupy any space.  Judging by
http://linux-ntfs.sourceforge.net/ntfs/concepts/data_runs.html there seems to
be same amount of metada as in case of non-sparse file.

Vaclav Haisman
