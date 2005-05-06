Return-Path: <cygwin-patches-return-5425-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27951 invoked by alias); 6 May 2005 04:13:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27935 invoked from network); 6 May 2005 04:13:42 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 6 May 2005 04:13:42 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 468A713C7E2; Fri,  6 May 2005 00:13:42 -0400 (EDT)
Date: Fri, 06 May 2005 04:13:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: mkdir -p and network drives
Message-ID: <20050506041342.GA27322@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00021.txt.bz2

On Thu, May 05, 2005 at 10:57:08PM -0400, Pierre A. Humblet wrote:
>
>Here is a patch to allow mkdir -p to easily work with network
>drives and to allow future enumeration of computers and of
>network drives by ls -l.
>
>It works by defining a new FH_NETDRIVE virtual handler for
>names such as // and //machine.
>This also makes chdir work without additional change.
>
>The code for the new handler is currently in fhandler_virtual.cc, for
>simplicity (not an expert on Makefile and fomit-frame-pointer).
>It should eventually be placed in fhandler_netdrive.cc

Yes.

>The code should handle "//" correctly, but path.cc still transforms it
>into "/", because of the bash bug.

Is that fixed in the current bash?

>I have directly edited devices.cc instead of using the devices.in
>magic.

I think that the fact that we have to check for //foo/bar in
mount_info::conv_to_win32_path indicates some kind of design flaw -- not
one that you introduced, of course.  I just don't think that this
function should be getting paths that are known not to be associated
with the mount table.  I would have expected that a //foo/bar style path
would not have made it down that far.  I also notice that the cygdrive
comment has been misplaced over time.  Could you fix that when you check
this in?

I just checked in a dummy fhandler_netdrive.cc, added
fhandler_netdrive.o to the Makefile, added FH_NETDRIVE to devices.h,
defined dev_netdrive_storage in devices.in, and regenerated devices.in.
So, I'd appreciate it if you would just move your fhandler_netdrive
stuff to fhandler_netdrive.cc.

I didn't renumber FH_FS with above change.  I wasn't sure why you did
that.  I don't think that there was a requirement that it has to be the
lowest numbered minor device number.  If there is a requirement like
that we should change it.

Anyway, feel free to check this in.

>About implementing readdir: PTC...

I was thinking about doing this but how would it ever be invoked?
You can't do an opendir on "//", right?

cgf
