Return-Path: <cygwin-patches-return-3336-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21097 invoked by alias); 16 Dec 2002 19:34:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21074 invoked from network); 16 Dec 2002 19:34:56 -0000
Date: Mon, 16 Dec 2002 11:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] to_slave pipe is full fix
Message-ID: <20021216193629.GB19567@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021215144314.A28430@eris.io.com> <20021216170122.G19104@cygbert.vinschen.de> <20021216131554.D30600@hagbard.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216131554.D30600@hagbard.io.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00287.txt.bz2

On Mon, Dec 16, 2002 at 01:15:54PM -0600, Steve O wrote:
>On Mon, Dec 16, 2002 at 05:01:22PM +0100, Corinna Vinschen wrote:
>> did you perhaps forgot to attach the patch?
>
>My apologies, the patch is enclosed this time.
>-steve
>
>ChangeLog:
>2002-12-15  Steve Osborn  <bub@io.com>
>
>    * fhandler_termios.cc (fhandler_termios::line_edit): Return
>    line_edit_error and remove last char from readahead buffer
>    if accept_input() fails.
>    * fhandler_tty.cc (fhandler_pty_master::accept_input): Return 0
>    and restore readahead buffer when tty slave pipe is full.

-             SetEvent (input_available_event);
-             ReleaseMutex (input_mutex);
-             Sleep (10);
-             rc = WaitForSingleObject (input_mutex, INFINITE);
+             puts_readahead (p, bytes_left);
+             ret = 0;
+             break;

Won't this introduce a spinning situation since you are no longer
sleeping?  Were we really inappropriately waiting for the input_mutex in
this case?

cgf
