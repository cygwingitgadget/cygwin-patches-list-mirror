Return-Path: <cygwin-patches-return-3579-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14248 invoked by alias); 17 Feb 2003 18:52:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14231 invoked from network); 17 Feb 2003 18:52:23 -0000
Date: Mon, 17 Feb 2003 18:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030217185225.GD7514@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030217183026.GA7514@redhat.com> <20030217194118.P97990-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217194118.P97990-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00228.txt.bz2

On Mon, Feb 17, 2003 at 07:48:57PM +0100, Vaclav Haisman wrote:
>>Btw, now that I've said that it occurred to me to check
>>GetVolumeInformation.  There is apparently a FILE_SUPPORTS_SPARSE_FILES
>>flag available.  That's the ultimate way to deal with this rather than
>>adding a wincap, I believe.  Check (pc->fs.flags &
>>FILE_SUPPORTS_SPARSE_FILES) in fhandler_disk_file::open and do the
>>appropriate thing there.
>>
>>Sorry I didn't think of this before.
>
>I know about this flag and I have considered it when I started writing
>this patch.  It has one flaw.  The volume of root of the path to the
>file doesn't have to be the same volume as the file is physicaly stored
>on in case of reparse points presence.  Besides I don't see it as a
>problem if this call fails to set the sparseness becase the file system
>doesn't support it.

This is consistent with the way the rest of cygwin works, however.  The
same argument could be applied to testing for ntsec.  If this was an issue
then we should be changing the fs information to reflect reparse points.

cgf
