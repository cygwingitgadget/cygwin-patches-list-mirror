Return-Path: <cygwin-patches-return-3885-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16430 invoked by alias); 24 May 2003 17:55:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16421 invoked from network); 24 May 2003 17:55:30 -0000
Date: Sat, 24 May 2003 17:55:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Proposed change for Win9x file permissions...
Message-ID: <20030524175530.GB5604@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00112.txt.bz2

On Fri, May 23, 2003 at 05:01:43PM -0400, Bill C. Riemers wrote:
>Actually there are two patches.  The first one is to fhandler_disk_file.cc.
>This changes the fstat()
>function to show Win9x permissions masked by the "umask".  This is the same
>thing early versions of
>the Linux FAT driver did, before "umask" was added as a mount option.
>Obviously that would be the better solution for Cygwin as well.  However, I
>decided try the simpler option of just using the normal umask first.
>
>This allows utilities like sshd to work as expected simply by wrapping them
>in a script like:
>
>    #!/bin/bash
>    umask 0077;exec /usr/sbin/sshd "$@"
>
>Of course there will be unexpected side effects if someone doesn't realize
>that umask is used this way...   But it will probably be less problematic
>than having completely unchangeable permissions
>under Win9x.

I like the idea but I'm wondering if it is too general.  Corinna, what do
you think?

>The second patch corrects an obvious typo in winusers.h that prevents the
>current CVS code from compiling.

Two patches == two email messages.  Please don't put two disparate patches
in one message.

Also, you're missing a ChangeLog entry.  Please look at the ChangeLog
entries in the cygwin directory and match them for formatting case,
tense, and style.

cgf
