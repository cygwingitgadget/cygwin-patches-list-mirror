Return-Path: <cygwin-patches-return-2420-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23535 invoked by alias); 13 Jun 2002 17:32:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23492 invoked from network); 13 Jun 2002 17:32:04 -0000
Date: Thu, 13 Jun 2002 10:32:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Small Patch
Message-ID: <20020613173232.GC26261@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D08D0E6.2090105@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D08D0E6.2090105@netscape.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00403.txt.bz2

On Thu, Jun 13, 2002 at 01:05:42PM -0400, Nicholas Wourms wrote:
>This is a patch to a few files to update the copyright year and fix a 
>minor spelling error.

Thanks for the heads up.  IMO, comment changes fall into the "documentation"
category.  Changes to comments should be self-explanatory and should not
require a ChangeLog entry.  Opinions on this seem to vary.  However,
since I was the person checking this in, I opted to only include an
entry for yuor winver.rc change.  Since I didn't know what a "DBA" was I
changed the changelog entry for that.

I didn't make changes to every file that you included since some of them hadn't
been updated in 2002.  As far as I understand things, that means that we
shouldn't add a 2002 to the copyright.

Thanks for noticing this.  I just took a sweep through the sources a while ago
but I missed these files.

cgf

>ChangeLog:
>2002-06-05  Nicholas S. Wourms <nwourms@netscape.net>
>
>        * shared_info.h: Change copyright to include 2002.
>        * shortcut.c: Change copyright to include 2002.
>        * shortcut.h: Correct spelling error and changed copyright to include
>        2002.
>        * smallprint.c: Change copyright to include 2002.
>        * string.h: Change copyright to include 2002.
>        * sync.h: Change copyright to include 2002.
>        * syslog.cc: Change copyright to include 2002.
>        * textmode.c: Change copyright to include 2002.
>        * thread.h: Removed duplicate copyright entry.
>        * threaded_queue.h: Change copyright to include 2002.
>        * wincap.h: Change copyright to include 2002.
>        * winver.rc (LegalCopyright): Change copyright to include RedHat's full
>        DBA name and to include 2002.
