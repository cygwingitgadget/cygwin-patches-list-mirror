Return-Path: <cygwin-patches-return-2235-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8364 invoked by alias); 27 May 2002 17:43:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8350 invoked from network); 27 May 2002 17:43:57 -0000
Date: Mon, 27 May 2002 10:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] improve performance of stat() operations (e.g. ls -lR )
Message-ID: <20020527174354.GB21314@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FE045D4D9F7AED4CBFF1B3B813C85337676295@mail.sandvine.com> <20020527011013.GA15710@redhat.com> <024701c2051d$e13cbdc0$6132bc3e@BABEL> <20020527022339.GA15585@redhat.com> <20020527142437.A26046@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020527142437.A26046@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00219.txt.bz2

On Mon, May 27, 2002 at 02:24:37PM +0200, Corinna Vinschen wrote:
>On Sun, May 26, 2002 at 10:23:39PM -0400, Chris Faylor wrote:
>> You can get nearly all of the information that you need from
>> FindFirstFile.  Unfortunately, GetFileInformationByHandle() seems to be
>> the only available function which returns the hard link count of a file.
>
>What about taking the FS into account here?  We could perhaps speedup
>stat() for FAT/FAT32 since the hard link count is always 1 for files
>then.  We could completely skip the open() call if the file isn't
>already open (as in fstat(2)).  The FS info is already available from
>path_conv::check().

Yes, I have a patch that I'm working on which does this.  I really do
hate having two different code paths for different filesystems, though.
Too bad there isn't an os-specific way of finding out if a filesystem
handles hard links or not.

I've revamped some of fstat to remove some of the excess OS calls, too.
In the process of researching this, I discovered that NT has a mechanism
for determining a filename from an open handle so I'm trying to work
that into dtable.cc.  I've seen hints that something similar is possible
in Windows 9x but I haven't tracked down any code yet.

cgf
