Return-Path: <cygwin-patches-return-3577-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7667 invoked by alias); 17 Feb 2003 18:30:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7620 invoked from network); 17 Feb 2003 18:30:24 -0000
Date: Mon, 17 Feb 2003 18:30:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030217183026.GA7514@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00cf01c2d6ae$d2b906b0$78d96f83@pomello> <20030217190440.R97036-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217190440.R97036-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00226.txt.bz2

On Mon, Feb 17, 2003 at 07:20:42PM +0100, Vaclav Haisman wrote:
>>That's nice.  Did you read the bit above where I quoted MSDN?  Merely
>>setting the file as sparse will NOT SAVE SPACE on Windows.  So, no
>>space gain, and a performance penalty of untested magnitude.  I see
>>only disadvantages.
>
>Oh yes, it will.  Some applications do lseek() on rather long
>distances, then write few bytes, then do another lseek() etc.  Without
>this Windows will physicaly write zeros to the file which takes time
>and space.  With this patch regions of the file between the written
>bytes are not written to the file and do not occupy any space.  Judging
>by http://linux-ntfs.sourceforge.net/ntfs/concepts/data_runs.html there
>seems to be same amount of metada as in case of non-sparse file.

lseeks were what I was thinking of when I suggested just following the UNIX
convention.

Is anyone willing to run a few simple benchmarks to see if there is a
drawback to turning sparseness on for everything on an NTFS file system?

Btw, now that I've said that it occurred to me to check
GetVolumeInformation.  There is apparently a FILE_SUPPORTS_SPARSE_FILES
flag available.  That's the ultimate way to deal with this rather than
adding a wincap, I believe.  Check (pc->fs.flags &
FILE_SUPPORTS_SPARSE_FILES) in fhandler_disk_file::open and do the
appropriate thing there.

Sorry I didn't think of this before.

cgf
