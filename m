Return-Path: <cygwin-patches-return-3322-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11852 invoked by alias); 15 Dec 2002 20:42:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11843 invoked from network); 15 Dec 2002 20:42:05 -0000
Date: Sun, 15 Dec 2002 12:42:00 -0000
From: Steve O <bub@io.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] to_slave pipe is full fix
Message-ID: <20021215144314.A28430@eris.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-SW-Source: 2002-q4/txt/msg00273.txt.bz2

Hi,
Here is the next tty patch.  The previous patches have provided
the ground work for accept_input () to fail.  This patch makes accept_input
fail if the slave tty pipe is full.  In the current cygwin code this
will only get called in rather extreme situations. 

Thanks,
-steve

ChangeLog:
2002-12-15  Steve Osborn  <bub@io.com>

	* fhandler_termios.cc (fhandler_termios::line_edit): Return 
	line_edit_error and remove last char from readahead buffer 
	if accept_input() fails.
	* fhandler_tty.cc (fhandler_pty_master::accept_input): Return 0 
	and restore readahead buffer when tty slave pipe is full.
