Return-Path: <cygwin-patches-return-3111-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23609 invoked by alias); 4 Nov 2002 04:08:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23560 invoked from network); 4 Nov 2002 04:08:30 -0000
Date: Sun, 03 Nov 2002 20:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_serial fix
Message-ID: <20021104041023.GA16950@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <006b01c283b1$b33bb580$0201a8c0@sos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006b01c283b1$b33bb580$0201a8c0@sos>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00062.txt.bz2

On Sun, Nov 03, 2002 at 10:24:33PM -0500, Sergey Okhapkin wrote:
>The patch fixes a crash when ioctl(fd, TCFLSH, how) is called for a serial
>port.
>
>2002-11-03  Sergey Okhapkin  <sos@prospect.com.ru>
>
>        * fhandler_serial.cc (fhandler_serial::ioctl): the 3rd argument of
>        ioctl(fd, TCFLSH, ...) is integer but not a pointer.

Thanks, but I don't think this is exactly the right solution for this
problem.  I'd rather see the handling of all of the cmds grouped in
the switch statement.

This function needed a lot of work.  There were some obvious typos (use
of a '|' where a '||' was intended) and a suspicious lack of errno
setting.  I'm going to check in a reformatting of the function which
will hopefully address the above problem as well as these others.

I wasn't sure about a couple of the errnos.  If you, or anyone has any
insight into what should be returned int the cases where I defaulted to
EINVAL, it would be appreciated.

cgf
