Return-Path: <cygwin-patches-return-3133-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6301 invoked by alias); 7 Nov 2002 02:19:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6290 invoked from network); 7 Nov 2002 02:19:45 -0000
Date: Wed, 06 Nov 2002 18:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: utmp database manipulations patch
Message-ID: <20021107022144.GB6144@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ba01c285e4$620b2350$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ba01c285e4$620b2350$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00084.txt.bz2

On Wed, Nov 06, 2002 at 05:32:23PM -0500, Sergey Okhapkin wrote:
>The patch fixes some bugs in utmp database support and provides a new
>pututline() call.
>
>2002-11-06  Sergey Okhapkin  <sos@prospect.com.ru>
>
>        * cygwin.din (pututline): new exported function.
>        * syscalls.cc (login): Use pututiline().
>          (setutent): Open utmp as read/write.
>          (endutent): Check if utmp file is open.
>          (utmpname): call endutent() to close current utmp file.
>          (getutid): Enable all cases, use strncmp() to compare ut_id fields.
>          (pututline): New.
>        * tty.cc (create_tty_master): Set ut_pid to current pid.

Looks good to me.

I've checked this in, along with reformatting the ChangeLog and bumping
the API minor version number.

cgf
